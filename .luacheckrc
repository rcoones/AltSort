std = "lua51"
max_line_length = 120

-- Globals this addon defines
globals = {
    "AltSortDB",
    "AltSort_Sort",
    "BINDING_HEADER_ALTSORT",
    "BINDING_NAME_ALTSORT_SORT",
}

-- WoW API globals this addon uses
read_globals = {
    "C_Container",
    "CreateFrame",
    "GetBindingAction",
    "GetCurrentBindingSet",
    "GetCursorInfo",
    "InCombatLockdown",
    "SaveBindings",
    "SetBinding",
    "SortBags",
}

-- Specs stub the WoW API by assigning globals dynamically
files["spec"] = {
    std = "+busted",
}
