# Changelog

All notable changes to this mod are documented here.

## [Unreleased]

### Changed

- About description no longer names a RimWorld version.
- New Preview illustration and ModIcon source.

## [1.0.0] — 2026-09-05

First release. Revival of Daemon976's **[SYR] Processor Framework - Vanilla Expanded Cooking** for
RimWorld 1.6. Not a version bump: the processes carried over nearly untouched, the patch layer was
rewritten from scratch.

### Fixed

- **Every patch in the mod missed.** The Vanilla Expanded Framework removed `ItemProcessor` in the
  1.6 cycle and Vanilla Cooking Expanded moved its four buildings onto `PipeSystem`, so both of the
  original's xpath targets — `/thingClass` and the `ItemProcessor` comp — are gone from all four
  building defs. All five patch files rewritten against the buildings as they stand in 1.6.
- **`PipeSystem.ITab_Processor` left behind would crash on click.** It overrides `FillTab` and not
  `IsVisible`, so it does not hide itself when its comp is gone. The `<inspectorTabs>` node is now
  removed alongside the comp.
- **`VanillaCookingExpanded.CompProperties_StackByCondiments`**, on the uncooked gourmet bean stew,
  has existed in no version of Vanilla Cooking Expanded since the 1.3 assembly. It degraded quietly
  — `Verse.CompProperties` is concrete, so the loader falls back to it and only logs — which is why
  it survived. Replaced with `<thingClass>VEF.Cooking.GourmetMeal</thingClass>`, the 1.6 idiom.
- **Soy sauce asked for a quality it can no longer have.** `VCE_SoySauce` lost its `CompQuality`
  between 1.4 and 1.6; `usesQuality` on it was a null reference waiting for a batch to finish.
- **Kit's Brazilian Crops support required the Stews add-on and did not say so.** Its recipes are
  gated on `VCE_StewCooking`, a research project that lives in Stews. The folder is now gated on
  both.
- **`PatchOperationFindMod`**, used in three of five patch files, compares display names rather
  than `packageId`s. Replaced throughout by `IfModActive` in `loadFolders.xml` and `MayRequire` on
  list entries.

### Changed

- **Thirteen cheese processes became one with thirteen ingredients.** Vanilla Cooking Expanded 1.6
  merged its thirteen per-milk cheese `ThingDef`s into a single `VCE_Cheese` labelled by ingredient
  through `VEF.Things.CompProperties_LabelByIngredients`. The thirteen products the original named
  no longer exist.
- **Insect jelly is a cheese ingredient**, and **RimBees** is supported — parity with what Vanilla
  Cooking Expanded 1.6 itself makes.
- **Vanilla Factions Expanded - Insectoids support dropped.** Vanilla Cooking Expanded 1.6 dropped
  it, `VCE_InsectCheese` is gone, and the guarded `packageId` belongs to the superseded first
  version of that mod.
- **Soy sauce ferments for a flat ten days** — the Sushi add-on's own 1.6 figure — instead of the
  one-to-sixty-day quality ladder.
- **Kit's Brazilian Crops is patched, not overridden.** The original redefined its three stove
  recipes by `defName`; Brazilian Crops has since rebuilt them for 1.6 and added two bulk variants.
  Only `<products>` is patched now, on all five, so its 1.6 balance is kept and the bulk recipes no
  longer bypass the pot.
- **Add-on support moved into `loadFolders.xml`.** Stews, Sushi and Brazilian Crops each load from
  their own folder, gated on `packageId`.
- `<supportedVersions>` set to 1.6; dependencies declared on [SYR] Processor Framework and Vanilla
  Cooking Expanded; the original declared incompatible.

### Unchanged

- Every `ProcessDef` value Daemon976 set: `capacityFactor`, `efficiency`, `processDays`,
  `usesQuality`, `qualityDays`, and every `<capacity>` on the four buildings.
- Every `defName`.
- The cross-listing that lets the electric pot cook stews and the stew pot cook soups.

### Known losses

Neither is replaced, because replacing them would be rebalancing rather than porting. Both are in
[README.md](README.md#what-was-lost-in-the-move-and-left-lost).

- Soup no longer spoils when the power cuts: PipeSystem's `noPowerDestroysProgress` has no exact
  counterpart in the framework.
- The stew pot no longer swaps to its full texture: `filledGraphicSuffix` cannot reach a
  differently named texture in another mod's folder.
