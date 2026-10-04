BINDING_HEADER_ALTSORT = "Alt Sort"
BINDING_NAME_ALTSORT_SORT = "Sort Bags"

local DEFAULT_KEY = "ALT-S"
local BINDING_ACTION = "ALTSORT_SORT"
local DB_VERSION = 1

local function Print(msg)
    print("|cff33ff99AltSort:|r " .. msg)
end

-- Called by the key binding (see Bindings.xml). Everything that can go wrong
-- is checked here so a keypress never raises a Lua error.
function AltSort_Sort()
    if InCombatLockdown() then
        Print("Can't sort bags in combat.")
        return
    end

    if GetCursorInfo() then
        Print("Drop the item on your cursor first.")
        return
    end

    local sort = (C_Container and C_Container.SortBags) or SortBags
    if type(sort) ~= "function" then
        Print("Bag sorting isn't available on this client.")
        return
    end

    local ok, err = pcall(sort)
    if not ok then
        Print("Sorting failed: " .. tostring(err))
    end
end

local function InitDB()
    if type(AltSortDB) ~= "table" then
        AltSortDB = {}
    end
    AltSortDB.version = AltSortDB.version or DB_VERSION
end

-- Seed the default keyboard hotkey. Once it succeeds the user owns the binding
-- (changing or clearing it in Key Bindings is always respected). Returns true
-- when seeding is finished and no further attempts are needed.
local function TrySeedBinding()
    if AltSortDB.seeded then
        return true
    end

    if InCombatLockdown() then
        return false -- retried on PLAYER_REGEN_ENABLED
    end

    local current = GetBindingAction(DEFAULT_KEY)

    if current == "" then
        if not SetBinding(DEFAULT_KEY, BINDING_ACTION) then
            return false
        end
        SaveBindings(GetCurrentBindingSet())
    elseif current ~= BINDING_ACTION then
        if not AltSortDB.conflictNotified then
            AltSortDB.conflictNotified = true
            Print(DEFAULT_KEY .. " is already in use. Bind Sort Bags under Key Bindings > AddOns > AltSort.")
        end
        return false
    end

    AltSortDB.seeded = true
    return true
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")

frame:SetScript("OnEvent", function(self)
    InitDB()

    if TrySeedBinding() then
        self:UnregisterAllEvents()
    end
end)
