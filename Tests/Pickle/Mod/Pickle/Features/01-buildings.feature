# T5 and T17 of TEST_SCENARIOS.md, in the minimal pass: the framework, Vanilla Cooking Expanded and this
# mod, no add-on.
#
# What a green scenario shows and what it does not. The building is spawned and selected, the game ticks,
# and nothing is logged. That catches the failure this mod was written to avoid: a building whose inspector
# tab reaches for a processor comp that is gone, which throws the moment the building is selected. It does
# NOT show that the building processes anything: no ingredient is put in and no product is read (T11 to T16
# wait for a step that does that).
#
# Only the cheese press and the electric pot exist in the minimal pass: the stew pot and the soy fermenter
# live in the Stews and Sushi add-ons.
@requires:nelim.pickletools.inspecttabs
Feature: the converted buildings load, spawn and can be selected

  Background:
    Given the save "test-colony" is loaded

  Scenario: the cheese press can be selected without an error
    When I spawn a "VCE_CheesePress" at (140, 155)
    And Nelim's Pickle Tools: I select the thing of def "VCE_CheesePress" at (140, 155)
    And I wait 120 ticks
    Then no errors were logged

  Scenario: the electric pot can be selected without an error
    When I spawn a "VCE_ElectricPot" at (144, 155)
    And Nelim's Pickle Tools: I select the thing of def "VCE_ElectricPot" at (144, 155)
    And I wait 120 ticks
    Then no errors were logged
