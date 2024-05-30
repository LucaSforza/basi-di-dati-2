create or replace function posti(this Settore)
returns IntegerGEZ as $$
begin
    return (
        SELECT count(*)
        FROM posto as p
        WHERE p.settore = this.id
    );
end;
$$ language plpgsql;

create or replace function postiOccupati(this Settore, e Erogato)
returns IntegerGEZ as $$
begin 
    return (
        SELECT sum(tot)
        FROM (
            SELECT p.id,postiTotali(p) as tot
            FROM Prenotazione as p
            WHERE p.settore = this.id AND p.erogato = e.id
        ) as prenotazione_tot
    );
end;
$$ language plpgsql;

create or replace function postiLiberi(this Settore, e Erogato)
returns IntegerGEZ as $$
begin 
    return posti(this) - postiOccupati(this,e); 
end;
$$ language plpgsql;