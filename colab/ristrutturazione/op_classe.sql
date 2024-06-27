-- Operazioni classe Impresa

create or replace function utentiGestiti(thisImpresa integer, i date,f date)
returns table(utente Email) as $$
begin
    if i > f then raise exception 'Error 001 - inizio dopo la fine'; end if;

    return query
        select u.indEmail
        from Utente u,utilizza ut,Abbonamento a
        where u.indEmail = ut.utente and ut.abbonamento = a.id and a.inizio >= i 
		and a.inizio <= f and a.comprato = thisImpresa;
end;
$$ language plpgsql;

-- Operazione classe Abbonamento

create or replace function fineAbbonamento(thisAbbonamento integer)
returns date as $$
begin
    return (
        select t.durataGiorni + a.inizio
        from TipologiaAbbonamento t,Abbonamento a
        where a.id = thisAbbonamento and a.tipologia = t.id
    );
end;
$$ language plpgsql;

create or replace function inCorso(thisAbbonamento integer,t timestamp)
returns boolean as $$
begin
    return exists (
        select a.id
        from Abbonamento a
        where a.id = thisAbbonamento and a.inizio <= date(t) and fineAbbonamento(thisAbbonamento) >= date(t)
    );
end;
$$ language plpgsql;

create or replace function utilizziRimasti(thisAbbonamento integer,s integer, t timestamp)
returns IntegerGEZ as $$
declare
    ris integer = 0;
    perMese integer = 0;
begin

    select o.utilizzoPerMese
    into perMese
    from offre o,Abbonamento a
    where a.id = thisAbbonamento and o.tipologia = a.tipologia;

    with utilizzi as (
        select u.id,u.unitaUtilizzate
        from Utilizzo u,Abbonamento a,offre o,utilizza ut,Utente u1
        where u.inizio < t and date_part('month',t) = date_part('month',u.inizio) and date_part('year',t) = date_part('year',u.inizio)
            and ut.abbonamento = thisAbbonamento and ut.utente = u1.indEmail and a.id = thisAbbonamento and o.tipologia = a.tipologia 
            and o.servizio = s
            and u.servizio = s and u.utente = u1.indEmail
    )
    select o.utilizzoPerMese-sum(u.unitaUtilizzate)
    into ris
    from utilizzi u,offre o,Utilizzo u1,Abbonamento a
    where u1.id = u.id and u1.servizio = o.servizio and o.servizio = s and a.id = thisAbbonamento and o.tipologia = a.tipologia
    group by o.tipologia,o.servizio;

    if ris < 0 then return 0; end if;
    return coalesce(ris,perMese,0);
end;
$$ language plpgsql;

-- Operazioni classe Utilizzo

create or replace function prezzo(thisUtilizzo integer)
returns Denaro as $$
declare
    sconto Percentuale = 0;
    rimasti IntegerGEZ = 0;
    utilizzati IntegerGEZ = 0;
    prezzoBase Denaro = 0;
begin
    select o.sconto,utilizziRimasti(a.id,s.id,u.inizio),u.unitaUtilizzate,s.prezzoUnitario
    into sconto,rimasti,utilizzati,prezzoBase
    from utilizzo u join utilizza uti 
        on (u.utente = uti.utente) join Abbonamento a 
        on (uti.abbonamento = a.id) join servizioOfferto s 
        on (u.servizio = s.id) left outer join offre o 
        on (o.tipologia = a.tipologia and o.servizio = s.id)
    where u.id = thisUtilizzo;
    
    sconto := coalesce(sconto,0);

    if rimasti < utilizzati then
        return (utilizzati-rimasti)*prezzoBase - ((utilizzati-rimasti)*prezzoBase*sconto);
    end if;

    return 0;

end;
$$ language plpgsql;