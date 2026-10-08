BINDING_HEADER_ALTSORT = "Alt Sort"
BINDING_NAME_ALTSORT_SORT = "Sort Bags / Bank"

local DEFAULT_KEY = "ALT-S"
local BINDING_ACTION = "ALTSORT_SORT"
local DB_VERSION = 1

local function Print(msg)
    print("|cff33ff99AltSort:|r " .. msg)
end

-- Bank-open tracking. Set by PLAYER_INTERACTION_MANAGER_FRAME_SHOW/HIDE on
-- clients that have it, and by BANKFRAME_OPENED/CLOSED on clients that don't
-- (e.g. Classic Era). Never poked at frames directly, so a missing frame
-- can't raise an error here.
local bankOpen = false
local bankKind = nil -- "account" (warband bank) or "character"

local PlayerInteractionType = Enum and Enum.PlayerInteractionType

local function OnInteractionShow(interactionType)
    if not PlayerInteractionType then
        return
    end
    if interactionType == PlayerInteractionType.AccountBanker then
        bankOpen, bankKind = true, "account"
    elseif interactionType == PlayerInteractionType.CharacterBanker
        or interactionType == PlayerInteractionType.Banker then
        bankOpen, bankKind = true, "character"
    end
end

local function OnInteractionHide(interactionType)
    if not PlayerInteractionType then
        return
    end
    if interactionType == PlayerInteractionType.AccountBanker
        or interactionType == PlayerInteractionType.CharacterBanker
        or interactionType == PlayerInteractionType.Banker then
        bankOpen, bankKind = false, nil
    end
end

local BankType = Enum and Enum.BankType

-- The bank frame tracks which bank tab (character vs. warband) is actually
-- selected right now; switching tabs inside an already-open bank does NOT
-- re-fire PLAYER_INTERACTION_MANAGER_FRAME_SHOW, so bankKind alone would go
-- stale the moment someone tabs over. Ask the frame directly when we can.
local function GetActiveBankType()
    local panel = BankFrame or BankPanel
    if BankType and panel and panel.GetActiveBankType then
        local ok, activeType = pcall(panel.GetActiveBankType, panel)
        if ok then
            return activeType
        end
    end
    return nil
end

local function IsAccountBankActive()
    local activeType = GetActiveBankType()
    if activeType ~= nil then
        return activeType == BankType.Account
    end
    return bankKind == "account"
end

-- Picks the right sort function for whatever is currently open: the warband
-- (account) bank, the character bank, or (the default) bags. Falls back to
-- the legacy global when a client doesn't have the C_Container namespace.
local function GetSorter()
    if bankOpen then
        if IsAccountBankActive() then
            return (C_Container and C_Container.SortAccountBankBags), "warband bank"
        end
        return (C_Container and C_Container.SortBankBags), "bank"
    end
    return (C_Container and C_Container.SortBags) or SortBags, "bags"
end

-- Called by the key binding (see Bindings.xml). Everything that can go wrong
-- is checked here so a keypress never raises a Lua error.
function AltSort_Sort()
    if InCombatLockdown() then
        Print("Can't sort in combat.")
        return
    end

    if GetCursorInfo() then
        Print("Drop the item on your cursor first.")
        return
    end

    local sort, what = GetSorter()
    if type(sort) ~= "function" then
        Print("Sorting the " .. what .. " isn't available on this client.")
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
frame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
frame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_HIDE")
frame:RegisterEvent("BANKFRAME_OPENED")
frame:RegisterEvent("BANKFRAME_CLOSED")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
        OnInteractionShow(arg1)
        return
    elseif event == "PLAYER_INTERACTION_MANAGER_FRAME_HIDE" then
        OnInteractionHide(arg1)
        return
    elseif event == "BANKFRAME_OPENED" then
        bankOpen, bankKind = true, bankKind or "character"
        return
    elseif event == "BANKFRAME_CLOSED" then
        bankOpen, bankKind = false, nil
        return
    end

    InitDB()

    if TrySeedBinding() then
        self:UnregisterEvent("PLAYER_LOGIN")
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    end
end)
