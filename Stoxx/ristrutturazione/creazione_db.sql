-- Creazione dei domini
create domain String as varchar(100);
create domain CF as varchar(16);
create domain Email as varchar(100);  -- Utilizzando String per definire Email
create domain Tel as varchar(100);    -- Utilizzando String per definire Tel
create domain Denaro as real;
create domain RealGZ as real check (value > 0);
create domain Matr as varchar(100);   -- Utilizzando String per definire Matr
create domain RealGEZ as real check (value >= 0);
create domain IntegerGEZ as integer check (value >= 0);

-- Creazione dei tipi ENUM
create type Rischio as enum('Basso', 'Moderato', 'Alto', 'Aggressivo');
create type TipoEmittente as enum('Azienda', 'Stato');
create type TipoTitolo as enum('Obbligazione', 'Azione', 'TitoloDiStato');

-- Creazione delle tabelle
create table TipoDocumento (
    nome String primary key
);

create table Promotore (
    matricola Matr primary key,
    nome String not null,
    cognome String not null
);

create table Cliente (
    codiceFiscale CF primary key,
    nome String not null,
    cognome String not null,
    indirizzoEmail Email,
    codiceDocumento String not null,
    tipoDocumento String not null,
    unique (codiceDocumento, tipoDocumento),
    unique (indirizzoEmail),
    foreign key (tipoDocumento) references TipoDocumento(nome)
);

create table RecapitoTelefonico (
    numero Tel primary key,
    cliente CF not null,
    foreign key (cliente) references Cliente(codiceFiscale)
);

create table Gestione (
    id serial primary key,
    inizio timestamp not null,
    terminato boolean not null,
    fine timestamp,
    motivo String,
    promotore Matr not null,
    cliente CF not null,
    foreign key (promotore) references Promotore(matricola),
    foreign key (cliente) references Cliente(codiceFiscale),
    check (not terminato or inizio <= fine),
    check ((not terminato or (fine is not null and motivo is not null)) and 
           (not (fine is not null and motivo is not null) or terminato))
);

create table Emittente (
    nome String primary key,
    tipo TipoEmittente not null
);

create table StrumentoFinanziario (
    id serial primary key,
    emittente String not null,
    foreign key (emittente) references Emittente(nome)
);

create table Rilevazione (
    id serial primary key,
    istante timestamp not null,
    valore Denaro not null check (valore >= 0),
    strumento integer not null,
    foreign key (strumento) references StrumentoFinanziario(id),
    unique (istante, strumento)
);

create table Titolo (
    strumento integer primary key,
    tipo TipoTitolo not null,
    foreign key (strumento) references StrumentoFinanziario(id)
);

create table FondoGestito (
    strumento integer primary key,
    numAzioni IntegerGEZ not null,
    numObbligazioni IntegerGEZ not null,
    numTitoliDiStato IntegerGEZ not null,
    foreign key (strumento) references StrumentoFinanziario(id),
    check ((numAzioni + numObbligazioni + numTitoliDiStato) > 0)
);

create table Investimento (
    id serial primary key,
    quantita RealGZ not null,
    istante timestamp not null,
    gestione integer not null,
    strumento integer not null,
    foreign key (gestione) references Gestione(id),
    foreign key (strumento) references StrumentoFinanziario(id)
);

create table Disinvestimento (
    id serial primary key,
    quantita RealGZ not null,
    istante timestamp not null,
    investimento integer not null,
    foreign key (investimento) references Investimento(id)
);