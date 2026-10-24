local AltSort = LibStub("AceAddon-3.0"):NewAddon("AltSort", "AceEvent-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("AltSort")

BINDING_HEADER_ALTSORT = L["Alt Sort"]
BINDING_NAME_ALTSORT_SORT = L["Sort Bags / Bank"]

local DEFAULT_KEY = "ALT-S"
local BINDING_ACTION = "ALTSORT_SORT"
local DB_VERSION = 1

local DB_DEFAULTS = {
    global = {
        dbVersion = DB_VERSION,
        seeded = false,
        conflictNotified = false,
        sortOrder = "ascending",
    },
}

local SORT_ORDERS = { ascending = true, descending = true }

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

-- Everything that can go wrong is checked here so neither the key binding nor
-- the slash command can raise a Lua error. requireBank is for `/altsort bank`:
-- refuse (rather than quietly sorting bags) when no bank is open.
local function DoSort(requireBank)
    if InCombatLockdown() then
        Print(L["Can't sort in combat."])
        return
    end

    if GetCursorInfo() then
        Print(L["Drop the item on your cursor first."])
        return
    end

    if requireBank and not bankOpen then
        Print(L["Open your bank first."])
        return
    end

    local sort, what = GetSorter()
    if type(sort) ~= "function" then
        Print(L["Sorting the %s isn't available on this client."]:format(L[what]))
        return
    end

    -- "descending" packs items from the last slot backwards (Blizzard's
    -- right-to-left option). Reapplied on every sort so it always matches the
    -- saved setting. Only bags honour it; skipped where the client has no toggle.
    if C_Container and C_Container.SetSortBagsRightToLeft then
        pcall(C_Container.SetSortBagsRightToLeft, AltSort:GetSortOrder() == "descending")
    end

    local ok, err = pcall(sort)
    if not ok then
        Print(L["Sorting failed: %s"]:format(tostring(err)))
    end
end

-- Called by the key binding (see Bindings.xml).
function AltSort_Sort()
    DoSort(false)
end

-- AceDB treats AltSortDB as its own saved-variable root, so a corrupt value
-- has to be replaced before it sees it. Before AceDB, the flags below lived
-- at the top level of AltSortDB; carry them into db.global once so nobody has
-- the default key re-seeded over their own binding choice.
local LEGACY_KEYS = { "seeded", "conflictNotified", "version" }

function AltSort:InitDB()
    if type(AltSortDB) ~= "table" then
        AltSortDB = {}
    end

    local legacy = {}
    for _, key in ipairs(LEGACY_KEYS) do
        legacy[key] = AltSortDB[key]
        AltSortDB[key] = nil
    end

    self.db = LibStub("AceDB-3.0"):New("AltSortDB", DB_DEFAULTS, true)

    if legacy.seeded then
        self.db.global.seeded = true
    end
    if legacy.conflictNotified then
        self.db.global.conflictNotified = true
    end
end

function AltSort:GetSortOrder()
    local order = self.db.global.sortOrder
    if not SORT_ORDERS[order] then
        return "ascending"
    end
    return order
end

-- Returns false for anything that isn't a known order. Also moves the Settings
-- panel's dropdown along when the change came from the slash command.
function AltSort:SetSortOrder(order)
    if not SORT_ORDERS[order] then
        return false
    end
    self.db.global.sortOrder = order
    if self.sortOrderSetting then
        pcall(self.sortOrderSetting.SetValue, self.sortOrderSetting, order)
    end
    return true
end

-- Adds Alt Sort to the game's Settings window. Uses Blizzard's own Settings API
-- (no extra libraries); clients without it just keep the slash command.
function AltSort:RegisterOptions()
    if not (Settings and Settings.RegisterVerticalLayoutCategory and Settings.RegisterAddOnSetting
        and Settings.CreateDropdown and Settings.RegisterAddOnCategory) then
        return
    end

    local category = Settings.RegisterVerticalLayoutCategory(L["Alt Sort"])
    local setting = Settings.RegisterAddOnSetting(category, "ALTSORT_SORT_ORDER", "sortOrder", self.db.global,
        Settings.VarType.String, L["Sort order"], "ascending")

    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        container:Add("ascending", L["Ascending"])
        container:Add("descending", L["Descending"])
        return container:GetData()
    end
    Settings.CreateDropdown(category, setting, GetOptions,
        L["Ascending fills bags from the first slot. Descending fills them from the last slot."])
    Settings.RegisterAddOnCategory(category)
    self.sortOrderSetting = setting
end

-- Seed the default keyboard hotkey. Once it succeeds the user owns the binding
-- (changing or clearing it in Key Bindings is always respected). Returns true
-- when seeding is finished and no further attempts are needed.
function AltSort:TrySeedBinding()
    local global = self.db.global
    if global.seeded then
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
        if not global.conflictNotified then
            global.conflictNotified = true
            Print(L["%s is already in use. Bind Sort Bags under Key Bindings > Alt Sort."]:format(DEFAULT_KEY))
        end
        return false
    end

    global.seeded = true
    return true
end

-- Forget that the default key was ever seeded (or that we complained about it)
-- and try again right away. Re-registers the event TrySeedBinding retires.
function AltSort:ResetBinding()
    local global = self.db.global
    global.seeded = false
    global.conflictNotified = false

    if self:TrySeedBinding() then
        Print(L["Reset. %s is bound to Sort Bags / Bank."]:format(DEFAULT_KEY))
        return
    end

    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    if InCombatLockdown() then
        Print(L["Reset. %s will be bound when combat ends."]:format(DEFAULT_KEY))
    end
end

function AltSort:PrintHelp()
    Print(L["/altsort sort - sort bags, or the bank if it is open (same as %s)"]:format(DEFAULT_KEY))
    Print(L["/altsort bank - sort the bank (must be open)"])
    Print(L["/altsort order <ascending|descending> - set the sort order (currently: %s)"]
        :format(L[self:GetSortOrder()]))
    Print(L["/altsort reset - re-apply the default %s binding"]:format(DEFAULT_KEY))
    Print(L["/altsort help - show this list"])
end

local COMMANDS = {
    sort = function() DoSort(false) end,
    bank = function() DoSort(true) end,
    order = function(arg)
        if arg == "" then
            Print(L["Sort order: %s"]:format(L[AltSort:GetSortOrder()]))
        elseif AltSort:SetSortOrder(arg) then
            Print(L["Sort order: %s"]:format(L[arg]))
        else
            Print(L["Use /altsort order ascending or /altsort order descending."])
        end
    end,
    reset = function() AltSort:ResetBinding() end,
    help = function() AltSort:PrintHelp() end,
}

function AltSort:OnSlashCommand(msg)
    local command, arg = (msg or ""):lower():match("^%s*(%S*)%s*(.-)%s*$")
    local handler = COMMANDS[command]
    if handler then
        handler(arg)
    else
        self:PrintHelp()
    end
end

function AltSort:PLAYER_INTERACTION_MANAGER_FRAME_SHOW(_, interactionType)
    OnInteractionShow(interactionType)
end

function AltSort:PLAYER_INTERACTION_MANAGER_FRAME_HIDE(_, interactionType)
    OnInteractionHide(interactionType)
end

function AltSort:BANKFRAME_OPENED()
    bankOpen, bankKind = true, bankKind or "character"
end

function AltSort:BANKFRAME_CLOSED()
    bankOpen, bankKind = false, nil
end

function AltSort:PLAYER_REGEN_ENABLED()
    if self:TrySeedBinding() then
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    end
end

function AltSort:OnInitialize()
    self:InitDB()
    self:RegisterChatCommand("altsort", "OnSlashCommand")
    self:RegisterOptions()
end

-- AceAddon enables us at PLAYER_LOGIN, which is when the binding APIs are ready.
function AltSort:OnEnable()
    self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
    self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_HIDE")
    self:RegisterEvent("BANKFRAME_OPENED")
    self:RegisterEvent("BANKFRAME_CLOSED")

    if not self:TrySeedBinding() then
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
    end
end
