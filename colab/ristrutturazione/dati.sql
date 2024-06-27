
begin transaction;
-- Popolare la tabella Nazione
INSERT INTO Nazione (nome) VALUES
('Italia'),
('Francia'),
('Germania');

-- Popolare la tabella Citta
INSERT INTO Citta (id,nome, nazione) VALUES
(1,'Roma', 'Italia'),
(2,'Milano', 'Italia'),
(3,'Parigi', 'Francia'),
(4,'Berlino', 'Germania');

-- Popolare la tabella Utente
INSERT INTO Utente 
('mario.rossi@example.com', 'Mario', 'Rossi', '1980-05-10', ROW('Via Roma', '10'), 1),
('luigi.bianchi@example.com', 'Luigi', 'Bianchi', '1985-08-15', ROW('Via Milano', '20'), 2),
('pierre.durant@example.com', 'Pierre', 'Durant', '1990-02-20', ROW('Rue de Paris', '30'), 3);

-- Popolare la tabella Cliente con ID che poi useremo per le persone fisiche e imprese
INSERT INTO Cliente (id) VALUES
(1),
(2),
(3),
(4),
(5),
(6);

-- Popolare la tabella partitaIVA con clienti che saranno imprese
INSERT INTO partitaIVA (cliente, val) VALUES
(4, 'IT12345678901'),
(5, 'IT98765432109'),
(6, 'FR11223344556');

-- Popolare la tabella Impresa con clienti che sono imprese
INSERT INTO Impresa (cliente, ragioneSociale) VALUES
(4, 'Impresa Rossi S.p.A.'),
(5, 'Impresa Bianchi S.r.l.'),
(6, 'Durant Entreprises');

-- Popolare la tabella PersonaFisica con clienti che sono persone fisiche
INSERT INTO PersonaFisica (utente, cliente) VALUES
('mario.rossi@example.com', 1),
('luigi.bianchi@example.com', 2),
('pierre.durant@example.com', 3);

-- Popolare la tabella TipologiaAbbonamento
INSERT INTO TipologiaAbbonamento (id,prezzo, durataGiorni, maxAbbonati) VALUES
(1,29.99, 30, 100),
(2,49.99, 90, 200),
(3,99.99, 365, 500);

-- Popolare la tabella IntervalloDate
INSERT INTO IntervalloDate (inizio, fine, tipologia) VALUES
('2024-01-01', '2024-12-31', 1),
('2024-03-01', '2024-8-31', 2),
('2024-01-01', '2024-12-31', 3);

-- Popolare la tabella Abbonamento
INSERT INTO Abbonamento (id,inizio, comprato, tipologia) VALUES
(1,'2024-04-01', 1, 1),
(2,'2024-04-01', 6, 2),
(3,'2024-04-01', 6, 3);

-- Popolare la tabella PostazioneLavoro
INSERT INTO PostazioneLavoro (id) VALUES
(1),
(2),
(3);

-- Popolare la tabella utilizza
INSERT INTO utilizza (abbonamento, utente, postanzione) VALUES
(1, 'mario.rossi@example.com', 1),
(2, 'luigi.bianchi@example.com', 2),
(3, 'pierre.durant@example.com', 3);

-- Popolare la tabella Accesso
INSERT INTO Accesso (entrata, uscita, utente) VALUES
('2024-06-01 08:00:00', '2024-06-01 12:00:00', 'mario.rossi@example.com'),
('2024-06-02 09:00:00', '2024-06-02 11:00:00', 'luigi.bianchi@example.com'),
('2024-06-03 10:00:00', '2024-06-03 14:00:00', 'pierre.durant@example.com');

-- Popolare la tabella ServizioOfferto
INSERT INTO ServizioOfferto (nome, descrizione, prezzoUnitario) VALUES
('Sala Riunioni', 'sala grande per prenotabile ad ora', 10.00),
('Stampante', 'Utilizzo della stampante multifunzione', 0.10),
('Caffè', 'Servizio caffè illimitato', 1.00);

-- Popolare la tabella offre
INSERT INTO offre (tipologia, servizio, sconto, utilizzoPerMese) VALUES
(1, 1, 0.1, 10),
(2, 2, 0.2, 20),
(3, 3, 0.3, 30);

-- Popolare la tabella Utilizzo
INSERT INTO Utilizzo (inizio, fine, unitaUtilizzate, servizio, utente) VALUES
('2024-06-01 08:00:00', '2024-06-01 09:00:00', 1, 1, 'mario.rossi@example.com'),
('2024-06-02 09:00:00', '2024-06-02 10:00:00', 1, 2, 'luigi.bianchi@example.com'),
('2024-06-03 10:00:00', '2024-06-03 11:00:00', 1, 3, 'pierre.durant@example.com');

insert into citta (id,nome,nazione) values
	(5,'Bracciano','Italia');

insert into utente (indEmail, nome, cognome, dataN, indirizzo, citta) values
	('lucasforza1234@icloud.com','Luca','Sforza','2003-05-28',row('Via Principe di napoli','87'),5);

INSERT INTO Cliente (id) VALUES
(7)

INSERT INTO PersonaFisica (utente, cliente) VALUES
    ('lucasforza1234@icloud.com',7)

INSERT INTO Abbonamento (id,inizio, comprato, tipologia) VALUES
(4,'2024-04-01', 7, 3);

INSERT INTO utilizza (abbonamento, utente, postanzione) VALUES
(4, 'lucasforza1234@icloud.com', 1);

INSERT INTO Utilizzo (inizio, fine, unitaUtilizzate, servizio, utente) VALUES
('2024-06-01 08:00:00', '2024-06-01 09:00:00', 1000, 2, 'lucasforza1234@icloud.com');

end;
commit;