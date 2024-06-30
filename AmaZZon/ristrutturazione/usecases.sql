create or replace function paeseConTantiAcquisti(i date,f date)
returns setof String as $$
begin
    if i > f then raise exception 'Error 002 - inizio dopo la fine'; end if;

    return query
        with as nazione_1 as (
            select c.nazione,sum(ass.quantita) as s
            from Acquisto a,Citta c,Offerta o,Assegnato ass
            where a.citta = c.id and c.nazione and ass.acquisto = a.id and ass.offerta = o.id 
                and date(a.istante) <= i and date(a.istante) <= f
            group by c.nazione
        ), nazione_max as (
            select max(n.s)
            from nazione_1 n
        )
        select n.nazione
        from nazione_1 n,nazione_max m
        where n.s = m.max;
end;
$$ language plpgsql;

create or replace function ricerca(cat String,Tags String[],naz String)
returns table(art Cod,prezzo Denaro) as $$
begin
    return query
        select a.codice,min(o.prezzo + s.prezzoBase)::Denaro
        from Articolo a,Offerta o,unnest(Tags) as t(nome),art_tag a_t,Spedizione s
        where a_t.articolo = a.codice and a_t.tag = t.nome 
            and o.articolo = a.codice and s.nazione = naz and s.offerta = o.id and a.categoria = cat
        group by a.codice;
end;
$$ language plpgsql;