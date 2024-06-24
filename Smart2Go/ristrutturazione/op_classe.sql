create or replace function fine(thisFine integer)
returns timestamp as $$
begin
    return (
        select n.inizio + make_interval(mins => fin.durataMinuti)
        from Noleggio n, FineNoleggio fin
        where n.id = thisFine and fin.noleggio = thisFine
    );
end;
$$ language plpgsql;

create or replace function utilizzata(thisAuto TargaAuto, t timestamp)
returns boolean as $$
begin
    return exists (
        select *
        from Noleggio n
        where n.auto = thisAuto and n.inizio >= t and fine(n.id) <= t
    );
end;
$$ language plpgsql;

create or replace function abituale(thisAccettato CodiceFiscale)
returns boolean as $$
declare
    totOre IntegerGEZ = 0;
begin
    select sum(date_part('hour',fine(n.id)-n.inizio))
    into totOre
    from Noleggio n, FineNoleggio fin
    where n.socio = thisAccettato and fin.noleggio = n.id and date_part('year',current_timestamp)-1 >= date_part('year',n.inizio);

    if exists (
        select *
        from Dipendente d
        where d.socio = thisAccettato
    ) then
        return totOre >= 60;
    end if;
    return totOre >= 100;

end;
$$ language plpgsql;

create or replace function rischio(thisAbituale CodiceFiscale,t timestamp)
returns ClasseRischio as $$
declare
    numSinistri IntegerGEZ = 0;
begin
    select count(s.noleggio)
    into numSinistri
    from Noleggio n,Sinistro s
    where n.socio = thisAbituale and s.noleggio = n.id and n.inizio <= t and not exists (
        select *
        from FineNoleggio fin
        where fin.noleggio = n.id and fine(fin.noleggio) > t
    );

    if numSinistri <= 10 then return numSinistri; end if;
    return 10;
end;
$$ language plpgsql;

create or replace function convenzione(thisSocieta RagSoc,aut TargaAuto)
returns String as $$
begin
    return (
        select con.nome
        from Auto a, Modello m, cat_per cp,Convenzione con,con_soc cs
        where a.targa = aut and a.modello = m.nome and (
            (not exists(
                select *
                from Ecocompatibile e
                where e.modello = m.nome
            ) or (cs.convenzione = con.nome and cs.societa = thisSocieta and con.tipo = 'PerEcocompatibili'))
                and
            (exists (
                select *
                from Ecocompatibile e
                where e.modello = m.nome
            ) or (cp.categoria = m.categoria and cp.convenzione = con.nome and cs.convenzione = con.nome and cs.societa = thisSocieta))
        )
    );
end;
$$ language plpgsql;

create or replace function costo(thisFine integer, t timestamp)
returns Denaro as $$
declare
    classe ClasseRischio = null;
    scontoClasse real = 0;
    abi boolean = null;
    scontoAbituale real = 0;
    scontoConvenzione real = 0;
    costoOriginale Denaro = 0;
begin
    if fine(thisFine) > t then raise exception 'Error 001 - fine maggiore di t'; end if;

    select rischio(a.socio,t),abituale(a.socio)
    into classe,abi
    from Accettato a,Noleggio n
    where a.socio = n.socio and n.id = thisFine;

    if classe <= 2 then scontoClasse = 0.1;
    elsif classe > 5 then scontoClasse = classe/-10;
    end if;

    if abi then scontoAbituale = 0.25; end if;

    select c.percentuale
    into scontoConvenzione
    from Noleggio n,Dipendente d,Convenzione c
    where n.id = thisFine and d.socio = n.socio and convenzione(d.societa,n.auto) = c.nome;

    if scontoConvenzione is null then scontoConvenzione = 0; end if;

    select c.tariffaMinuto*fin.durataMinuti
    into costoOriginale
    from FineNoleggio fin,Noleggio n,Auto a, Modello m, Categoria c
    where fin.noleggio = thisFine and n.id = thisFine and a.targa = n.auto and m.nome = a.modello 
    and m.categoria = c.nome;

    costoOriginale := costoOriginale - (costoOriginale*scontoConvenzione);
    costoOriginale := costoOriginale - (costoOriginale*scontoClasse);
    costoOriginale := costoOriginale - (costoOriginale*scontoConvenzione);

    return costoOriginale;

end;
$$ language plpgsql;

create or replace function utilizzata(thisAuto TargaAuto, t timestamp)
returns boolean as $$
begin
    return exists (
        select
        from Noleggio n
        where n.auto = thisAuto and n.inizio >= t and (fine(n.id) is null or fine(n.id) <= t)
    );
end;
$$ language plpgsql;