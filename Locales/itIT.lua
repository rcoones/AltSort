local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "itIT")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Ordina borse / banca"
L["bags"] = "borse"
L["bank"] = "banca"
L["warband bank"] = "banca di brigata"
L["Can't sort in combat."] = "Impossibile ordinare in combattimento."
L["Drop the item on your cursor first."] = "Rilascia prima l'oggetto che hai sul cursore."
L["Open your bank first."] = "Apri prima la tua banca."
L["Sorting the %s isn't available on this client."] = "L'ordinamento (%s) non è disponibile su questo client."
L["Sorting failed: %s"] = "Ordinamento non riuscito: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s è già in uso. Assegna «Ordina borse / banca» in Assegnazione tasti > Alt Sort."
L["Reset. %s is bound to Sort Bags / Bank."] = "Ripristinato. %s è assegnato a «Ordina borse / banca»."
L["Reset. %s will be bound when combat ends."] = "Ripristinato. %s verrà assegnato al termine del combattimento."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - ordina le borse, o la banca se è aperta (come %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - ordina la banca (deve essere aperta)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - riapplica l'assegnazione predefinita %s"
L["/altsort help - show this list"] = "/altsort help - mostra questo elenco"
L["Sort order"] = "Ordine di ordinamento"
L["Ascending"] = "Crescente"
L["Descending"] = "Decrescente"
L["ascending"] = "crescente"
L["descending"] = "decrescente"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "Crescente riempie le borse dal primo spazio. Decrescente le riempie dall'ultimo."
L["Sort order: %s"] = "Ordine di ordinamento: %s"
L["Use /altsort order ascending or /altsort order descending."] = "Usa /altsort order ascending oppure /altsort order descending."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - imposta l'ordine di ordinamento (attuale: %s)"
