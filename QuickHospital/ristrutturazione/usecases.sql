-- usecase accetta ricoveri

create or replace function postiLettoLiberi()
returns setof PostoLetto as $$
begin
    return query
        select *
        from PostoLetto as pl
        where not exists (
            select o.postoletto
            from occupato as o
            where pl.id = o.postoletto
        );
end;
$$ language plpgsql;

--

create or replace function possibiliMedici(s Specializzazione)
returns setof Medico as
$$
    begin
    if ((
        select count(*)
        from medico as m
        where m.specializzazionePrimaria = s.nome
    ) > 0) then
        return query (
		select *
        from medico as m
        where m.specializzazionePrimaria = s.nome
		);
    end if;
    return query (
        select m.*
        from medico as m,SpecializzazioneSecondaria as ss
        where m.persona = ss.medico and ss.specializzazione = s.nome
    );
    end;
$$
language plpgsql;

-- usecase itinerario

create or replace function itinerario(m Medico)
returns setof Stanza as
$$
    begin
        return query
            select s.*
            from stanza as s,postoletto as pl
            where pl.stanza = s.id
                and pl.id =any(
                select pl.id
                from postoletto as pl,occupato as o,nonDimesso as nd, ricovero as r,paziente as p
                where pl.id = o.postoletto and o.nonDimesso = nd.ricovero and r.id = nd.ricovero
                    and r.paziente = p.persona 
                    and p.persona =any(
                        select p.persona
                        from paziente as p,ricovero as r, nondimesso as nd
                        where p.persona = r.paziente and nd.ricovero = r.id and r.medico = m.persona
                    )
                )
            order by s.piano,s.settore;
            
    end;
$$
language plpgsql;
