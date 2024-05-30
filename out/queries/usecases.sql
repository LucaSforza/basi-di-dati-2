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