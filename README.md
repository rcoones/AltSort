# Alt Sort

A tiny World of Warcraft addon that sorts your bags with **Alt+S**.

## Features

- Press **Alt+S** to sort your bags.
- Open your bank (or the warband bank) and press **Alt+S** to sort it instead — same key, no extra bindings.
- Uses Blizzard's built-in sorting functionality.
- Rebindable in **Key Bindings > Alt Sort**.
- Optional `/altsort` slash command (see below).
- Extremely lightweight.

## Installation

Extract the `AltSort` folder into:

`World of Warcraft/_retail_/Interface/AddOns/`

## Usage

Log into World of Warcraft and press **Alt+S**.

On first login Alt Sort binds **Alt+S** (only if that key is free). It is never re-applied, so if you rebind or clear it, your choice is kept.

## Slash commands

The key binding is all most people need, but `/altsort` is there if you prefer typing or want to use it in a macro:

| Command | What it does |
| --- | --- |
| `/altsort sort` | Sorts your bags, or the bank if it is open (same as **Alt+S**). |
| `/altsort bank` | Sorts the bank. Does nothing but tell you so if no bank is open. |
| `/altsort reset` | Re-applies the default **Alt+S** binding, if that key is free. |
| `/altsort help` | Lists these commands. `/altsort` on its own does the same. |

## Development

Alt Sort is built on [Ace3](https://github.com/WoWUIDev/Ace3) (AceAddon, AceEvent, AceConsole, AceDB, AceLocale). The libraries are vendored in `Libs/` (Ace3 release r1403), so a plain checkout runs as-is. To update them, copy the same folders from a newer Ace3 release.

User-facing strings live in `Locales/`. `enUS.lua` is the source of truth; to add a language, create `Locales/<locale>.lua` that starts with `LibStub("AceLocale-3.0"):NewLocale("AltSort", "<locale>")`, fill in the translations, and list the file in `AltSort.toc` after `enUS.lua`.
