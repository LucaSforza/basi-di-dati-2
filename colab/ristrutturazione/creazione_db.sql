-- Definizione dei domini
create domain IntegerGZ as integer
    check (value > 0);

create domain IntegerGEZ as integer
    check (value >= 0);

create domain String as varchar(100);

create domain Denaro as real
    check (value >= 0);

create domain RagSoc as String;
    --check(isRagSoc(value));

create domain pIVA as String;
    --check(ispIVA(value));

create domain Email as String;
    --check(isEmail(value));

create domain Percentuale as real
    check (value >= 0 and value <= 1);

create domain String_not_null as String
    check (value is not null);

create domain Civico_not_null as String
    check (value is not null /*and isCivico(value)*/);

-- Definizione del tipo
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

-- Creazione delle tabelle
create table Nazione (
    nome String primary key
);

create table Citta (
    id serial primary key,
    nome String not null,
    nazione String not null,
    foreign key (nazione) references Nazione(nome)
);

create table Utente (
    indEmail Email primary key,
    nome String not null,
    cognome String not null,
    dataN date not null,
    indirizzo Ind not null,
    citta integer not null,
    foreign key (citta) references Citta(id)
);

create table Cliente (
    id serial primary key
);

create table partitaIVA (
    cliente integer primary key,
    val pIVA not null,
    unique (val),
    foreign key (cliente) references Cliente(id)
);

create table Impresa (
    cliente integer primary key,
    ragioneSociale RagSoc not null,
    foreign key (cliente) references partitaIVA(cliente)
);

create table PersonaFisica (
    utente Email,
    cliente integer,
    primary key (utente, cliente),
    foreign key (utente) references Utente(indEmail),
    foreign key (cliente) references Cliente(id)
);

create table TipologiaAbbonamento (
    id serial primary key,
    prezzo Denaro not null,
    durataGiorni IntegerGZ not null,
    maxAbbonati IntegerGZ not null
);

create table IntervalloDate (
    id serial primary key,
    inizio date not null,
    fine date not null,
    tipologia integer not null,
    foreign key (tipologia) references TipologiaAbbonamento(id),
    check (inizio <= fine)
);

create table Abbonamento (
    id serial primary key,
    inizio date not null,
    comprato integer not null,
    tipologia integer not null,
    foreign key (comprato) references Cliente(id),
    foreign key (tipologia) references TipologiaAbbonamento(id)
);

create table PostazioneLavoro (
    id IntegerGZ primary key
);

create table utilizza (
    abbonamento integer not null,
    utente Email not null,
    postanzione IntegerGZ not null,
    primary key (abbonamento, utente, postanzione),
    foreign key (abbonamento) references Abbonamento(id),
    foreign key (utente) references Utente(indEmail),
    foreign key (postanzione) references PostazioneLavoro(id)
);

create table Accesso (
    id serial primary key,
    entrata timestamp not null,
    uscita timestamp,
    utente Email not null,
    foreign key (utente) references Utente(indEmail),
    check (uscita is null or entrata <= uscita)
);

create table ServizioOfferto (
    id serial primary key,
    nome String not null,
    descrizione text not null,
    prezzoUnitario Denaro not null
);

create table offre (
    tipologia integer not null,
    servizio integer not null,
    sconto Percentuale not null,
    utilizzoPerMese IntegerGZ not null,
    primary key (tipologia, servizio),
    foreign key (tipologia) references TipologiaAbbonamento(id),
    foreign key (servizio) references ServizioOfferto(id)
);

create table Utilizzo (
    id serial primary key,
    inizio timestamp not null,
    fine timestamp not null,
    unitaUtilizzate IntegerGZ not null,
    servizio integer not null,
    utente Email not null,
    foreign key (servizio) references ServizioOfferto(id),
    foreign key (utente) references Utente(indEmail),
    check (inizio <= fine)
);
