---
mod: [SYR] Processor Framework - Vanilla Expanded Cooking Renew
packageId: nelim.pf.vce
repo: Rimworld-Processor-Framework-VCE-Renew
remote: https://github.com/vbardales/Rimworld-Processor-Framework-VCE-Renew.git
visibility: public
detached: yes
workflow_stage: makeSources
licence: silent
licence_at: "2026-10-28: no upstream licence anywhere (files, About, Steam page), source mod dead since 1.4; the LICENSE here covers the port only"
upstream_mod_remotes: N/A      # no upstream git repository known; not searched (no corpus search without the owner's yes)
settings_audit: unchecked
localization: unchecked
translation_en: unchecked
translation_fr: unchecked
dependencies: declared
workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3811323202
published: yes
tested_on: never
remaining:
  - "2026-10-28: unverified: never seen running in game"
  - "2026-10-28: defect: Art/Preview-source.png mean value 0.272, below the 0.30 floor (AUDIT 2.e, Measure-Palette.sh: 2 families, vivid 14.4%); the left half is empty dark floor. Source is the owner's: waiting on her decision to keep or replace it"
protocols_read_sha: 43dd90d4b7873c500347fba1be01275a48d5795b
updated: 2026-10-28
---

# [SYR] Processor Framework - Vanilla Expanded Cooking Renew: status

Current state only: the front matter above is the source of truth, run lines go to `docs/runs/`.

makeSources: 2.a, 2.b, 2.c, 2.d, 2.f done (ModIcon.png 128 px / 26 KB and Art/ModIcon.ico regenerated from the new source; no PROMPT file left; Art minimal, `Art/.render/` ignored). 2.e open: see the defect in `remaining`.

State at 2026-10-28: the repository was rebuilt from the 2026-09-12 sweep format. `Mod/About/PublishedFileId.txt` holds `3811323202`, so the Workshop item exists. The local folder had no `.git` of its own; it now tracks `origin/main` (one commit, `9e50c62`).
