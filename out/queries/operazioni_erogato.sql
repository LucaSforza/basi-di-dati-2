create or replace function fineErogato(this Erogato)
returns timestamp as $$
begin
    return (
        make_interval(mins => (SELECT s.durataMinuti as dm
        FROM spettacolo as s
        WHERE this.spettacolo = s.id)) + this.inizio
    );
end;
$$ language plpgsql

select s.nome,s.durataMinuti,e.inizio,fineErogato(e) as fine
from erogato as e,spettacolo as s
where e.spettacolo = s.id;