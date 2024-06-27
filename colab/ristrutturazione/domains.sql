create domain IntegerGZ as integer
    check(value > 0);

create domain IntegerGEZ as integer
    check(value >= 0);

create domain String as varchar(100);

create domain Denaro as real
    check(value >= 0);

create domain RagSoc as String;
    --check(isRagSoc(value));

create domain pIVA as String;
    --check(ispIVA(value));

create domain Email as String;
    --check(isEmail(value));

create domain Percentuale as real
    check(value >= 0 and value <= 1);

create domain String_not_null as String
    check(value is not null);

create domain Civico_not_null as String
    check(value is not null /*and isCivico(value)*/);

create type Ind as (
    via String_not_null,
    civico Civico_not_null
);

create domain time_not_null as time
    check(value is not null);

create type Intervallo as (
    inizio time_not_null,
    fine time_not_null
);

create domain RealGEZ as real
    check(value >= 0);