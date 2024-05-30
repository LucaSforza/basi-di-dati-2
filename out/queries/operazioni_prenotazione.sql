create or replace function postiTotali(this Prenotazione)
returns IntegerGZ as $$
begin
	return this.numPrenotatiPieni + this.numPrenotatiRidotto;
end;

$$ language  plpgsql;