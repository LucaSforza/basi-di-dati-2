Nazione(_nome: String _)

Citta(_id: serial_,nome: String,nazione: String)
    FK: nazione references Nazione(nome)

Negozio(_ragioneSociale: RagSoc_,indirizzo: Ind,*telefono: Tel)
    v. inclusione: Negozio(ragioneSociale) occorre in IndirizzoEmail(negozio)

IndirizzoEmail(_id: serial_,email: Email,negozio: RagSoc)
    FK: negozio references Negozio(ragioneSociale)

Marca(_nome: String _)

Categoria(_nome: String _)

Tag(_nome: String _)

Articolo(_codice: Cod_,nome: String,descrizione: Text, numeroModello: String,marca: String,categoria: String)
    FK: marca references Marca(nome)
    FK: categoria references Categoria(nome)
    altra chiave: (numeroModello,marca)

art_tag(_articolo: Cod,tag: String _)
    FK: articolo references Articolo(codice)
    FK: tag references Tag(nome)

Offerta(_id: serial_,prezzo: Denaro,inizio: timestamp,*fine: timestamp,articolo: Cod,negozio: RagSoc)
    FK: articolo references Articolo(codice)
    FK: negozio references Negozio(ragioneSociale)
    v. ennupla: fine is null or (inizio <= fine)

Spedizione(_id: serial_,nazione: String, offerta: Integer,prezzoBase: Denaro)
    FK: nazione references Nazione(nome)
    FK: offerta references Offerta(id)
    altra chiave: (nazione,offerta)

IntervalloPerRiduzione(_id: serial_,inizio: IntegerGONE,*fine: IntegerGONE,prezzo: Denaro,spedizione: Integer)
    FK: spedizione references Spedizione(id)

Utente(_nickname: String _,istanteReg: timestamp, nome: String,cognome: String)

amiciziaPending(_invia: String,riceve: String _)
    FK: invia references Utente(nickname)
    FK: riceve references Utente(nickname)

amicizia(_da: String,a: String)
    FK: (da,a) references amiciziaPending(invia,riceve)

CartaDiCredito(_numero: NumCarta_,dataScadenza: date,utente: String)
    FK: utente references Utente(nickname)

Acquisto(_id: serial_,istante: timestamp, indirizzoArrivo: Ind,citta: Integer, utente: String)
    FK: utente references Utente(nickname)
    FK: citta references Citta(id)
    v. inclusione Acquisto(id) in Assegnato(acquisto)

Assegnato(_acquisto: Integer,offerta: Integer _,quantita: IntegerGZ)
    FK: acquisto references Acquisto(id)
    FK: offerta references Offerta(id)

TipologiaBuonoRegalo(_id: serial_,nome: String,saldo: Denaro,durataValiditaGiorni: IntegerGZ)

BuonoRegalo(_id: serial_,inizio: timestamp,tipologia: Integer,*acquisto: Integer,possiede: String,acquistato: String)
    FK: tipologia references TipologiaBuonoRegalo(id)
    FK: acquisto references Acquisto(id)
    FK: possiede references Utente(nickname)
    FK: acquistato references Utente(nickname)

WishList(_id: serial_,nome: String,utente: String,tipo: TipWishList)
    FK: utente references Utente(nickname)
    altra chiave: (nome,utente)

Rilevamento(_id: serial_,istante: timestamp,wishList: Integer)
    FK: wishList references WishList(id)
    altra chiave: (istante,wishList)

salvati(_wishList: Integer,articolo: Cod_)
    FK: wishList references WishList(id)
    FK: articolo references Articolo(codice)