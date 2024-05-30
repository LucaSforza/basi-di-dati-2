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

CREATE TABLE Persona (
    codiceFiscale cf PRIMARY KEY,
    nome StringS not null,
    cognome StringS not null,
    dataN date not null
);

CREATE TABLE Paziente (
    persona cf PRIMARY KEY REFERENCES Persona(codiceFiscale),
    telefoni tel not null,
    email email not null,
    posta posta not null
);

create table Specializzazione (
    nome StringS primary key
);

CREATE TABLE Medico (
    persona cf PRIMARY KEY REFERENCES Persona(codiceFiscale),
    specializzazionePrimaria StringS not null REFERENCES Specializzazione(nome)
);

CREATE TABLE SpecializzazioneSecondaria (
    medico cf REFERENCES Medico(persona),
    specializzazione StringS REFERENCES Specializzazione(nome),
    PRIMARY KEY (medico, specializzazione)
);

CREATE TABLE Prestazione (
    id SERIAL PRIMARY KEY,
    dataRichiesta DATE not null,
    descrizione TEXT not null,
    paziente cf not null REFERENCES Paziente(persona),
    medico cf REFERENCES Medico(persona),
    specializzazioneRichiesta StringS not null REFERENCES Specializzazione(nome)
);


CREATE TABLE Stanza (
    id SERIAL PRIMARY KEY,
    piano InteroGZ not null,
    settore InteroGZ not null
);

CREATE TABLE PostoLetto (
    id SERIAL PRIMARY KEY,
    stanza INTEGER not null REFERENCES Stanza(id)
);

CREATE TABLE Ricovero (
    id SERIAL PRIMARY KEY,
    dataInizio DATE not null,
    paziente cf not null REFERENCES Paziente(persona),
    medico cf not null REFERENCES Medico(persona),
    storico INTEGER REFERENCES PostoLetto(id)
);

CREATE TABLE Dimesso (
    ricovero INTEGER PRIMARY KEY REFERENCES Ricovero(id),
    dataFine DATE not null
);

CREATE TABLE NonDimesso (
    ricovero INTEGER PRIMARY KEY REFERENCES Ricovero(id)
);

CREATE TABLE Occupato (
    postoletto INTEGER REFERENCES PostoLetto(id),
    nonDimesso INTEGER REFERENCES NonDimesso(ricovero),
    PRIMARY KEY (postoletto, nonDimesso)
);

dati questi domini e questo database creami dei dati plausibili
non troppi, ma neanche troppo pochi
minimo 5 elementi per tabella (puoi anche non seguire questa regola se lo ritieni necessario)
Fai in modo che ci sia un medico pazionte, ma soltanto uno