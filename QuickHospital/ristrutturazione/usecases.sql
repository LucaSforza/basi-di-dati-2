-- usecase accetta ricoveri

create or replace function postiLettoLiberi()
returns table(letto integer) as $$
begin
    return query (
        select pl.id as letto
        from PostoLetto as pl
        where not exists (
            select o.postoletto
            from occupato as o
            where pl.id = o.postoletto
        )
    );
end;
$$ language plpgsql;