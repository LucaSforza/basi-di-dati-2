create domain StringS as varchar(50);

create domain tel as StringS;
--  check $($isTel$($value$))$;

create domain cf as varchar(16);
--  check (isCF($value$));

create domain email as StringS;
-- check $($isEmail$($value$))$;

create domain IndirizzoNotNull as StringS
    check (value is not null);

create domain CivicoNotNull as StringS 
    check (value is not null /*and isCivico$(value) */);

create type posta as (via IndirizzoNotNull, civico CivicoNotNull);

create domain interogz as integer check (value > 0);

create domain interogez as integer check (value >= 0);
