local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "zhTW")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "整理背包 / 銀行"
L["bags"] = "背包"
L["bank"] = "銀行"
L["warband bank"] = "戰團銀行"
L["Can't sort in combat."] = "戰鬥中無法整理。"
L["Drop the item on your cursor first."] = "請先放下游標上的物品。"
L["Open your bank first."] = "請先打開銀行。"
L["Sorting the %s isn't available on this client."] = "此用戶端不支援整理%s。"
L["Sorting failed: %s"] = "整理失敗：%s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s 已被使用。請在 按鍵設定 > Alt Sort 中綁定「整理背包 / 銀行」。"
L["Reset. %s is bound to Sort Bags / Bank."] = "已重設。%s 已綁定至「整理背包 / 銀行」。"
L["Reset. %s will be bound when combat ends."] = "已重設。戰鬥結束後將綁定 %s。"
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - 整理背包；若銀行已打開則整理銀行（等同於 %s）"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - 整理銀行（必須已打開）"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - 重新套用預設的 %s 綁定"
L["/altsort help - show this list"] = "/altsort help - 顯示此列表"
L["Sort order"] = "排序順序"
L["Ascending"] = "升序"
L["Descending"] = "降序"
L["ascending"] = "升序"
L["descending"] = "降序"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "升序從第一個格子開始填入背包，降序從最後一個格子開始填入。"
L["Sort order: %s"] = "排序順序：%s"
L["Use /altsort order ascending or /altsort order descending."] = "請使用 /altsort order ascending 或 /altsort order descending。"
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - 設定排序順序（目前：%s）"
