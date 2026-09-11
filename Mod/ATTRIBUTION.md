# [SYR] Processor Framework - Vanilla Expanded Cooking Renew — attribution

A 1.6 revival of **[SYR] Processor Framework - Vanilla Expanded Cooking**, by **Daemon976**
([2887181698](https://steamcommunity.com/sharedfiles/filedetails/?id=2887181698)).

## Status: public

The source mod is **dead** — it declares 1.3 and 1.4 and nothing further — and **no licence is
declared anywhere**. Checked in all four places: the mod's files (there is no `LICENSE`, no
`COPYING`), its `About.xml`, the linked repository (there is none), and the description on its
Steam page. Checked for a **refusal** as well as for a permission — no "prohibit", no
"redistribution", no "do not". The page is silent, and silence is not refusal.

Republished with credit by name and a removal clause, per the convention for abandoned mods.

## What is Daemon976's

- The idea: running Vanilla Cooking Expanded's processors on [SYR] Processor Framework.
- Every `ProcessDef` and its numbers — `capacityFactor`, `efficiency`, `processDays`,
  `usesQuality`, `qualityDays`.
- Every `defName`, kept unchanged.
- The cross-listing that lets the electric pot cook stews and the stew pot cook soups.
- The Kit's Brazilian Crops bridge: the idea of routing its stove recipes through an uncooked stew
  and finishing them in the pot.

## What was rewritten

**All five patch files, from scratch**, and the file that declared the uncooked bean stews. The
reason is in [README.md](README.md#what-actually-broke) at length; in one line: the Vanilla
Expanded Framework removed `ItemProcessor` in the 1.6 cycle, Vanilla Cooking Expanded moved its
four buildings onto `PipeSystem` instead, and every xpath in the original mod aims at markup that
is no longer in the file.

Changed with it, and each for its own reason rather than for tidiness:

| Change | Why |
|---|---|
| Thirteen cheese processes became one, with thirteen ingredients | Vanilla Cooking Expanded 1.6 merged thirteen cheese `ThingDef`s into one labelled by ingredient. The thirteen products no longer exist. |
| Insect jelly added as a cheese ingredient; RimBees added | Parity with what Vanilla Cooking Expanded 1.6 itself makes. |
| Vanilla Factions Expanded - Insectoids support dropped | Vanilla Cooking Expanded 1.6 dropped it; the guarded `packageId` belongs to the superseded first version of that mod. |
| Soy sauce lost `usesQuality`, gained `processDays` 10 | `VCE_SoySauce` lost its `CompQuality` between 1.4 and 1.6. Ten days is the Sushi add-on's own 1.6 figure. |
| Kit's Brazilian Crops patched rather than overridden | Brazilian Crops rebuilt its recipes for 1.6 and grew two bulk variants. Overriding by `defName` would revert the rebalance and leave the bulk recipes bypassing the pot. |
| `VanillaCookingExpanded.CompProperties_StackByCondiments` → `<thingClass>VEF.Cooking.GourmetMeal</thingClass>` | The class dates from the 1.3 assembly and exists in no version since. It degraded quietly rather than erroring, so it survived two ports unnoticed. |
| `PatchOperationFindMod` → `loadFolders.xml` + `MayRequire`, all on `packageId` | `PatchOperationFindMod` compares display names, which change without warning and fail silently. |
| The Brazilian Crops folder now requires the Stews add-on too | Its recipes hang off `VCE_StewCooking`, which lives in Stews, and its textures do too. The original guarded on Brazilian Crops alone. |

## Third-party artwork

**None is redistributed.** This mod ships no textures. The uncooked bean stews use the Stews
add-on's own texture paths, resolved at runtime from that mod's folder — nothing is copied here.

The original mod's `About/preview.png` is **not** carried over. It is a set of in-game screenshots
showing the framework's tab listing the thirteen separate cheeses, and a *Soda* processor that was
never part of this mod. It would misrepresent what the mod does on 1.6.

## Idioms taken from other mods

- **[SYR] Processor Framework** itself, `1.6/Mods/VGP/Patches/Patches_VGP.xml` — the canonical way
  to swap another mod's processor comp for `ProcessorFramework.CompProperties_Processor`, and the
  `loadFolders.xml` shape with a `Mods/<name>` folder per `IfModActive`.
- **Vanilla Cooking Expanded 1.6** — the `<thingClass>VEF.Cooking.GourmetMeal</thingClass>` idiom
  on `VCE_UncookedSoupGourmet`, copied onto the uncooked gourmet bean stew.

Studied, not copied.

## Licence

The `LICENSE` in this repository covers the port work — the rewritten patch layer, the
`loadFolders.xml`, the uncooked bean stew defs and these documents. It does not and cannot cover
Daemon976's original content, which is republished under the abandoned-mod convention above and is
not mine to relicense.

> If I do not answer within a reasonable time after being contacted, anyone may freely update this
> or any other of my mods, including publishing a continuation of it. All credit must be preserved.
