BINDING_HEADER_ALTSORT = "Alt Sort"
BINDING_NAME_ALTSORT_SORT = "Sort Bags"

local DEFAULT_KEY = "ALT-S"

local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")

-- Seed the default keyboard hotkey exactly once. After that the user owns the
-- binding (changing or clearing it in Key Bindings is always respected).
frame:SetScript("OnEvent", function()
    AltSortDB = AltSortDB or {}

    if AltSortDB.seeded or InCombatLockdown() then
        return
    end

    if GetBindingAction(DEFAULT_KEY) == "" then
        SetBinding(DEFAULT_KEY, "ALTSORT_SORT")
        SaveBindings(GetCurrentBindingSet())
    end

    AltSortDB.seeded = true
end)
