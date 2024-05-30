-- usecase prenota
create or replace function preCondizioniPrenota(
	numPrenotatiPieni IntegerGEZ,
	numPrenotatiRidotti IntegerGEZ,
	s Settore,
	e Erogato
)
returns boolean as $$
begin
	return (
		numPrenotatiPieni + numPrenotatiRidotti > 0
			and
		(select postiLiberi(s,e) as n )>= numPrenotatiPieni + numPrenotatiRidotti
			and
		e.inizio > current_date
	);
end;
$$ language plpgsql;

select ricerca(t,g,date(e.inizio))
from tipologiaSpettacolo as t, genere as g, erogato as e;

drop function ricerca;
drop function spettacoliErogatiNeiProssimiSetteGiorni;

-- usecase ricerca
create or replace function ricerca(
	t TipologiaSpettacolo,
	g Genere,
	d date
)
returns table(id integer) as $$
begin
    return query (
        SELECT distinct s.id as spettacolo
	    FROM spettacolo as s, erogato as e
	    WHERE s.genere = g.nome 
		    and s.tipologiaSpettacolo = t.nome
		    and e.spettacolo = s.id
		    and date(e.inizio) = d
    );
end;
$$ language plpgsql;

-- usecase utilsConsiglio
create or replace function spettacoliErogatiNeiProssimiSetteGiorni(
    g Genere
)
returns table(id integer) as $$
begin
    return query (
        select distinct s.id
        from spettacolo as s,erogato as e
        where s.id = e.spettacolo
            and s.genere = g.nome
            and date(e.inizio) > current_date
            and current_date + 7 > date(e.inizio)
    );
end;
$$ language plpgsql;

select spettacoliErogatiNeiProssimiSetteGiorni(g)
from genere as g;

-- use case consiglio

create or replace function consiglio(u Utente)
returns table(spec integer)
begin
    return query(
        
    );
end;
$$ language plpgsql;