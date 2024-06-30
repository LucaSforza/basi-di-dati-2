paeseConTantiAcquisti(i: Data,f: Data): Nazione [0..*]
pre-condinzione: i <= f

post-condinzioni:
    Sia N_1 = {(n,a,q) | EXISTS c cit_naz(c,n) and acq_cit(a,c) and EXISTS i' istante(a,i') and i' >= i and i' <= f 
        and EXISTS o quantita(a,o,q)}
    Sia N_2 = {(n,m) | Nazione(n) and (
        m = \sum_{(n',a,q) in N_1 and n = n'} q
    )}
    result = arg_max_{(n,m) in N_1}(m)

ricerca(c: Categoria,T: Tag [0..*],n: Nazione): (a: Articolo,p: Denaro) [0..*]
pre-condinzioni: nessuno

post-condinzioni:
    Sia A = {(a,o,p) | art_cat(a,c) and EXISTS t in T and art_tag(a,t) and art_off(a,o) and spedizione(n,o) 
        and EXISTS p_1,p_2 prezzo(o,p_1) and prezzoBase(n,o,p_2) and p = p_1 + p_2 }

    result = {(a,p) | EXISTS (a',o,p_1) in A and a' = a and (NOT EXISTS (a'',o',p') in A and a'' = a and p' < p_1) and p = p_1}

articoliModa(): Articolo [0..*]
pre-condinzione: nessuna

post-condinzione:
    result = {a | EXISTS r_1,r_2 mediaGiornaliera_{Articolo,Data,Data}(dataOggi-30,dataOggi,r_2)
        and mediaGiornaliera_{Articolo,Data,Data}(dataOggi-90,dataOggi-31,r_1) and r_1 < r_2}