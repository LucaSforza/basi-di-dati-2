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

-- usecase ricerca
create or replace function ricerca(
	t TipologiaSpettacolo,
	g Genere,
	d date
)
returns Spettacolo as $$
begin
	return (
    SELECT s
	FROM spettacolo as s, erogato as e
	WHERE s.genere = g.nome 
		and s.tipologiaSpettacolo = t.nome
		and e.spettacolo = s.id
		and date(e.inizio) = d;
    );
end;
$$ language plpgsql;