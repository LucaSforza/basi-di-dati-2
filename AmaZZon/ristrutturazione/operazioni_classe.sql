-- Operazioni classe Acquisto

create or replace function valoreBuoni(thisAcquisto Integer)
returns Denaro as $$
begin
    return (
        select sum(t.saldo)
        from BuonoRegalo b,TipologiaBuonoRegalo t
        where b.acquisto = thisAcquisto and t.id = b.tipologia
    );
end;
$$ language plpgsql;

create or replace function prezzoSenzaBuoni(thisAcquisto Integer)
returns Denaro as $$
begin
    return (
        with offerte as (
            select o.id,a.quantita as q,o.prezzo as p_1,
                case
                    when a.quantita = 1 then s.prezzoBase
                    else
                        case
                            when not exists(
                                select *
                                from IntervalloPerRiduzione i
                                where i.spedizione = s.id
                            ) then s.prezzoBase
                            else (
                                select i.prezzo
                                from IntervalloPerRiduzione i
                                where i.spedizione = s.id and a.quantita between i.inizio and coalesce(i.fine,'infinity'::numeric)
							)
                        end
                end as p_2
            from Assegnato a,Offerta o,Citta c,Spedizione s,Acquisto ac
            where a.acquisto = thisAcquisto and a.offerta = o.id 
                and ac.id = thisAcquisto and ac.citta = c.id and s.nazione = c.nazione 
        )
        select sum(o.q*o.p_1 + o.q*o.p_2)
        from offerte o
    );
end;
$$ language plpgsql;

create or replace function prezzo(thisAcquisto Integer)
returns Denaro as $$
begin
    return prezzoSenzaBuoni(thisAcquisto) - valoreBuoni(thisAcquisto);
end;
$$ language plpgsql;

-- Operazioni classe BuonoRegalo

create or replace function fine(thisBuono Integer)
returns timestamp as $$
begin
    return (
        select make_interval(days => t.durataValiditaGiorni) + b.inizio
        from TipologiaBuonoRegalo t,BuonoRegalo b
        where b.id = thisBuono and b.tipologia = t.id
    );
end;
$$ language plpgsql;

-- Operazioni classe Articolo

create or replace function mediaGiornaliera(thisArticolo Cod, i date,f date)
returns RealGEZ as $$
begin
    if i > f then raise exception 'Error 001 - inizio superiore alla fine'; end if;

    return (
        select sum(ass.quantita)/(f-i+1)
        from Acquisto a,Offerta o,Assegnato ass
        where o.articolo = thisArticolo and ass.acquisto = a.id and ass.offerta = o.id
    );
end;
$$ language plpgsql;