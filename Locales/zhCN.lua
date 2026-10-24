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
