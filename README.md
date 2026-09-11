# [SYR] Processor Framework - Vanilla Expanded Cooking Renew

Revival of **Daemon976's [SYR] Processor Framework - Vanilla Expanded Cooking** for RimWorld 1.6.

**I am not the author of this mod.** The idea, the processes and their balance are Daemon976's.
Credit goes to them; mistakes in this version are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2887181698 (declares 1.3 and
1.4, last updated in the 1.4 cycle). The page is still online; the mod is abandoned, not
withdrawn.

**This is not a version bump.** The premise still holds — run Vanilla Cooking Expanded's cheeses
and soups on [SYR] Processor Framework instead of the processor they ship with — but the thing it
converts *from* has been replaced. The processes came through nearly untouched. All five patch
files were rewritten from scratch. [Why](#what-actually-broke) is the bulk of this README.

## What the mod does

Vanilla Cooking Expanded has four buildings that turn one thing into another over time. This mod
takes them off the processor Vanilla Cooking Expanded uses and puts them on
**[SYR] Processor Framework** instead.

| Building | From | Makes |
|---|---|---|
| Cheese press | Vanilla Cooking Expanded | cheese, from milk or insect jelly, quality by age |
| Electric pot | Vanilla Cooking Expanded | soup, and stew if you have it |
| Stew pot | VCE - Stews | stew, and soup |
| Soy sauce fermenter | VCE - Sushi | soy sauce, from soybeans |

Nothing about the food changes. The same milk makes the same cheese at the same rate. What you get
instead is the framework's interface in front of it: one tab listing every product with its
ingredients as sub-nodes you can allow or forbid one at a time, its fill and empty work givers,
its progress bar, and the product drawn on the building.

Also supported, when installed: **Alpha Animals**, **RimBees**, **Vanilla Genetics Expanded**
(their milks feed the cheese press) and **Kit's Brazilian Crops** (its bean stews go through the
pot).

## Requires

- **[SYR] Processor Framework** — use
  [the maintained version](https://steamcommunity.com/workshop/filedetails/?id=3210544395), which
  supports 1.6 and keeps Syrchalis's `packageId`.
- **Vanilla Cooking Expanded**.

No DLC. No assembly: eleven XML files, nothing else.

Add-on support loads itself. `loadFolders.xml` gates each folder on a `packageId`, so nothing has
to be enabled by hand and nothing dangles when an add-on is absent.

## What actually broke

The original mod is **inert** on 1.6 — not harmful, inert. Every one of its patches misses.

In the 1.4 cycle, all four buildings ran on `ItemProcessor`, a module of the Vanilla Expanded
Framework, and declared it twice over:

```xml
<thingClass>ItemProcessor.Building_ItemProcessor</thingClass>
<comps>
  <li Class="ItemProcessor.CompProperties_ItemProcessor"> …
```

Both of the original's xpaths aim at those two lines. In the 1.6 cycle the Vanilla Expanded
Framework **removed `ItemProcessor`** — the same removal that broke Mechanoid Factory — and
Vanilla Cooking Expanded moved onto the framework's pipe-system processor instead. Counting files
that mention `ItemProcessor`, per version folder:

| | 1.4 | 1.5 | 1.6 |
|---|---|---|---|
| Vanilla Cooking Expanded | 7 | 6 | **0** |
| VCE - Stews | 3 | 3 | **0** |
| VCE - Sushi | 3 | 3 | **0** |

So there is nothing left to remove and nothing left to replace. Worth saying plainly, because the
first guess is the frightening one: the `<thingClass>` removals do **not** corrupt the buildings.
In 1.6 none of the four declares a `thingClass` at all — they are plain `ParentName="BuildingBase"`
— so that operation finds no node and does nothing, like the rest.

What each building carries now:

```xml
<inspectorTabs><li>PipeSystem.ITab_Processor</li></inspectorTabs>
<comps>
  <li Class="PipeSystem.CompProperties_AdvancedResourceProcessor">
    <processes><li>VCE_MilkIntoCheese</li><li>VCE_JellyIntoCheese</li></processes> …
```

The conversion is therefore: drop that comp, drop that tab, add
`ProcessorFramework.CompProperties_Processor` with a `<processes>` list.

### The inspector tab is not cosmetic

`PipeSystem.ITab_Processor` overrides `FillTab` and nothing else. It does not override
`IsVisible`, so it does not hide itself when its comp is gone: it stays on the building and
reaches for a `CompAdvancedResourceProcessor` that is no longer there, the moment the player clicks
it. Removing the comp without removing the tab trades an inert mod for a crashing one.

The framework adds its own tabs by Harmony patch and wants none declared in XML — its own
`BarrelProcessor` has no `<inspectorTabs>` — so the node is removed outright rather than emptied.

### Nothing is left registered in a pipe net

`PipeSystem.CompAdvancedResourceProcessor` derives straight from `ThingComp`, not from
`CompResource`, and none of the four buildings carries a resource comp or names a pipe net. Taking
the comp away leaves no net membership behind.

### Vanilla Cooking Expanded's own process defs are left alone

`VCE_MilkIntoCheese`, `VCE_JellyIntoCheese` and the add-ons' equivalents stay where they are,
orphaned. A `PipeSystem.ProcessDef` is only ever read through a `CompAdvancedResourceProcessor`, so
once no building lists them they cost nothing but a line in the def database — and deleting defs
that belong to another mod would break any third mod that happens to name them. Leaving them is
the smaller footprint, not the lazier one.

## Thirteen cheeses became one

The largest single change, and it is Vanilla Cooking Expanded's, not mine.

Vanilla Cooking Expanded used to ship one cheese `ThingDef` per milk: `VCE_GowCheese`,
`VCE_WeirdCheese`, `VCE_RatCheese`, thirteen in all. The original mod needed one `ProcessDef` each
in order to name each product. In 1.6 every one of those is gone. There is a single `VCE_Cheese`,
and the milk it came from is read back off the stack by
`VEF.Things.CompProperties_LabelByIngredients`, which renames it *gow cheese*, *rat cheese*, and so
on. Naming any of the thirteen would now be an unresolved cross-reference and nothing more.

So the thirteen milks moved from thirteen products to one ingredient filter on one process. This
is also the shape the framework's tab wants — it lists products with their ingredients as
sub-nodes — where thirteen processes would have been thirteen identical rows reading *cheese*.

The framework registers ingredients on what it makes (`CompIngredients`) and sets its quality
(`CompQuality`), so the label and the quality both survive the move.

Two adjustments came with it:

- **Insect jelly is now an ingredient.** Vanilla Cooking Expanded 1.6 makes cheese from it
  (`VCE_JellyIntoCheese`) and already carries the *insect cheese* label override. The original mod
  predates that.
- **Vanilla Factions Expanded - Insectoids support is dropped.** Vanilla Cooking Expanded 1.6 has
  no folder for it, the `VCE_InsectCheese` it produced is gone, and the `packageId` the original
  guarded on (`oskarpotocki.vfe.insectoid`) belongs to the superseded first version of that mod.
  **RimBees** takes its place, which Vanilla Cooking Expanded gained support for after the original
  stopped.

## Soy sauce lost its quality

The one process whose numbers changed, and not because of the framework.

Daemon976 gave it `usesQuality` and a seven-step `qualityDays`, because in the 1.4 Sushi add-on
`VCE_SoySauce` carried a `CompQuality`. In 1.6 it does not: soy sauce is a plain condiment with no
quality at all. Asking the framework to set a quality on a thing with no `CompQuality` is asking
for a null reference the moment a batch finishes.

Quality is out, and the process is a flat wait instead. **Ten days** — the Sushi add-on's own 1.6
figure, 600,000 ticks — rather than the one-to-sixty-day ladder the quality steps used to span.

## Kit's Brazilian Crops is patched now, not overridden

The original mod redefined Brazilian Crops' three stove recipes under the same `defName`s, so that
loading later overwrote them and they turned out an *uncooked* stew for the pot to finish. That
worked against Brazilian Crops as it stood in 2022. Against Brazilian Crops as it stands now it
would quietly undo a rebalance:

- It rebuilt its recipes for 1.6. Ingredient counts went from 5 and 10 whole items to
  nutrition-based 0.5 and 1, the research prerequisite was dropped, and they hang off its own
  abstract parents (`KIT_CookComplexBeanStewMealBase`, `KIT_CookGourmetBeanStewMealBase`) which did
  not exist before. Carrying the old overrides forward would silently revert all of it.
- It grew two **bulk** recipes the original never knew about. Left alone, the stove would still
  turn out finished bean stew four at a time, straight past the pot this mod exists to route it
  through.

So this version patches `<products>` on all five recipes and touches nothing else. Every one of
Brazilian Crops' 1.6 decisions — ingredients, work, skill, filters, parents — is kept.

The folder is also gated on **both** `zal.braziliancrops` and `VanillaExpanded.VCookEStews`. Its
recipes hang off `VCE_StewCooking`, a research project that lives in the Stews add-on, and the
uncooked stew textures live there too. The original guarded on Brazilian Crops alone, which left an
unresolved research reference for anyone running Brazilian Crops without Stews.

## A dead class in the original's defs

`Defs/Recipes_BeanStew.xml` gave the gourmet bean stew:

```xml
<li Class="VanillaCookingExpanded.CompProperties_StackByCondiments">
```

That class exists in no version of Vanilla Cooking Expanded from 1.4 onward — it dates from the 1.3
assembly. It does not kill the def, which is why it went unnoticed: `Verse.CompProperties` is
concrete, so `DirectXmlToObject.ClassTypeOf` falls back to it, logs a line, and attaches a comp
that does nothing.

Vanilla Cooking Expanded 1.6 does that job with `<thingClass>VEF.Cooking.GourmetMeal</thingClass>`
instead, which is what the uncooked gourmet stew carries here.

## `PatchOperationFindMod` is gone

The original used it in three of its five patch files. It compares a mod's **display name**, not
its `packageId` — so it stops matching the day an author renames a workshop item, and says
nothing when it does. Every conditional in this version is a `packageId`: `IfModActive` in
`loadFolders.xml`, or `MayRequire` on the list entries.

That also settles the Sushi add-on's two 1.6 folders (`1.6Odyssey` and `1.6NotOdyssey`) for free.
Patches run against the finished document, after Sushi's own `loadFolders` has picked one, so a
single patch serves both cases and never has to know which one loaded.

## What was lost in the move, and left lost

Two behaviours the pipe-system processor has and the framework does not. Both are noted here rather
than papered over, because replacing them would be rebalancing rather than porting.

- **Soup no longer spoils when the power cuts.** PipeSystem's `noPowerDestroysProgress` is what
  made soup rot "extremely rapidly" on an unpowered electric pot, as the building's own description
  still warns. The framework's nearest equivalent, `unpoweredFactor`, slows a process instead of
  ruining it, and Daemon976's soup processes leave it at its default. Solar flares are survivable
  now.
- **The stew pot no longer swaps to its full texture.** `inProgressTexture` and `finishedTexture`
  went with the comp. The framework's `filledGraphicSuffix` appends a suffix to the building's own
  texture path and so cannot reach a differently named texture in another mod's folder. The
  framework draws the product icon over the building instead.

## Compatibility

Declared incompatible with the original (`Daemon976.PF.VFEC`), which would fight this one for the
same four buildings.

Every `defName` is Daemon976's, so a save moves between the two without losing anything — with one
exception it cannot avoid: the thirteen per-milk cheese processes are gone, because the thirteen
cheeses they made are gone from Vanilla Cooking Expanded itself.

Load **after** Vanilla Cooking Expanded and its add-ons, which the `About.xml` declares. This
matters in one specific way: Vanilla Cooking Expanded's own Alpha Animals, RimBees and Vanilla
Genetics Expanded patches add their milks to the pipe-system comp's process list. They run first,
find their target, and log nothing; this mod then replaces the comp they wrote into. Their milks
are picked back up in the cheese process's ingredient filter.

A mod that loads *after* this one and patches the pipe-system comp on these four buildings will
miss. Nothing can be done about that from here.

Content mod: removing it mid-save leaves the four buildings with no processor comp at all until
Vanilla Cooking Expanded's own is restored, which happens on the next load.

## Credit and licence

The mod, its processes and their balance are **Daemon976's**.

No licence is declared anywhere — not in the files, not in the `About.xml`, not on the Steam page,
checked for permission *and* for refusal. The mod has not been updated since the 1.4 cycle. It is
republished here under the usual convention for abandoned mods: full credit, and removal on
request. If Daemon976 would rather this version did not exist, say so and it comes down.

The `LICENSE` in this repository covers the port work — the rewritten patch layer and these
documents — not Daemon976's original content, which is not mine to relicense.

> If I do not answer within a reasonable time after being contacted, anyone may freely update this
> or any other of my mods, including publishing a continuation of it. All credit must be preserved.

See [ATTRIBUTION.md](ATTRIBUTION.md).
