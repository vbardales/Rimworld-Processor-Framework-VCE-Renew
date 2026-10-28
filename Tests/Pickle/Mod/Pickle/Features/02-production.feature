# T11 and T12 of TEST_SCENARIOS.md, in the minimal pass: the framework, Vanilla Cooking Expanded and this mod.
#
# The steps are PickleTools' (ColonistRace/Source/ProcessorSteps.cs, written 2026-10-28 on this mod's request).
# They reach the framework's own comp by reflection: an ingredient goes in as a hauler would put it, the
# process clock is moved forward by days instead of ticks, and the building is emptied the way the framework
# empties it. What a green scenario shows: the converted building accepts the ingredient, finishes the process
# and hands out the product the Def promises. What it does not show: power, fuel, temperature and the speed
# factor, which these steps leave out on purpose, and a colonist hauling or emptying the building.
#
# No colonist is needed. Cells are the same free cells as 01-buildings.feature (test-colony).
@requires:nelim.pickletools.colonistrace
Feature: the converted buildings make their product

  Background:
    Given the save "test-colony" is loaded

  # Daemon976's soup process: efficiency 10, processDays 0.5. One uncooked soup in, ten cooked soups out.
  Scenario: one uncooked soup becomes ten cooked soups in the electric pot
    When I spawn a "VCE_ElectricPot" at (144, 155)
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is filled with 1 of "VCE_UncookedSoupSimple"
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_ElectricPot" at (144, 155) is 10 of "VCE_CookedSoupSimple"
    And no errors were logged

  # The cheese process uses quality (qualityDays 1, 3, 6, 12, 24, 48, 60): six days is the third step, Normal.
  # The count is not asserted: capacityFactor 2.5 is the framework's business, the Def does not state a count.
  Scenario: milk becomes a cheese of the quality its days give
    When I spawn a "VCE_CheesePress" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is filled with 10 of "Milk"
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is advanced by 6 days
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the "VCE_Cheese" product of the "VCE_CheesePress" at (140, 155) has quality "Normal"
    And Nelim's Pickle Tools: the "VCE_Cheese" product of the "VCE_CheesePress" at (140, 155) is labelled "cheese"
    And no errors were logged
