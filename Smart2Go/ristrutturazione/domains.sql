create domain String as varchar(100);

create domain CodiceFiscale as varchar(16);
    -- check(isCodiceFiscale(value));

create domain RealGZ as real
    check(value > 0);

create domain IntegerGZ as integer
    check(value > 0);

create domain real_not_null as real
    check(value is not null);

create type Posizione as (
    latidudine real_not_null,
    longitudine real_not_null
);

create domain RealGEZ as real
    check(value >= 0);

create domain Denaro as RealGEZ;

create domain String_not_null as String
    check(value is not null);

create domain Civico_not_null as String_not_null;
    -- check(isCivico(value));

create type Indirizzo as (
    via String_not_null,
    civico Civico_not_null
);

create domain IBAN as String;
    --check(isIBAN(value));

create domain RagSoc as String
    --check(isRagSoc(value));

create domain Sconto as real
    check(value >= 0 and value <= 1);

create domain CodicePantente as String;
    --check(isCodicePatente(value));

create type TipConvenzione as enum('PerEcocompatibili','PerCategorie');

create domain TargaAuto as String;
    --check(isTarga(value));

create domain CodiceCard as String;
    --check(isCodiceCard(value));

create domain ClasseRischio as integer
    check(value >= 0 and value <= 10);