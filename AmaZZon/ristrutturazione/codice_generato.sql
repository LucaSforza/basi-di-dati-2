-- Creazione dei domini
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

create type TipWishList as enum('Pubblica', 'Privata');

create domain Cod as String;
    -- check(isCod(value));

-- Creazione delle tabelle con vincoli di chiave primaria e chiavi esterne
create table Nazione (
    nome String primary key
);

create table Citta (
    id serial primary key,
    nome String not null,
    nazione String not null,
    foreign key (nazione) references Nazione(nome)
);

create table Negozio (
    ragioneSociale RagSoc primary key,
    indirizzo Ind not null,
    telefono Tel not null
);

create table IndirizzoEmail (
    id serial primary key,
    email Email not null,
    negozio RagSoc not null,
    foreign key (negozio) references Negozio(ragioneSociale)
);

create table Marca (
    nome String primary key
);

create table Categoria (
    nome String primary key
);

create table Tag (
    nome String primary key
);

create table Articolo (
    codice Cod primary key,
    nome String not null,
    descrizione Text not null,
    numeroModello String not null,
    marca String not null,
    categoria String not null,
    foreign key (marca) references Marca(nome),
    foreign key (categoria) references Categoria(nome),
    unique (numeroModello, marca)
);

create table art_tag (
    articolo Cod not null,
    tag String not null,
    primary key (articolo, tag),
    foreign key (articolo) references Articolo(codice),
    foreign key (tag) references Tag(nome)
);

create table Offerta (
    id serial primary key,
    prezzo Denaro not null,
    inizio timestamp not null,
    fine timestamp,
    articolo Cod not null,
    negozio RagSoc not null,
    foreign key (articolo) references Articolo(codice),
    foreign key (negozio) references Negozio(ragioneSociale),
    check (fine is null or (inizio <= fine))
);

create table Spedizione (
    id serial primary key,
    nazione String not null,
    offerta Integer not null,
    prezzoBase Denaro not null,
    foreign key (nazione) references Nazione(nome),
    foreign key (offerta) references Offerta(id),
    unique (nazione, offerta)
);

create table IntervalloPerRiduzione (
    id serial primary key,
    inizio IntegerGONE not null,
    fine IntegerGONE,
    prezzo Denaro not null,
    spedizione Integer not null,
    foreign key (spedizione) references Spedizione(id)
);

create table Utente (
    nickname String primary key,
    istanteReg timestamp not null,
    nome String not null,
    cognome String not null
);

create table amiciziaPending (
    invia String not null,
    riceve String not null,
    primary key (invia, riceve),
    foreign key (invia) references Utente(nickname),
    foreign key (riceve) references Utente(nickname)
);

create table amicizia (
    da String not null,
    a String not null,
    primary key (da, a),
    foreign key (da, a) references amiciziaPending(invia, riceve)
);

create table CartaDiCredito (
    numero NumCarta primary key,
    dataScadenza date not null,
    utente String not null,
    foreign key (utente) references Utente(nickname)
);

create table Acquisto (
    id serial primary key,
    istante timestamp not null,
    indirizzoArrivo Ind not null,
    citta integer not null,
    utente String not null,
    foreign key (utente) references Utente(nickname),
    foreign key (citta) references Citta(id)
);

create table Assegnato (
    acquisto Integer not null,
    offerta Integer not null,
    quantita IntegerGZ not null,
    primary key (acquisto, offerta),
    foreign key (acquisto) references Acquisto(id),
    foreign key (offerta) references Offerta(id)
);

create table TipologiaBuonoRegalo (
    id serial primary key,
    nome String not null,
    saldo Denaro not null,
    durataValiditaGiorni IntegerGZ not null
);

create table BuonoRegalo (
    id serial primary key,
    inizio timestamp not null,
    tipologia Integer not null,
    acquisto Integer,
    possiede String not null,
    acquistato String not null,
    foreign key (tipologia) references TipologiaBuonoRegalo(id),
    foreign key (acquisto) references Acquisto(id),
    foreign key (possiede) references Utente(nickname),
    foreign key (acquistato) references Utente(nickname)
);

create table WishList (
    id serial primary key,
    nome String not null,
    utente String not null,
    tipo TipWishList not null,
    unique (nome, utente),
    foreign key (utente) references Utente(nickname)
);

create table Rilevamento (
    id serial primary key,
    istante timestamp not null,
    wishList Integer not null,
    foreign key (wishList) references WishList(id),
    unique (istante, wishList)
);

create table salvati (
    wishList Integer not null,
    articolo Cod not null,
    primary key (wishList, articolo),
    foreign key (wishList) references WishList(id),
    foreign key (articolo) references Articolo(codice)
);