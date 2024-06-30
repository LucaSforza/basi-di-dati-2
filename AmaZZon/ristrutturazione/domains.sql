create domain String as varchar(100);

create domain IntegerGONE as integer
    check(value > 1);

create domain RealGEZ as real
    check(value >= 0);

create domain IntegerGZ as integer
    check(value > 0);

create domain IntegerGEZ as integer
    check(value >= 0);

create domain String_not_null as String
    check(value is not null);

create domain Civico_not_null as String
    check(value is not null /*and isCivico(value)*/);

create type Ind as (
    via String_not_null,
    civico Civico_not_null
);

create domain Tel as String;
    -- check(isTel(value));

create domain Email as String;
    -- check(isEmail(value));

create domain Denaro as RealGEZ;

create domain NumCarta as String;
    -- check(isNumCarta(value));

create domain RagSoc as String;
    -- check(isRagSoc(value));

create type TipWishList as enum('Pubblica','Privata');

create domain Cod as String;
    -- check(isCod(value));