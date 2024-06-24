create domain String as varchar(100);

create domain CF as varchar(16);
    -- check(isCodiceFiscale(value));

create domain Email as String;
    -- check(isEmail(value));

create domain Tel as String;
    -- check(isTel(value));

create domain Denaro as real;

create domain RealGZ as real
    check(value > 0);

create domain Matr as String;
    -- check(isMatr(value));

create domain RealGEZ as real
    check(value >= 0);

create domain IntegerGEZ as integer
    check(value >= 0);

create type Rischio as enum('Basso','Moderato','Alto','Aggressivo');

create type TipoEmittente as enum('Azienda','Stato');

create type TipoTitolo as enum('Obbligazione','Azione','TitoloDiStato');