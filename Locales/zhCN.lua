local L = LibStub("AceLocale-3.0"):NewLocale("AltSort", "zhCN")
if not L then
    return
end

-- "Alt Sort" (the addon name) is intentionally left in English.
L["Sort Bags / Bank"] = "整理背包 / 银行"
L["bags"] = "背包"
L["bank"] = "银行"
L["warband bank"] = "战团银行"
L["Can't sort in combat."] = "战斗中无法整理。"
L["Drop the item on your cursor first."] = "请先放下光标上的物品。"
L["Open your bank first."] = "请先打开银行。"
L["Sorting the %s isn't available on this client."] = "此客户端不支持整理%s。"
L["Sorting failed: %s"] = "整理失败：%s"
L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."] = "%s 已被占用。请在 按键设置 > Alt Sort 中绑定“整理背包 / 银行”。"
L["Reset. %s is bound to Sort Bags / Bank."] = "已重置。%s 已绑定到“整理背包 / 银行”。"
L["Reset. %s will be bound when combat ends."] = "已重置。战斗结束后将绑定 %s。"
L["/altsort sort - sort bags, or the bank if it is open (same as %s)"] = "/altsort sort - 整理背包；若银行已打开则整理银行（等同于 %s）"
L["/altsort bank - sort the bank (must be open)"] = "/altsort bank - 整理银行（必须已打开）"
L["/altsort reset - re-apply the default %s binding"] = "/altsort reset - 重新应用默认的 %s 绑定"
L["/altsort help - show this list"] = "/altsort help - 显示此列表"
L["Sort order"] = "排序顺序"
L["Ascending"] = "升序"
L["Descending"] = "降序"
L["ascending"] = "升序"
L["descending"] = "降序"
L["Ascending fills bags from the first slot. Descending fills them from the last slot."] = "升序从第一个格子开始填充背包，降序从最后一个格子开始填充。"
L["Sort order: %s"] = "排序顺序：%s"
L["Use /altsort order ascending or /altsort order descending."] = "请使用 /altsort order ascending 或 /altsort order descending。"
L["/altsort order <ascending|descending> - set the sort order (currently: %s)"] = "/altsort order <ascending|descending> - 设置排序顺序（当前：%s）"
