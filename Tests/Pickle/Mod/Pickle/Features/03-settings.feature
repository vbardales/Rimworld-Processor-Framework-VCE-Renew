# 8.h of AUDIT.md, no-settings case: the mod has no settings (settings_audit: not_applicable), so Mod options
# must list no entry for it. A green scenario shows no empty page exists for the mod; it does not show the
# MainButtons list (RIMMSQOL is not staged in the minimal pass, so no step can read that list).
@requires:nelim.pickletools.colonistrace
Feature: the mod adds no settings page

  Background:
    Given the save "test-colony" is loaded

  Scenario: Mod options lists no entry for this mod
    Then Nelim's Pickle Tools: the mod options page of the mod "nelim.pf.vce" does not exist
    And no errors were logged
