-- Usecase Fattura

create or replace function fattura(im integer,i date, f date)
returns Denaro as $$
begin
    if i > f then raise exception 'Error 002 - inizio dopo la fine'; end if;

    return (
        select sum(prezzo(ut.id))
        from utilizzo ut,utentiGestiti(im,i,f) as u
        where u.utente = ut.utente
    );
end;
$$ language plpgsql;

-- Usecase Moda

create or replace function serviziModa(k IntegerGZ,i date, f date)
returns setof ServizioOfferto as $$
begin
    return query
        select s.*
        from ServizioOfferto s,Utilizzo u
        where s.id = u.servizio
        group by s.id
        order by sum(u.unitaUtilizzate) desc
        limit k;
end;
$$ language plpgsql;

-- Usecase utenti inutili

create or replace function utentiInutili(i date,f date)
returns setof Utente as $$
begin
    return query
        select u.*
        from Utente u,utilizza ut,Abbonamento a
        where u.indEmail = ut.utente and ut.abbonamento = a.id and (i,f) overlaps (a.inizio,fineAbbonamento(a.id))
        except
        select u.*
        from Utente u,Accesso a
        where a.utente = u.indEmail and date(a.entrata) >= i and date(a.entrata) <= f;
end;
$$ language plpgsql;

-- Usecase mediaGiornalieria

create or replace function mediaGiornaliera(I intervallo[])
returns table(il intervallo,m RealGEZ) as $$
begin
    if exists(
        select *
        from unnest(I) as x(inizio,f), unnest(I) as y(inizio,f)
        where x <> y and (x.inizio,x.f) overlaps (y.inizio,y.f)
    ) then raise exception 'Error 004 - gli intevalli non sono disgiunti'; end if;

    return query
        with entrate as (
            select a.id,x
            from Accesso a,unnest(I) as x(inizio,f)
            where a.entrata::time >= x.inizio and a.entrata::time <= x.f
            and date_part('month',now()::timestamp) = date_part('month',a.entrata)
            and date_part('year',now()::timestamp) = date_part('year',a.entrata)
        )
        select e.x as il,(count(e.id)::real/date_part('day',now()::timestamp)::real)::RealGEZ as m
        from entrate e
        group by e.x;
end;
$$ language plpgsql;