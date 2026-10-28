# Test scenarios

One scenario per behaviour the mod promises (`README.md`, "What the mod does"). Figures are read from the Defs on 2026-10-28, revision at the time of writing: `Mod/Defs`, `Mod/Mods/*/Defs`, `Mod/Patches`, `Mod/Mods/*/Patches`.

How each one is proved:

- **Offline** = `scripts/Check-ModBasics.ps1` (XML well-formed, 15 defs), `Check-Translations.ps1`, `Check-DefInjected.ps1` (applies every patch to the loaded Vanilla Cooking Expanded defs: 43 operations applied, 14 of them this mod's, no failure reported). None of them asserts a figure: for T1 to T4 and T6 to T10 the offline proof is that the patches apply and the Defs are valid, and the figures were read in the files by the session. No script checks them one by one, and none is written: a figure only changes with a commit, and the in-game `def ... field` step can confirm one at `playTests`.
- **Pickle** = a scenario in `Tests/Pickle/Mod/Pickle/Features/`, played by a ticket at `playTests`.
- **Pickle, production steps** = the steps NPT wrote on 2026-10-28 on this mod's request (`PickleTools/ColonistRace/Source/ProcessorSteps.cs`: fill a building, advance its process by days, empty it, assert the product). Compiled, not played, not pushed at that date. They leave power, fuel, temperature and speed factor out.

## The four buildings take the framework's processor

| # | Scenario | Setup | Expected | Proof |
|---|---|---|---|---|
| T1 | Cheese press carries the framework comp | VCE, framework | `VCE_CheesePress` has `ProcessorFramework.CompProperties_Processor`, `capacity` 5, `independentProcesses` true, one process `VCE_Cheese`, no `inspectorTabs` | Offline (patch applies, 0 failure) |
| T2 | Electric pot carries the framework comp | VCE, framework | `VCE_ElectricPot`: `capacity` 2, four soup processes (`VCE_CookedSoupSimple`, `Fine`, `Lavish`, `Gourmet`); with Stews, three stews; with Brazilian Crops and Stews, three bean stews | Offline |
| T3 | Stew pot carries the framework comp | VCE Stews | `VCE_StewPot`: `capacity` 10, three stews and four soups; with Brazilian Crops, three bean stews | Offline |
| T4 | Soy fermenter carries the framework comp | VCE Sushi | `VCE_SoyFermenter`: `capacity` 10, process `PF_VCE_SoySauce` | Offline |
| T5 | Each building spawns, is selected and ticks without a logged error (the removed `PipeSystem.ITab_Processor` would throw on click) | `test-colony`, minimal pass | Press and pot spawned and selected, 120 ticks, no error | Pickle `01-buildings.feature` |

## The processes keep Daemon976's figures

| # | Process | Figures to hold | Proof |
|---|---|---|---|
| T6 | `VCE_Cheese` | `capacityFactor` 2.5, `usesQuality` true, `qualityDays` (1, 3, 6, 12, 24, 48, 60), filter: `Milk`, `InsectJelly`, plus the milks of Alpha Animals (3), RimBees (1), Vanilla Genetics Expanded (9) behind `MayRequire` | Offline (read from the Def) |
| T7 | `VCE_CookedSoup*` | `efficiency` 10, `capacityFactor` 1, `processDays` 0.5, 0.7, 1, 1 (Simple, Fine, Lavish, Gourmet); each takes the matching `VCE_UncookedSoup*` | Offline |
| T8 | `VCE_CookedStew*` | `efficiency` 10, `processDays` 0.5, 0.7, 1 (Simple, Fine, Lavish) | Offline |
| T9 | `KIT_BeanStew*` | `efficiency` 10, `processDays` 0.5, 0.7, 1 (Fine, Lavish, Gourmet); each takes the matching `KIT_UncookedStew*` | Offline |
| T10 | `PF_VCE_SoySauce` | `capacityFactor` 2.5, `processDays` 10 (600 000 ticks), no quality, ingredient `VCE_RawSoybean` | Offline |

## What the buildings make

| # | Scenario | Setup | Expected | Proof |
|---|---|---|---|---|
| T11 | Milk becomes cheese, with quality and a label | Press, 10 milk, 6 days | A `VCE_Cheese` product of quality Normal (third step of `qualityDays`), label containing "cheese". The count is not asserted | Pickle `02-production.feature`, minimal pass |
| T12 | One uncooked soup becomes ten cooked soups | Pot, 1 `VCE_UncookedSoupSimple`, 0.5 day | 10 `VCE_CookedSoupSimple` | Pickle `02-production.feature`, minimal pass |
| T13 | Stew in the stew pot, soup in the stew pot, stew in the electric pot | Stews | Same result as T12 with the stew defs | Pickle (step needs an add-on pass) |
| T14 | Soybeans become soy sauce in 10 days, no quality | Fermenter, Sushi | `VCE_SoySauce`, no `CompQuality` error in the log | Pickle (step needs an add-on pass) |
| T15 | Brazilian Crops bean stew goes through the pot | Brazilian Crops, Stews | The stove recipes give `KIT_UncookedStew*`, the pot gives `KIT_BeanStew*` | Pickle (step needs an add-on pass) |
| T16 | Alpha Animals, RimBees, Vanilla Genetics milks are accepted by the press | Each add-on | The milk is in the press filter | Offline for the Def; step to write for the press |

## Add-ons load themselves, and only when present

| # | Scenario | Expected | Proof |
|---|---|---|---|
| T17 | Without any add-on, no unresolved reference | `loadFolders.xml` loads `/` only; no error at load | Pickle `01-buildings.feature` (minimal pass) |
| T18 | With Stews, Sushi, Brazilian Crops | Each folder loads on its own `packageId`; Brazilian Crops folder needs Stews too | Pickle, optional pass (Workshop ids of the add-ons to resolve first) |
| T19 | Declared incompatibility with the original (`Daemon976.PF.VFEC`) | Game warns, mod list shows the conflict | Owner, in game |

## Text

| # | Scenario | Expected | Proof |
|---|---|---|---|
| T20 | The three uncooked bean stews are named and described in French | `Languages/French/DefInjected/ThingDef/Items_UncookedBeanStew.xml` resolves 6 keys | Offline (`Check-DefInjected`: 6 keys, 0 error); in game at `playTests` |
| T21 | No empty Mod options page, no main-bar button | `settings_audit: not_applicable` | Pickle at `playTests`, owner's eye |

## Known gaps, not defects

- T13 to T16 need the Stews, Sushi, Brazilian Crops and animal add-ons staged: the steps exist, the optional passes are not set up (Workshop ids unknown). Until then they are **unverified**, never counted as passed. T11 and T12 are written, not played.
- The quality of the T11 cheese at 6 days assumes the framework maps the days of `qualityDays` to Awful, Poor, Normal, Good, Excellent, Masterwork, Legendary in order. Not read in the framework: the first run decides.
- The stew pot no longer swaps to its full texture, and soup no longer spoils on a power cut: both are documented losses (`README.md`, "What was lost in the move"), not scenarios.
