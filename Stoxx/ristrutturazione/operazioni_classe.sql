
-- Operazioni classe FondoGestito

create or replace function percentualeAzioni(thisFondo integer)
returns RealGEZ as $$
begin
    return (
        select f.numAzioni::real/(f.numAzioni::real+f.numObbligazioni::real+f.numTitoliDiStato::real)
        from FondoGestito f
        where f.strumento = thisFondo
    );
end;
$$ language plpgsql;

-- Operazioni classe StrumentoFinanziario

create or replace function valore(thisStrumento integer, t timestamp)
returns Denaro as $$
begin
    if not exists (
        select *
        from Rilevazione r
        where r.strumento = thisStrumento and r.istante <= t
    ) then raise exception 'Error 001 - non esiste rilevazione'; end if;

    return (
        with ril as (
            select r.id, r.istante, r.valore
            from Rilevazione r
            where r.strumento = thisStrumento and r.istante <= t
        ), mas as (
            select max(r.istante)
            from ril r
        )
        select r.valore
        from ril r,mas m
        where r.istante = m.max
    );

end;
$$ language plpgsql;

-- Operazioni classe Investimento

create or replace function valoreIN(thisInvestimento integer,t timestamp)
returns Denaro as $$
begin

    if not exists (
        select *
        from Investimento i
        where i.id = thisInvestimento and i.istante <= t
    ) then raise exception 'Error 002 - t minore dell istante investimento'; end if;

    return (
        with dis as (
            select d.id,d.quantita
            from Disinvestimento d
            where d.investimento = thisInvestimento and d.istante <= t
        )
        select ((i.quantita - sum(d.quantita))*valore(i.strumento,t))
        from Investimento i,dis d
        where i.id = thisInvestimento
        group by i.id
    );
end;
$$ language plpgsql;