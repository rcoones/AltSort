-- Unit tests for AltSort. The WoW API is stubbed; each test loads a fresh copy
-- of AltSort.lua against a fresh fake client.

local STUBBED = {
    "AltSortDB", "AltSort_Sort", "C_Container", "SortBags", "CreateFrame",
    "InCombatLockdown", "GetCursorInfo", "GetBindingAction", "SetBinding",
    "SaveBindings", "GetCurrentBindingSet", "print",
    "BINDING_HEADER_ALTSORT", "BINDING_NAME_ALTSORT_SORT",
}

local function setglobal(name, value)
    _G[name] = value
end

describe("AltSort", function()
    local saved, client, frame

    -- Builds the fake client. opts: db, combat, cursor, bound, setBindingFails,
    -- container ("none" | "error" | default working), legacySort.
    local function load_addon(opts)
        opts = opts or {}
        client = {
            combat = opts.combat or false,
            cursor = opts.cursor,
            bound = opts.bound or {},
            setBindingFails = opts.setBindingFails or false,
            setBindingCalls = 0,
            saveCalls = 0,
            sortCalls = 0,
            legacySortCalls = 0,
            printed = {},
        }
        frame = { events = {}, scripts = {}, unregistered = false }

        function frame:RegisterEvent(event) self.events[event] = true end
        function frame:SetScript(name, fn) self.scripts[name] = fn end
        function frame:UnregisterAllEvents()
            self.events = {}
            self.unregistered = true
        end

        setglobal("AltSortDB", opts.db)
        setglobal("CreateFrame", function() return frame end)
        setglobal("InCombatLockdown", function() return client.combat end)
        setglobal("GetCursorInfo", function() return client.cursor end)
        setglobal("GetBindingAction", function(key) return client.bound[key] or "" end)
        setglobal("SetBinding", function(key, action)
            client.setBindingCalls = client.setBindingCalls + 1
            if client.setBindingFails then return false end
            client.bound[key] = action
            return true
        end)
        setglobal("SaveBindings", function() client.saveCalls = client.saveCalls + 1 end)
        setglobal("GetCurrentBindingSet", function() return 1 end)
        setglobal("print", function(msg) client.printed[#client.printed + 1] = msg end)

        if opts.container == "error" then
            setglobal("C_Container", { SortBags = function() error("boom") end })
        elseif opts.container ~= "none" then
            setglobal("C_Container", { SortBags = function() client.sortCalls = client.sortCalls + 1 end })
        end
        if opts.legacySort then
            setglobal("SortBags", function() client.legacySortCalls = client.legacySortCalls + 1 end)
        end

        dofile("AltSort.lua")
    end

    local function fire(event)
        frame.scripts.OnEvent(frame, event)
    end

    before_each(function()
        saved = {}
        for _, name in ipairs(STUBBED) do
            saved[name] = _G[name]
            _G[name] = nil
        end
    end)

    after_each(function()
        for _, name in ipairs(STUBBED) do
            _G[name] = saved[name]
        end
    end)

    describe("AltSort_Sort", function()
        it("sorts via C_Container", function()
            load_addon()
            AltSort_Sort()
            assert.are.equal(1, client.sortCalls)
            assert.are.equal(0, #client.printed)
        end)

        it("refuses to sort in combat", function()
            load_addon({ combat = true })
            AltSort_Sort()
            assert.are.equal(0, client.sortCalls)
            assert.are.equal(1, #client.printed)
        end)

        it("refuses to sort while an item is on the cursor", function()
            load_addon({ cursor = "item" })
            AltSort_Sort()
            assert.are.equal(0, client.sortCalls)
            assert.are.equal(1, #client.printed)
        end)

        it("falls back to the legacy SortBags global", function()
            load_addon({ container = "none", legacySort = true })
            AltSort_Sort()
            assert.are.equal(1, client.legacySortCalls)
            assert.are.equal(0, #client.printed)
        end)

        it("prints a message when no sort API exists", function()
            load_addon({ container = "none" })
            assert.has_no.errors(AltSort_Sort)
            assert.are.equal(1, #client.printed)
        end)

        it("contains errors raised by the sort call", function()
            load_addon({ container = "error" })
            assert.has_no.errors(AltSort_Sort)
            assert.is_truthy(client.printed[1]:find("Sorting failed", 1, true))
        end)
    end)

    describe("saved variables", function()
        it("creates a versioned table when none exists", function()
            load_addon()
            fire("PLAYER_LOGIN")
            assert.are.equal("table", type(AltSortDB))
            assert.is_not_nil(AltSortDB.version)
        end)

        it("replaces a corrupt non-table value", function()
            load_addon({ db = "garbage" })
            fire("PLAYER_LOGIN")
            assert.are.equal("table", type(AltSortDB))
        end)

        it("keeps existing data", function()
            load_addon({ db = { version = 1, custom = "x" } })
            fire("PLAYER_LOGIN")
            assert.are.equal("x", AltSortDB.custom)
        end)
    end)

    describe("default key seeding", function()
        it("binds ALT-S when it is free", function()
            load_addon()
            fire("PLAYER_LOGIN")
            assert.are.equal("ALTSORT_SORT", client.bound["ALT-S"])
            assert.are.equal(1, client.saveCalls)
            assert.is_true(AltSortDB.seeded)
            assert.is_true(frame.unregistered)
        end)

        it("does nothing once seeded", function()
            load_addon({ db = { seeded = true } })
            fire("PLAYER_LOGIN")
            assert.are.equal(0, client.setBindingCalls)
            assert.is_true(frame.unregistered)
        end)

        it("treats an existing AltSort binding as done without rebinding", function()
            load_addon({ bound = { ["ALT-S"] = "ALTSORT_SORT" } })
            fire("PLAYER_LOGIN")
            assert.are.equal(0, client.setBindingCalls)
            assert.is_true(AltSortDB.seeded)
        end)

        it("leaves a taken key alone and notifies only once", function()
            load_addon({ bound = { ["ALT-S"] = "SOMETHING_ELSE" } })
            fire("PLAYER_LOGIN")
            fire("PLAYER_REGEN_ENABLED")
            assert.are.equal("SOMETHING_ELSE", client.bound["ALT-S"])
            assert.are.equal(0, client.setBindingCalls)
            assert.is_falsy(AltSortDB.seeded)
            assert.are.equal(1, #client.printed)
        end)

        it("waits for combat to end", function()
            load_addon({ combat = true })
            fire("PLAYER_LOGIN")
            assert.are.equal(0, client.setBindingCalls)
            assert.is_falsy(AltSortDB.seeded)
            assert.is_false(frame.unregistered)

            client.combat = false
            fire("PLAYER_REGEN_ENABLED")
            assert.are.equal("ALTSORT_SORT", client.bound["ALT-S"])
            assert.is_true(AltSortDB.seeded)
        end)

        it("does not mark seeded or save when SetBinding fails", function()
            load_addon({ setBindingFails = true })
            fire("PLAYER_LOGIN")
            assert.are.equal(0, client.saveCalls)
            assert.is_falsy(AltSortDB.seeded)
            assert.is_false(frame.unregistered)
        end)
    end)
end)
