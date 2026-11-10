# In-game scenarios, run by Pickle

Written at `writeTests`, **not played** (2026-10-28). Scenarios and their proofs: `../../TEST_SCENARIOS.md`.

## Why the game is needed

Everything provable outside the game is proved outside it (`Check-ModBasics`, `Check-Translations`, `Check-DefInjected`). What is left is what only a running game shows: that the converted buildings spawn, are selected and tick with nothing logged (the removed `PipeSystem.ITab_Processor` threw on click), and that the cheese press and the electric pot make their product (steps of PickleTools ColonistRace).

## Passes

| Pass | `-DepMap` | `-Filter` | What it stages | State |
|---|---|---|---|---|
| minimal | `wsl-deps.sans-facultatifs.map` | `01-buildings.feature`, `02-production.feature` | Pickle, PickleTools InspectTabs and ColonistRace (production steps), [SYR] Processor Framework, Vanilla Cooking Expanded, this mod | written |
| optional: cuisine | `wsl-deps.cuisine.map` | `04-cuisine.feature` | minimal plus Stews, Sushi | filed |
| optional: brazilian | `wsl-deps.brazilian.map` | `06-brazilian.feature` | minimal plus Stews, Brazilian Crops and Vanilla Brewing Expanded (its VBE_* defs; without it the save does not load) | filed |
| English and French | `-Language English`, `-Language French` | the minimal feature | replays the French of the three uncooked bean stews | needs Brazilian Crops and Stews, so waits for the brazilian pass |

No restart sequence, no DLC-absent pass: the mod has no settings and no DLC guard.

## Evidence

`Evidence/`, `Inbox/` and `Parked/` are on disk only (gitignored). A ticket deposits its run in `Inbox/<run>`; the mod's session sorts it (`AGENTS.md`, "Test evidence").
