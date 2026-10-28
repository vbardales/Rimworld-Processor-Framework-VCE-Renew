# In-game scenarios, run by Pickle

Written at `writeTests`, **not played** (2026-10-28). Scenarios and their proofs: `../../TEST_SCENARIOS.md`.

## Why the game is needed

Everything provable outside the game is proved outside it (`Check-ModBasics`, `Check-Translations`, `Check-DefInjected`). What is left is what only a running game shows: that the converted buildings spawn, are selected and tick with nothing logged (the removed `PipeSystem.ITab_Processor` threw on click), and, once a step exists, that they make their product.

## Passes

| Pass | `-DepMap` | `-Filter` | What it stages | State |
|---|---|---|---|---|
| minimal | `wsl-deps.sans-facultatifs.map` | `01-buildings.feature` | Pickle, PickleTools InspectTabs, [SYR] Processor Framework, Vanilla Cooking Expanded, this mod | written |
| optional: Stews, Sushi, Brazilian Crops, Alpha Animals, RimBees, Vanilla Genetics | none yet | none yet | the minimal pass plus each add-on | **not set up**: the Workshop ids of the add-ons are not known (`wsl-ids.map`); resolving them needs a search of the Workshop corpus, which needs the owner's yes |
| English and French | `-Language English`, `-Language French` | the minimal feature | replays the French of the three uncooked bean stews | needs Brazilian Crops and Stews, so waits for the optional pass |

No restart sequence, no DLC-absent pass: the mod has no settings and no DLC guard.

## Evidence

`Evidence/`, `Inbox/` and `Parked/` are on disk only (gitignored). A ticket deposits its run in `Inbox/<run>`; the mod's session sorts it (`AGENTS.md`, "Test evidence").
