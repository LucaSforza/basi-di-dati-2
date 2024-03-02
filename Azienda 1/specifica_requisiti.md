# Testo
I dati di interesse per il sistema sono impiegati, dipartimenti, direttori dei dipartimenti e
progetti aziendali.

Di ogni impiegato interessa conoscere il nome, il cognome, la data di nascita e lo
stipendio attuale, il dipartimento (esattamente uno) al quale afferisce.

Di ogni dipartimento interessa conoscere il nome, il numero di telefono del centralino,
e la data di afferenza di ognuno degli impiegati che vi lavorano.

Di ogni dipartimento interessa conoscere inoltre il direttore, che è uno degli impiegati
dell’azienda.

Il sistema deve permettere di rappresentare i progetti aziendali nei quali sono coinvolti
i diversi impiegati. Di ogni progetto interessa il nome ed il budget. Ogni impiegato può
partecipare ad un numero qualsiasi di progetti.

# 1. Impiegato
- 1.1 CF: Stringa
- 1.2 Nome: Stringa
- 1.3 Cognome: Stringa
- 1.4 DataN: Data
- 1.5 Stipendio: Integer
- 1.6 isDirettore: bool

Data di Afferenza è tra la relazione di Impiegato e Dipartimento

# 2. Dipartimento
- 2.1 Nome: Stringa
- 2.2 NumeroTel: Stringa

Relazione tra Dipartimento e Inpiegato per salvarsi qual'è il direttore

# 3. Progetto
- 3.1 Nome: Stringa
- 3.2 Budget: Integer

Relazione tra Progetto e inpiegati, ogni inpiegato può partecipare a più progetti e nessuno e ogni progetto ha tanti inpiegati e potenzialmente inizialmente nessuno

# NOTE:
In stipendio e il budget dei vari progetti è Integer, ma le prime 2 cifre sono i centesimi