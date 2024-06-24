-- Popolamento della tabella TipoDocumento
insert into TipoDocumento (nome) values
('Carta di Identità'),
('Patente di Guida'),
('Passaporto'),
('Permesso di Soggiorno'),
('Tessera Sanitaria');

-- Popolamento della tabella Promotore
insert into Promotore (matricola, nome, cognome) values
('MATR001', 'Paolo', 'Rossi'),
('MATR002', 'Giorgio', 'Bianchi'),
('MATR003', 'Elena', 'Verdi'),
('MATR004', 'Silvia', 'Neri'),
('MATR005', 'Marco', 'Gialli');

-- Popolamento della tabella Cliente con nomi diversi dai promotori
insert into Cliente (codiceFiscale, nome, cognome, indirizzoEmail, codiceDocumento, tipoDocumento) values
('VRDLRA80C50H501X', 'Laura', 'Verdi', 'laura.verdi@example.com', 'W123456', 'Carta di Identità'),
('BNCLGA75D60H501Y', 'Gabriella', 'Bianchi', 'gabriella.bianchi@example.com', 'X654321', 'Patente di Guida'),
('RSSLRA65E70H501Z', 'Lara', 'Rossi', 'lara.rossi@example.com', 'Y789012', 'Passaporto'),
('MNCDVD55F80H501X', 'Davide', 'Monaco', 'davide.monaco@example.com', 'Z890123', 'Carta di Identità'),
('PLCRIC45G90H501Y', 'Riccardo', 'Palmeri', 'riccardo.palmeri@example.com', 'A123456', 'Passaporto'),
('LBGFRA35H01H501Z', 'Francesca', 'Labriola', 'francesca.labriola@example.com', 'B654321', 'Patente di Guida'),
('RSPANT25I20H501X', 'Antonio', 'Raspini', 'antonio.raspini@example.com', 'C789012', 'Carta di Identità'),
('CNCLMR15L30H501Y', 'Lorenzo', 'Cancelli', 'lorenzo.cancelli@example.com', 'D890123', 'Passaporto'),
('CSTFRN05M40H501Z', 'Franco', 'Castelli', 'franco.castelli@example.com', 'E901234', 'Permesso di Soggiorno'),
('BRNNCL55N50H501W', 'Nicola', 'Bruni', 'nicola.bruni@example.com', 'F123456', 'Tessera Sanitaria');

-- Popolamento della tabella RecapitoTelefonico
insert into RecapitoTelefonico (numero, cliente) values
('1234567890', 'VRDLRA80C50H501X'),
('0987654321', 'BNCLGA75D60H501Y'),
('1122334455', 'RSSLRA65E70H501Z'),
('2233445566', 'MNCDVD55F80H501X'),
('3344556677', 'PLCRIC45G90H501Y'),
('4455667788', 'LBGFRA35H01H501Z'),
('5566778899', 'RSPANT25I20H501X'),
('6677889900', 'CNCLMR15L30H501Y'),
('7788990011', 'CSTFRN05M40H501Z'),
('8899001122', 'BRNNCL55N50H501W');

-- Popolamento della tabella Gestione
insert into Gestione (inizio, terminato, fine, motivo, promotore, cliente) values
('2023-01-01 10:00:00', false, null, null, 'MATR001', 'VRDLRA80C50H501X'),
('2023-01-02 11:00:00', true, '2023-01-03 15:00:00', 'Completata', 'MATR002', 'BNCLGA75D60H501Y'),
('2023-01-04 09:30:00', false, null, null, 'MATR003', 'RSSLRA65E70H501Z'),
('2023-01-05 14:00:00', true, '2023-01-06 16:00:00', 'Completata', 'MATR004', 'MNCDVD55F80H501X'),
('2023-01-07 13:00:00', false, null, null, 'MATR005', 'PLCRIC45G90H501Y');

-- Popolamento della tabella Emittente
insert into Emittente (nome, tipo) values
('Azienda1', 'Azienda'),
('Azienda2', 'Azienda'),
('Stato1', 'Stato'),
('Stato2', 'Stato'),
('Azienda3', 'Azienda');

-- Popolamento della tabella StrumentoFinanziario
insert into StrumentoFinanziario (emittente) values
('Azienda1'),
('Azienda2'),
('Stato1'),
('Stato2'),
('Azienda3');

-- Popolamento della tabella Rilevazione
insert into Rilevazione (istante, valore, strumento) values
('2023-01-01 10:00:00', 100.50, 1),
('2023-01-02 11:00:00', 200.75, 2),
('2023-01-03 12:00:00', 300.00, 3),
('2023-01-04 13:00:00', 400.25, 4),
('2023-01-05 14:00:00', 500.50, 5);

-- Popolamento della tabella Titolo
insert into Titolo (strumento, tipo) values
(2, 'Obbligazione'),
(3, 'TitoloDiStato'),
(4, 'Azione'),
(5, 'Obbligazione');

-- Popolamento della tabella FondoGestito
insert into FondoGestito (strumento, numAzioni, numObbligazioni, numTitoliDiStato) values
(1, 10, 5, 0);

-- Popolamento della tabella Investimento
insert into Investimento (quantita, istante, gestione, strumento) values
(1000.50, '2023-01-01 10:00:00', 1, 1),
(2000.75, '2023-01-02 11:00:00', 2, 2),
(3000.00, '2023-01-03 12:00:00', 3, 3),
(4000.25, '2023-01-04 13:00:00', 4, 4),
(5000.50, '2023-01-05 14:00:00', 5, 5);

-- Popolamento della tabella Disinvestimento
insert into Disinvestimento (quantita, istante, investimento) values
(500.25, '2023-01-06 15:00:00', 1),
(1000.50, '2023-01-07 16:00:00', 2),
(1500.75, '2023-01-08 17:00:00', 3),
(2000.00, '2023-01-09 18:00:00', 4),
(2500.25, '2023-01-10 19:00:00', 5);
