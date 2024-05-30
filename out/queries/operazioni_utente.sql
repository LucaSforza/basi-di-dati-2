create or replace function ultimoSpettacoloPrenotato(this Utente)
returns Spettacolo as $$
declare
    pren integer := NULL;
begin 
    -- pre condizioni
    select p.id into pren
    from prenotazione as p
    where p.utente = this.codiceFiscale;
    if pren is null then raise exception 'Error 001 - Utente non ha prenotazioni';
    end if;

    -- post condizioni
    return ( -- vedere metodo migliore per estrarre il massimo
        select s
        from spettacolo as s,prenotazione as p, erogato as e
        where p.erogato = e.id 
            and p.utente = this.codiceFiscale
            and s.id = e.spettacolo
        order by e.inizio desc
    );
end;
$$ language plpgsql;

select u.codiceFiscale,ultimoSpettacoloPrenotato(u)
from utente as u;