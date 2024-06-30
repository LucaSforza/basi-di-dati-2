-- Popolamento della tabella Nazione
insert into Nazione (nome) values 
('Italia'),
('Francia'),
('Germania');

-- Popolamento della tabella Citta
insert into Citta (nome, nazione) values 
('Roma', 'Italia'),
('Milano', 'Italia'),
('Parigi', 'Francia'),
('Berlino', 'Germania');

-- Popolamento della tabella Negozio
insert into Negozio (ragioneSociale, indirizzo, telefono) values 
('Tech Store Roma', ROW('Via del Corso', '123'), '0661234567'),
('Fashion Milano', ROW('Via Montenapoleone', '5'), '0276543210');

-- Popolamento della tabella IndirizzoEmail
insert into IndirizzoEmail (email, negozio) values 
('info@techstoreroma.it', 'Tech Store Roma'),
('contact@fashionmilano.it', 'Fashion Milano');

-- Popolamento della tabella Marca
insert into Marca (nome) values 
('Apple'),
('Samsung');

-- Popolamento della tabella Categoria
insert into Categoria (nome) values 
('Elettronica'),
('Abbigliamento');

-- Popolamento della tabella Tag
insert into Tag (nome) values 
('Nuovo'),
('Sconto');

-- Popolamento della tabella Articolo
insert into Articolo (codice, nome, descrizione, numeroModello, marca, categoria) values 
('A001', 'iPhone 13', 'Smartphone Apple con 128GB di memoria', 'M001', 'Apple', 'Elettronica'),
('A002', 'Galaxy S21', 'Smartphone Samsung con 256GB di memoria', 'M002', 'Samsung', 'Elettronica');

-- Popolamento della tabella art_tag
insert into art_tag (articolo, tag) values 
('A001', 'Nuovo'),
('A002', 'Sconto');

-- Popolamento della tabella Offerta
insert into Offerta (prezzo, inizio, fine, articolo, negozio) values 
(899.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 'A001', 'Tech Store Roma'),
(799.99, '2024-02-01 00:00:00', null, 'A002', 'Tech Store Roma');

-- Popolamento della tabella Spedizione
insert into Spedizione (nazione, offerta, prezzoBase) values 
('Italia', 1, 10.00),
('Francia', 1, 15.00),
('Germania', 2, 20.00);

-- Popolamento della tabella IntervalloPerRiduzione
insert into IntervalloPerRiduzione (inizio, fine, prezzo, spedizione) values 
(2, 5, 8.00, 1),
(6, 10, 5.00, 1);

-- Popolamento della tabella Utente
insert into Utente (nickname, istanteReg, nome, cognome) values 
('mario_rossi', '2024-01-15 12:00:00', 'Mario', 'Rossi'),
('anna_bianchi', '2024-02-20 15:30:00', 'Anna', 'Bianchi');

-- Popolamento della tabella amiciziaPending
insert into amiciziaPending (invia, riceve) values 
('mario_rossi', 'anna_bianchi'),
('anna_bianchi', 'mario_rossi');

-- Popolamento della tabella amicizia
insert into amicizia (da, a) values 
('mario_rossi', 'anna_bianchi');

-- Popolamento della tabella CartaDiCredito
insert into CartaDiCredito (numero, dataScadenza, utente) values 
('4111111111111111', '2025-12-31', 'mario_rossi'),
('5500000000000004', '2026-11-30', 'anna_bianchi');

-- Popolamento della tabella Acquisto
insert into Acquisto (istante, indirizzoArrivo, citta, utente) values 
('2024-03-10 10:00:00', ROW('Via della Conciliazione', '10'), 1, 'mario_rossi'),
('2024-04-15 16:45:00', ROW('Via Libertà', '20'), 2, 'anna_bianchi');

-- Popolamento della tabella Assegnato
insert into Assegnato (acquisto, offerta, quantita) values 
(1, 1, 1),
(2, 2, 2);

-- Popolamento della tabella TipologiaBuonoRegalo
insert into TipologiaBuonoRegalo (nome, saldo, durataValiditaGiorni) values 
('Buono Sconto 10%', 50.00, 365),
('Buono Sconto 20%', 100.00, 180);

-- Popolamento della tabella BuonoRegalo
insert into BuonoRegalo (inizio, tipologia, acquisto, possiede, acquistato) values 
('2024-05-01 12:00:00', 1, 1, 'mario_rossi', 'anna_bianchi'),
('2024-06-01 14:00:00', 2, 2, 'anna_bianchi', 'mario_rossi');

-- Popolamento della tabella WishList
insert into WishList (nome, utente, tipo) values 
('Desideri Mario', 'mario_rossi', 'Privata'),
('Desideri Anna', 'anna_bianchi', 'Pubblica');

-- Popolamento della tabella Rilevamento
insert into Rilevamento (istante, wishList) values 
('2024-07-01 18:00:00', 1),
('2024-08-01 19:00:00', 2);

-- Popolamento della tabella salvati
insert into salvati (wishList, articolo) values 
(1, 'A001'),
(2, 'A002');
