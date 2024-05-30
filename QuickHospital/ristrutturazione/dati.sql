-- Inserimento dati nella tabella Persona
INSERT INTO Persona (codiceFiscale, nome, cognome, dataN) VALUES
('RSSMRA85M01H501Z', 'Mario', 'Rossi', '1985-01-01'),
('BNCPLA90A01F205X', 'Paola', 'Bianchi', '1990-01-01'),
('VRDLGI75L01F205Y', 'Luigi', 'Verdi', '1975-07-01'),
('BLCLRA82A41H501Y', 'Laura', 'Bianchi', '1982-01-01'),
('MRNFBA70M01H501T', 'Fabio', 'Marinelli', '1970-01-01');

-- Inserimento dati nella tabella Specializzazione
INSERT INTO Specializzazione (nome) VALUES
('Cardiologia'),
('Neurologia'),
('Dermatologia'),
('Pediatria'),
('Ortopedia');

-- Inserimento dati nella tabella Medico
INSERT INTO Medico (persona, specializzazionePrimaria) VALUES
('VRDLGI75L01F205Y', 'Cardiologia'),
('BLCLRA82A41H501Y', 'Neurologia'),
('MRNFBA70M01H501T', 'Dermatologia');

-- Inserimento dati nella tabella SpecializzazioneSecondaria
INSERT INTO SpecializzazioneSecondaria (medico, specializzazione) VALUES
('VRDLGI75L01F205Y', 'Pediatria'),
('BLCLRA82A41H501Y', 'Ortopedia'),
('MRNFBA70M01H501T', 'Pediatria');

-- Inserimento dati nella tabella Paziente
INSERT INTO Paziente (persona, telefoni, email, posta) VALUES
('RSSMRA85M01H501Z', '1234567890', 'mario.rossi@example.com', ROW('Via Roma', '10')),
('BNCPLA90A01F205X', '0987654321', 'paola.bianchi@example.com', ROW('Via Milano', '20'));
('MRNFBA70M01H501T', '6969696969', 'fabio.marinelli@example.com', ROW('Via Bracciano','69'));

-- Inserimento dati nella tabella Prestazione
INSERT INTO Prestazione (dataRichiesta, descrizione, paziente, medico, specializzazioneRichiesta) VALUES
('2024-05-01', 'Visita cardiologica', 'RSSMRA85M01H501Z', 'VRDLGI75L01F205Y', 'Cardiologia'),
('2024-05-02', 'Visita neurologica', 'BNCPLA90A01F205X', 'BLCLRA82A41H501Y', 'Neurologia'),
('2024-05-03', 'Controllo dermatologico', 'RSSMRA85M01H501Z', 'MRNFBA70M01H501T', 'Dermatologia'),
('2024-05-04', 'Visita pediatrica', 'BNCPLA90A01F205X', 'VRDLGI75L01F205Y', 'Pediatria'),
('2024-05-05', 'Controllo ortopedico', 'RSSMRA85M01H501Z', 'BLCLRA82A41H501Y', 'Ortopedia');

-- Inserimento dati nella tabella Stanza
INSERT INTO Stanza (piano, settore) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);

-- Inserimento dati nella tabella PostoLetto
INSERT INTO PostoLetto (stanza) VALUES
(1),
(2),
(3),
(4),
(5);

-- Inserimento dati nella tabella Ricovero
INSERT INTO Ricovero (dataInizio, paziente, medico, storico) VALUES
('2024-05-10', 'RSSMRA85M01H501Z', 'VRDLGI75L01F205Y', 1),
('2024-05-11', 'BNCPLA90A01F205X', 'BLCLRA82A41H501Y', 2);

-- Inserimento dati nella tabella Dimesso
INSERT INTO Dimesso (ricovero, dataFine) VALUES
(1, '2024-05-20');

-- Inserimento dati nella tabella NonDimesso
INSERT INTO NonDimesso (ricovero) VALUES
(2);

-- Inserimento dati nella tabella Occupato
INSERT INTO Occupato (postoletto, nonDimesso) VALUES
(2, 2);
