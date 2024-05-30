-- Tabella per tipologia di sede
CREATE TABLE TipologiaSede (
    nome StringM PRIMARY KEY
);

-- Tabella per sede
CREATE TABLE Sede (
    id SERIAL PRIMARY KEY,
    nome StringM NOT NULL,
    tipologiaSede StringM NOT NULL,
    FOREIGN KEY (tipologiaSede) REFERENCES TipologiaSede(nome)
);

-- Tabella per tipologia di sala
CREATE TABLE TipologiaSala (
    nome StringM PRIMARY KEY
);

-- Tabella per sala
CREATE TABLE Sala (
    id SERIAL PRIMARY KEY,
    nome StringM NOT NULL,
    sede INTEGER NOT NULL,
    tipologiaSala StringM NOT NULL,
    UNIQUE (nome, sede),
    FOREIGN KEY (sede) REFERENCES Sede(id),
    FOREIGN KEY (tipologiaSala) REFERENCES TipologiaSala(nome)
);

-- Tabella per settore
CREATE TABLE Settore (
    id SERIAL PRIMARY KEY,
    nome StringM NOT NULL,
    costoPosto Euro NOT NULL,
    costoRidotto Euro NOT NULL,
    sala INTEGER NOT NULL,
	UNIQUE (nome,sala),
    FOREIGN KEY (sala) REFERENCES Sala(id)
);

-- Tabella per posto
CREATE TABLE Posto (
    fila IntegerGZ,
    colonna IntegerGZ,
    settore INTEGER,
    PRIMARY KEY (fila, colonna, settore),
    FOREIGN KEY (settore) REFERENCES Settore(id)
);

-- Tabella per genere
CREATE TABLE Genere (
    nome StringM PRIMARY KEY
);

-- Tabella per tipologia di spettacolo
CREATE TABLE TipologiaSpettacolo (
    nome StringM PRIMARY KEY
);

-- Tabella per spettacolo
CREATE TABLE Spettacolo (
    id SERIAL PRIMARY KEY,
    nome StringM NOT NULL,
    durataMinuti IntegerGZ NOT NULL,
    tipologiaSpettacolo StringM NOT NULL,
    genere StringM NOT NULL,
    FOREIGN KEY (genere) REFERENCES Genere(nome),
    FOREIGN KEY (tipologiaSpettacolo) REFERENCES TipologiaSpettacolo(nome)
);

-- Tabella per erogazione di spettacoli
CREATE TABLE Erogato (
    id SERIAL PRIMARY KEY,
    inizio TIMESTAMP NOT NULL,
    sala INTEGER NOT NULL,
    spettacolo INTEGER NOT NULL,
    FOREIGN KEY (sala) REFERENCES Sala(id),
    FOREIGN KEY (spettacolo) REFERENCES Spettacolo(id)
);

-- Tabella per artista
CREATE TABLE Artista (
    id SERIAL PRIMARY KEY,
    nome StringM NOT NULL,
    cognome StringM NOT NULL
);

-- Tabella per relazione tra artista e spettacolo
CREATE TABLE art_spe (
    artista INTEGER,
    spettacolo INTEGER,
    PRIMARY KEY (artista, spettacolo),
    FOREIGN KEY (artista) REFERENCES Artista(id),
    FOREIGN KEY (spettacolo) REFERENCES Spettacolo(id)
);

-- Tabella per utente
CREATE TABLE Utente (
    codiceFiscale CF PRIMARY KEY,
    nome StringM NOT NULL,
    cognome StringM NOT NULL
);

-- Tabella per prenotazione
CREATE TABLE Prenotazione (
    id SERIAL PRIMARY KEY,
    numPrenotatiPieni IntegerGEZ NOT NULL,
    numPrenotatiRidotto IntegerGEZ NOT NULL,
    istante TIMESTAMP NOT NULL,
    utente CF NOT NULL,
    erogato INTEGER NOT NULL,
    settore INTEGER NOT NULL,
    UNIQUE (istante,utente),
    FOREIGN KEY (utente) REFERENCES Utente(codiceFiscale),
    FOREIGN KEY (erogato) REFERENCES Erogato(id),
    FOREIGN KEY (settore) REFERENCES Settore(id)
);