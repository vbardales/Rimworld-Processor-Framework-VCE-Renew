---
mod: [SYR] Processor Framework - Vanilla Expanded Cooking Renew
packageId: nelim.pf.vce
repo: Rimworld-Processor-Framework-VCE-Renew
remote: https://github.com/vbardales/Rimworld-Processor-Framework-VCE-Renew.git
visibility: public
detached: yes
workflow_stage: playTests[1.0.0]
licence: silent
licence_at: "2026-10-28: no upstream licence anywhere (files, About, Steam page), source mod dead since 1.4; the LICENSE here covers the port only"
upstream_mod_remotes: N/A      # no upstream git repository known; not searched (no corpus search without the owner's yes)
settings_audit: not_applicable
localization: complete
translation_en: complete
translation_fr: complete
dependencies: declared
workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3811323202
published: yes
tested_on: never
remaining:
  - "2026-10-28: unverified: never seen running in game"
  - "2026-10-28: unverified: in game, confirm no empty page under Mod options and no MainButton for this mod (settings_audit, playTests)"
  - "2026-10-28: unverified: optional Pickle passes not set up, Workshop ids of the add-ons unknown"
  - "2026-10-28: unverified: French names of the electric pot and stew pot (marmite électrique, marmite à ragoût) and raffiné not checked against Vanilla Cooking Expanded's French"
protocols_read_sha: a72739d764daa7e295af8decb223ac7a1e086169
updated: 2026-10-28
---

# [SYR] Processor Framework - Vanilla Expanded Cooking Renew: status

Current state only: the front matter above is the source of truth, run lines go to `docs/runs/`.

makeSources: 2.a to 2.f done. ModIcon.png (128 px, 26 KB) and Art/ModIcon.ico regenerated from the new source. New `Art/Preview-source.png` (2026-10-28, from the owner's prompt, replaces a 0.272-value source): Measure-Palette.sh value 0.413, 3 families, vivid 25.2%; PROMPT file deleted. Preview.png, 0-preview.png, Preview.ico, ModIcon.png and ModIcon.ico rendered 2026-10-31 with `Render-Preview.cjs` (no gallery shots yet, so the echo and the Preview are provisional until `mountPreview`). Badge mode run 2026-10-31 on the owner's order: `Art/ModIcon-source.png` transparent border cropped 1254x1254 to 1004x1171, ModIcon.png rebuilt (31 347 bytes), padding lint gone. Target version 1.0.0: only 0.1.0 was released (owner, 2026-10-28), so the first 1.0.0 is still ahead; the CHANGELOG entry dated 2026-09-05 is renamed 0.1.0.

State at 2026-10-28: the repository was rebuilt from the 2026-09-12 sweep format. `Mod/About/PublishedFileId.txt` holds `3811323202`, so the Workshop item exists. The local folder had no `.git` of its own; it now tracks `origin/main` (one commit, `9e50c62`).

## Dependencies (2026-10-28, revision 96427e6)

Read from the sources: `Mod/About/About.xml`, `Mod/loadFolders.xml`, every `Patches_*.xml` and `ProcessDefs_*.xml`.

- **Hard (`modDependencies`):** `syrchalis.processor.framework` (Workshop 3210544395, the `ProcessorFramework.CompProperties_Processor` class every patch writes) and `VanillaExpanded.VCookE` (Workshop 2134308519, the four buildings patched). `PipeSystem` (Vanilla Expanded Framework) appears only as the xpath of the comp being replaced; VCE requires the framework itself, so it is not declared here.
- **Optional, gated in `loadFolders.xml` by `IfModActive`:** `VanillaExpanded.VCookEStews` (Mods/Stews), `VanillaExpanded.VCookESushi` (Mods/Sushi), `zal.braziliancrops` with Stews (Mods/BrazilianCrops, `IfModActiveAll`).
- **Optional, gated by `MayRequire` on the ingredient `<li>`:** `sarg.alphaanimals`, `sarg.rimbees`, `VanillaExpanded.VGeneticsE` (their milks in the cheese filter); `Patches_ElectricPot.xml` lists the stew processes with `MayRequire` on Stews, and on Brazilian Crops plus Stews for the bean stews. No `MayRequire` on an `<Operation>`, no `PatchOperationFindMod`.
- **`loadAfter`:** every id above, plus nothing that depends on this mod, so no cycle. `incompatibleWith`: `Daemon976.PF.VFEC` (the original mod).
- **DLC:** none required. `supportedVersions` and `loadFolders` both 1.6 only.
- **Animal integrations (ANIMALS.md):** not applicable, the mod adds no animal.
- **Not run:** `scripts/sort-load-order.py` needs a staged `Mods` folder with the dependencies; the order was checked by hand above. A Pickle staging at `playTests` runs it for real.

## Settings audit (2026-10-28, revision dec6284)

Result: `not_applicable`.

- **Files read:** all of `Mod/` (`git ls-files`): 1 `loadFolders.xml`, 5 `ProcessorFramework.ProcessDef` files (12 defs), 1 file of 3 `ThingDef` (uncooked bean stews), 7 patch files (`PatchOperationAdd`, `Remove`, `Replace` only), `About.xml`. No `.dll`, no `.cs`, no `Source/`.
- **Inventory:** no existing setting; no `Verse.Mod` subclass is possible without an assembly; no `MainButtonDef`, so no shortcut either. No inherited setting in the files kept from the original.
- **Configurable behaviour:** the process values (rates, ingredient counts, products) are Daemon976's, kept at their original values on purpose (see `CHANGELOG.md`). No player need for a knob: nothing to balance that the framework does not already expose. The framework's own settings page belongs to [SYR] Processor Framework, not to this mod.
- **Decision:** no settings. No empty page and no shortcut can exist from these files.
- **Not verified in game:** that Mod options lists no entry for this mod and that no MainButton appears. Pickle at `playTests`; listed in `remaining`.

## Translation audit (2026-10-28)

- **Inventory (6.a):** the only player-facing texts of the mod are the label and description of the 3 uncooked bean stews (`Mods/BrazilianCrops/Defs/Items_UncookedBeanStew.xml`). The 12 `ProcessorFramework.ProcessDef` carry no text field; the patches replace comps and add no text; no code, so no `Keyed`. About metadata is outside the in-game gate.
- **English (6.b, 6.c):** the Def's own values are the English coverage.
- **French (6.c):** `Mods/BrazilianCrops/Languages/French/DefInjected/ThingDef/Items_UncookedBeanStew.xml`, in the gated folder so it loads only with Brazilian Crops and Stews. `Check-Translations.ps1`: PASS, 6 source texts. `Check-DefInjected.ps1`: 6 keys, 0 errors.
- **Agreement and address (6.d):** no pawn text; masculine nouns (`ragoût`), impersonal `Il faut le cuire`, no tu or vous.
- **`FRENCH_REVIEW.md` (6.f):** generated.
- **Owner's review (6.g):** Virginie, 2026-10-28, revision `8027948` (the French as adjusted after two ChatGPT reviews: word order and infinitive applied, "non cuit" and "gastronomique" declined). No further correction requested. `translation_fr` is `complete`.

## Tests (writeTests, 2026-10-28, revision 1f009fc plus the files of this commit)

- **7.a Scenarios:** `TEST_SCENARIOS.md`, 21 scenarios (T1 to T21), each with its proof. Figures read from the Defs.
- **7.b Automated tests:** not applicable, justified: the mod ships no assembly and has no `Source/`, so there is no logic to unit test. No local script.
- **7.c XML tests:** the shared checks, replayed now, green: `Check-ModBasics.ps1` (14 XML files, 15 defs), `Check-Translations.ps1` (6 source texts), `Check-DefInjected.ps1` (43 patch operations applied, 6 keys, 0 error). None asserts a figure one by one; none is written (see `TEST_SCENARIOS.md`, legend).
- **7.d Pickle suite:** written, not run: `Tests/Pickle/` (companion `nelim.pf.vce.pickletests`, `wsl-ids.map`, `wsl-deps.sans-facultatifs.map`, `01-buildings.feature` 2 scenarios, `02-production.feature` 2 scenarios). `Check-Steps.ps1`: every step line resolves to exactly one expression. T5, T17, T11, T12 covered. The production steps are NPT's (`PickleTools/ColonistRace/Source/ProcessorSteps.cs`, 2026-10-28, compiled and not played, not pushed then). T13 to T16 need the add-on passes. The optional passes are not set up: Workshop ids unknown.
- **7.e Non-applicability:** see 7.b; no artificial test added.
- **7.f Version delivered:** the offline checks and the Pickle suite were written against revision `3ced69e`; any commit touching `Mod/` reopens 7.c and 7.d.
- **7.i:** moved to `playTests[1.0.0]` on 2026-10-28. T13 to T16 stay `unverified` until the optional passes exist.

## Pickle tickets (playTests)

- `20261028-120049-743-7607` filed 2026-10-28: initial minimal pass, 4 scenarios (`01-buildings`, `02-production`), English, `-DepMap wsl-deps.sans-facultatifs.map`, revision `3e99185`, evidence in `Tests/Pickle/Inbox/initial-minimal`. Owner of the ticket: this session. At `RUN_DONE`: read `summary.json` then `junit.xml`, triage (T11 quality Normal at 6 days is an assumption), sort the Inbox (`docs/TEST-EVIDENCE.md`), update this file. Keep `Mod/` and `Tests/` unchanged until then.
