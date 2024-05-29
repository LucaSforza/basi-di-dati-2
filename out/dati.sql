begin transaction;

-- Inserimento dati per TipologiaSede
INSERT INTO TipologiaSede (nome) VALUES 
('Universitaria'), 
('Commerciale');

-- Inserimento dati per Sede
INSERT INTO Sede (nome, tipologiaSede) VALUES 
('Sapienza', 'Universitaria'), 
('Centro Commerciale Roma', 'Commerciale');

-- Inserimento dati per TipologiaSala
INSERT INTO TipologiaSala (nome) VALUES 
('Auditorium'), 
('Cinema');

-- Inserimento dati per Sala
INSERT INTO Sala (nome, sede, tipologiaSala) VALUES 
('Aula Magna', 1, 'Auditorium'), 
('Sala 1', 2, 'Cinema'), 
('Sala 2', 2, 'Cinema');

-- Inserimento dati per Settore
INSERT INTO Settore (nome, costoPosto, costoRidotto, sala) VALUES 
('Settore A', 10.00, 7.50, 1), 
('Settore B', 8.00, 5.50, 2);

-- Inserimento dati per Posto
INSERT INTO Posto (fila, colonna, settore) VALUES 
(1, 1, 1), 
(1, 2, 1), 
(1, 3, 2), 
(2, 1, 2);

-- Inserimento dati per Genere
INSERT INTO Genere (nome) VALUES 
('Commedia'), 
('Dramma');

-- Inserimento dati per TipologiaSpettacolo
INSERT INTO TipologiaSpettacolo (nome) VALUES 
('Teatro'), 
('Film');

-- Inserimento dati per Spettacolo
INSERT INTO Spettacolo (nome, durataMinuti, tipologiaSpettacolo, genere) VALUES 
('Amleto', 120, 'Teatro', 'Dramma'), 
('Avengers', 140, 'Film', 'Commedia');

-- Inserimento dati per Erogato
INSERT INTO Erogato (inizio, sala, spettacolo) VALUES 
('2024-06-01 20:00:00', 1, 1), 
('2024-06-02 18:00:00', 2, 2);

-- Inserimento dati per Artista
INSERT INTO Artista (nome, cognome) VALUES 
('William', 'Shakespeare'), 
('Robert', 'Downey Jr.');

-- Inserimento dati per art_spe
INSERT INTO art_spe (artista, spettacolo) VALUES 
(1, 1), 
(2, 2);

-- Inserimento dati per Utente
INSERT INTO Utente (codiceFiscale, nome, cognome) VALUES 
('RSSMRA85M01H501Z', 'Mario', 'Rossi'), 
('VCCCLD99T30H501B', 'Claudio', 'Verdi');

-- Inserimento dati per Prenotazione
INSERT INTO Prenotazione (numPrenotatatiPieni, numPrenotatatiRidotto, istante, utente, erogato) VALUES 
(2, 1, '2024-05-25 14:00:00', 'RSSMRA85M01H501Z', 1), 
(1, 2, '2024-05-26 15:00:00', 'VCCCLD99T30H501B', 2);


end;