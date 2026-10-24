local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "ptBR")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Organizar bolsas / banco"
L["bags"] = "bolsas"
L["bank"] = "banco"
L["warband bank"] = "banco do bando de guerra"
L["Can't sort in combat."] = "Não é possível organizar em combate."
L["Drop the item on your cursor first."] = "Solte primeiro o item que está no cursor."
L["Open your bank first."] = "Abra seu banco primeiro."
L["Sorting the %s isn't available on this client."] = "Organizar (%s) não está disponível neste cliente."
L["Sorting failed: %s"] = "Falha ao organizar: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s já está em uso. Atribua “Organizar bolsas / banco” em Atalhos > Alt Sort."
L["Reset. %s is bound to Sort Bags / Bank."] = "Redefinido. %s está atribuída a “Organizar bolsas / banco”."
L["Reset. %s will be bound when combat ends."] = "Redefinido. %s será atribuída quando o combate terminar."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - organiza as bolsas, ou o banco se estiver aberto (igual a %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - organiza o banco (precisa estar aberto)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - reaplica o atalho padrão %s"
L["/altsort help - show this list"] = "/altsort help - mostra esta lista"
L["Sort order"] = "Ordem de classificação"
L["Ascending"] = "Crescente"
L["Descending"] = "Decrescente"
L["ascending"] = "crescente"
L["descending"] = "decrescente"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "Crescente preenche as bolsas a partir do primeiro espaço. Decrescente preenche a partir do último."
L["Sort order: %s"] = "Ordem de classificação: %s"
L["Use /altsort order ascending or /altsort order descending."] = "Use /altsort order ascending ou /altsort order descending."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - definir a ordem de classificação (atual: %s)"
