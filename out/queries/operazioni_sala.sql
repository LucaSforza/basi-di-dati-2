create or replace function postiSala(this Sala)
returns IntegerGEZ as $$
begin
	return (
		with sala_posti as (
			SELECT s.id as sala, posti(s)
			FROM settore as s
			WHERE this.id = s.sala
		)
		SELECT sum(sp.posti)
		FROM sala_posti as sp
	);
end;
$$ language plpgsql;