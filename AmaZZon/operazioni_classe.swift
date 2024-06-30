Operazioni classe Acquisto

valoreBuoni(): Denaro
pre-condizione: nessuno

post-condinzioni:
    Sia B = {(b,s) | acq_buo(this,b) and EXISTS t buo_tip(b,t) and saldo(t,s)}

    result = \sum_{(b,s) in B} s

prezzoSenzaBuoni(): Denaro
pre-condinzioni: nessuna

post-condinzioni:
    Sia O = {(o,q,p_1,p_2) | assegnato(this,o) and quantita(this,o,q) and prezzo(o,p_1) and (
        ALL c,n acq_cit(this,c) and cit_naz(c,n) ->
            p = 1 and -> prezzoBase(o,n,p_2)
                AND
            p != 1 -> (
                NOT EXISTS i int_spe(i,n,o) -> prezzoBase(o,n,p_2)
                    AND
                EXISTS i int_spe(i,n,o) -> EXISTS i' int_spe(i',n,o) 
                    and (ALL i_1 inizio(i',i_1) -> i_1 <= q) and (ALL f fine(i',f) -> f >= q) and prezzo(i',p_2)
            )
        )
    }

    result = \sum_{(o,q,p_1,p_2)} q*p_1+q*p_2

prezzo(): Denaro
pre-condinzioni: nessuna

post-condinzioni:
    ALL p_1,p_2 valoreBuoni_{BuonoRegalo}(this,p_1) and prezzoSenzaBuoni_{BuonoRegalo}(this,p_2) -> result = p_2 - p_1

Operazioni della classe BuonoRegalo

fine(): DataOra
pre-condinzioni: nessuna

post-condinzioni:
    ALL i,t,d inizio(this,i) and buo_tip(this,t) and durataValiditaGiorni(t,d) -> result = i + d

Operazioni della classe Articolo

mediaGiornaliera(i: Data,f: Data): reale >= 0
pre-condinzioni: i <= f

post-condinzioni:
    Sia A = {(a,o,q) | art_off(this,o) and assegnato(a,o) and quantita(a,o,q) and (ALL i' istante(a,i') -> i' >= i and i' <= f)}

    result = (\sum_{(a,o,q) in A} q)/(f-i+1)

Operazioni della classe WishList

offerte(t: DataOra): (o: Offerta,p: Denaro) [0..*]
pre-condinzioni: nessuna

post-condinzioni:
    Sia O  = {(o,p) | EXISTS a salvati(a,this) and art_off(a,o) and (ALL i inizio(o,i) -> i <= t) and (ALL f fine(o,f) -> t <= f) and prezzo(o,p)}
    result = {(o,p) | EXISTS (o_1,p_1) in O and o = o_1 and p = p_1 and NOT EXISTS (o_2,p_2) in O and o_2 = o and p_2 < p_1 }