std = "lua51"
max_line_length = 120

-- Ace3 callbacks are methods, so an unused self is normal
ignore = { "212/self" }

-- CI installs luarocks dependencies into the workspace; Libs/ is vendored Ace3
exclude_files = { ".luarocks", "Libs" }

-- Globals this addon defines
globals = {
    "AltSortDB",
    "AltSort_Sort",
    "BINDING_HEADER_ALTSORT",
    "BINDING_NAME_ALTSORT_SORT",
}

-- WoW API globals this addon uses
read_globals = {
    "BankFrame",
    "BankPanel",
    "C_Container",
    "CreateFrame",
    "Enum",
    "GetBindingAction",
    "GetCurrentBindingSet",
    "GetCursorInfo",
    "InCombatLockdown",
    "LibStub",
    "SaveBindings",
    "SetBinding",
    "SortBags",
}

-- Specs stub the WoW API by assigning globals dynamically
files["spec"] = {
    std = "+busted",
    globals = { "SLASH_ACECONSOLE_ALTSORT1", "SlashCmdList" },
}
