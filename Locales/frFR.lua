local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "frFR")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Trier sacs / banque"
L["bags"] = "sacs"
L["bank"] = "banque"
L["warband bank"] = "banque de bataillon"
L["Can't sort in combat."] = "Impossible de trier en combat."
L["Drop the item on your cursor first."] = "Déposez d'abord l'objet qui se trouve sur votre curseur."
L["Open your bank first."] = "Ouvrez d'abord votre banque."
L["Sorting the %s isn't available on this client."] = "Le tri (%s) n'est pas disponible sur ce client."
L["Sorting failed: %s"] = "Échec du tri : %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s est déjà utilisé. Assignez « Trier sacs / banque » dans Raccourcis clavier > Alt Sort."
L["Reset. %s is bound to Sort Bags / Bank."] = "Réinitialisé. %s est assigné à « Trier sacs / banque »."
L["Reset. %s will be bound when combat ends."] = "Réinitialisé. %s sera assigné à la fin du combat."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - trie les sacs, ou la banque si elle est ouverte (comme %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - trie la banque (doit être ouverte)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - réapplique le raccourci par défaut %s"
L["/altsort help - show this list"] = "/altsort help - affiche cette liste"
L["Sort order"] = "Ordre de tri"
L["Ascending"] = "Croissant"
L["Descending"] = "Décroissant"
L["ascending"] = "croissant"
L["descending"] = "décroissant"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "Croissant remplit les sacs à partir du premier emplacement. Décroissant les remplit à partir du dernier."
L["Sort order: %s"] = "Ordre de tri : %s"
L["Use /altsort order ascending or /altsort order descending."] = "Utilisez /altsort order ascending ou /altsort order descending."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - définir l'ordre de tri (actuel : %s)"
