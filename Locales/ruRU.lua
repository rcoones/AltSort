local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "ruRU")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Сортировать сумки / банк"
L["bags"] = "сумки"
L["bank"] = "банк"
L["warband bank"] = "банк отряда"
L["Can't sort in combat."] = "Нельзя сортировать в бою."
L["Drop the item on your cursor first."] = "Сначала положите предмет, который находится на курсоре."
L["Open your bank first."] = "Сначала откройте банк."
L["Sorting the %s isn't available on this client."] = "Сортировка (%s) недоступна в этой версии клиента."
L["Sorting failed: %s"] = "Не удалось отсортировать: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s уже занято. Назначьте «Сортировать сумки / банк» в разделе «Назначение клавиш» > Alt Sort."
L["Reset. %s is bound to Sort Bags / Bank."] = "Сброс выполнен. %s назначено на «Сортировать сумки / банк»."
L["Reset. %s will be bound when combat ends."] = "Сброс выполнен. %s будет назначено по окончании боя."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - сортировать сумки или банк, если он открыт (как %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - сортировать банк (он должен быть открыт)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - снова назначить клавишу по умолчанию %s"
L["/altsort help - show this list"] = "/altsort help - показать этот список"
L["Sort order"] = "Порядок сортировки"
L["Ascending"] = "По возрастанию"
L["Descending"] = "По убыванию"
L["ascending"] = "по возрастанию"
L["descending"] = "по убыванию"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "По возрастанию: сумки заполняются с первой ячейки. По убыванию: с последней."
L["Sort order: %s"] = "Порядок сортировки: %s"
L["Use /altsort order ascending or /altsort order descending."] = "Используйте /altsort order ascending или /altsort order descending."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - задать порядок сортировки (сейчас: %s)"
