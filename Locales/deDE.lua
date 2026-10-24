local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "deDE")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "Taschen / Bank sortieren"
L["bags"] = "Taschen"
L["bank"] = "Bank"
L["warband bank"] = "Kriegsmeutenbank"
L["Can't sort in combat."] = "Im Kampf kann nicht sortiert werden."
L["Drop the item on your cursor first."] = "Lege zuerst den Gegenstand an deinem Mauszeiger ab."
L["Open your bank first."] = "Öffne zuerst deine Bank."
L["Sorting the %s isn't available on this client."] = "Sortieren ist für %s auf diesem Client nicht verfügbar."
L["Sorting failed: %s"] = "Sortieren fehlgeschlagen: %s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s ist bereits belegt. Weise „Taschen / Bank sortieren“ unter Tastaturbelegung > Alt Sort zu."
L["Reset. %s is bound to Sort Bags / Bank."] = "Zurückgesetzt. %s ist mit „Taschen / Bank sortieren“ belegt."
L["Reset. %s will be bound when combat ends."] = "Zurückgesetzt. %s wird belegt, sobald der Kampf endet."
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - Taschen sortieren, oder die Bank, falls geöffnet (wie %s)"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - Bank sortieren (muss geöffnet sein)"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - Standardbelegung %s erneut anwenden"
L["/altsort help - show this list"] = "/altsort help - diese Liste anzeigen"
L["Sort order"] = "Sortierreihenfolge"
L["Ascending"] = "Aufsteigend"
L["Descending"] = "Absteigend"
L["ascending"] = "aufsteigend"
L["descending"] = "absteigend"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "Aufsteigend füllt die Taschen ab dem ersten Platz. Absteigend füllt sie ab dem letzten Platz."
L["Sort order: %s"] = "Sortierreihenfolge: %s"
L["Use /altsort order ascending or /altsort order descending."] = "Verwende /altsort order ascending oder /altsort order descending."
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - Sortierreihenfolge festlegen (aktuell: %s)"
