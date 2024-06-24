create or replace function valorePortafoglio(p Matr,c CF)
returns Denaro as $$
begin
    if not exists(
        select *
        from Gestione g
        where g.promotore = p and g.cliente = c and not g.terminato and g.inizio <= now()::timestamp
    ) then return null; end if; --in realtà al posto di 'return null' ci va: raise exception 'Error 003 - cliente non è del promotore';

    return (
        select sum(valoreIN(i.id,now()::timestamp))
        from Gestione g,Investimento i
        where g.cliente = c and i.gestione = g.id
        group by i.id
    );

end;
$$ language plpgsql;

/*
rischioCliente(c: Cliente): Rischio
Sia p: Promotore che si è autenticato dal sistema
pre-condizioni: EXISTS g,t ges_pro(g,p) and cli_ges(c,g) and not GestioneTerminata(g) and (ALL i inizio(g,i) -> i <= adesso)

post-condizioni:
    Sia F = {(f,v) | EXISTS i,g inv_str(i,f) and ges_inv(g,i) and cli_ges(c,g) and FondoGestito(f) 
        and (ALL a,x percentualeAzioni_{FondoGestito}(f,a) and valore_{Investimento,DataOra}(i,adesso,x) -> v = x*a)}
    Sia A = {(a,v) | EXISTS i,g inv_str(i,f) and ges_inv(g,i) and cli_ges(c,g) and Azione(a) and valore_{Investimento,DataOra}(i,adesso,v)}

    Sia T = {(s,v) | EXISTS i,g inv_str(i,f) and ges_inv(g,i) and cli_ges(c,g) and valore_{Investimento,DataOra}(i,adesso,v)}

    |T| = 0 -> result = "Basso"
        and
    |T| != 0 -> (
        ALL alpha, alpha = [(\sum_{(f,v) in F} v) + (\sum_{(a,v) in A} v)]/(\sum_{(s,v)} v) -> (
            alpha <= 0.10 -> result = "Basso"
                and
            alpha > 0.10 and alpha <= 0.40 -> result = "Moderato"
                and
            alpha > 0.40 and alpha <= 0.60 -> result = "Alto"
                and
            alpha > 0.60 -> result = "Aggressivo"
        )
    )
*/

create or replace function rischioCliente(p Matr,c CF)
returns Rischio as $$
declare
    valoreFondi Denaro  = null;
    valoreAzioni Denaro = null;
    valoreTotale Denaro = valorePortafoglio(p,c);
    alpha RealGEZ = null;
begin
    if not exists(
        select *
        from Gestione g
        where g.promotore = p and g.cliente = c and not g.terminato and g.inizio <= now()::timestamp
    ) then return null; end if; --in realtà al posto di 'return null' ci va: raise exception 'Error 003 - cliente non è del promotore';

    if valoreTotale = 0 or valoreTotale is null then return 'Basso'; end if;

    select sum(valoreIN(i.id,now()::timestamp)*percentualeAzioni(f.id))
    into valoreFondi
    from Gestione g,Investimento i,StrumentoFinanziario f
    where i.strumento = f.id and g.id = i.gestione and g.cliente = c and exists (
        select *
        from FondoGestito fg
        where fg.strumento = f.id
    );

    select sum(valoreIN(i.id,now()::timestamp))
    into valoreAzioni
    from Gestione g,Investimento i,StrumentoFinanziario f
    where i.strumento = f.id and g.id = i.gestione and g.cliente = c and exists (
        select *
        from Titolo t
        where t.strumento = f.id and t.tipo = 'Azione'
    );

    alpha := COALESCE(valoreFondi,0)+COALESCE(valoreAzioni,0)/valoreTotale;

    if alpha <= 0.1 then return 'Basso';
    elsif alpha > 0.1 and alpha <= 0.4 then return 'Moderato';
    elsif alpha > 0.4 and alpha <= 0.6 then return 'Alto';
    else
        return 'Aggressivo';
    end if;

end;
$$ language plpgsql;