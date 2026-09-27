local button = CreateFrame("Button", "AltSortButton", UIParent)

button:SetScript("OnClick", function()
    C_Container.SortBags()
end)

local bindingFrame = CreateFrame("Frame")

bindingFrame:RegisterEvent("PLAYER_LOGIN")
bindingFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

bindingFrame:SetScript("OnEvent", function()
    if InCombatLockdown() then
        return
    end

    SetOverrideBindingClick(bindingFrame, true, "ALT-S", "AltSortButton")
end)
