local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "esES")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Ordenar bolsas / banco"
L["bags"] = "bolsas"
L["bank"] = "banco"
L["warband bank"] = "banco de banda de guerra"
L["Can't sort in combat."] = "No se puede ordenar en combate."
L["Drop the item on your cursor first."] = "Suelta primero el objeto que tienes en el cursor."
L["Open your bank first."] = "Abre primero tu banco."
L["Sorting the %s isn't available on this client."] = "Ordenar (%s) no está disponible en este cliente."
L["Sorting failed: %s"] = "Error al ordenar: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s ya está en uso. Asigna «Ordenar bolsas / banco» en Asignación de teclas > Alt Sort."
L["Reset. %s is bound to Sort Bags / Bank."] = "Restablecido. %s está asignada a «Ordenar bolsas / banco»."
L["Reset. %s will be bound when combat ends."] = "Restablecido. %s se asignará cuando termine el combate."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - ordena las bolsas, o el banco si está abierto (igual que %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - ordena el banco (debe estar abierto)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - vuelve a aplicar la asignación predeterminada %s"
L["/altsort help - show this list"] = "/altsort help - muestra esta lista"
