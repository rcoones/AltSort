local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "enUS", true)
if not L then
    return
end

-- Key Bindings menu
L["Alt Sort"] = true
L["Sort Bags / Bank"] = true

-- What is being sorted (used in "isn't available" messages)
L["bags"] = true
L["bank"] = true
L["warband bank"] = true

-- Settings panel and /altsort order
L["Sort order"] = true
L["Ascending"] = true
L["Descending"] = true
L["ascending"] = true
L["descending"] = true
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = true
L["Sort order: %s"] = true
L["Use /altsort order ascending or /altsort order descending."] = true

-- Messages
L["Can't sort in combat."] = true
L["Drop the item on your cursor first."] = true
L["Open your bank first."] = true
L["Sorting the %s isn't available on this client."] = true
L["Sorting failed: %s"] = true
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = true
L["Reset. %s is bound to Sort Bags / Bank."] = true
L["Reset. %s will be bound when combat ends."] = true

-- /altsort help (the command names themselves are not translated)
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = true
L["/altsort bank - sort the bank (must be open)"] = true
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = true
L["/altsort reset - re-apply the default %s binding"] = true
L["/altsort help - show this list"] = true
