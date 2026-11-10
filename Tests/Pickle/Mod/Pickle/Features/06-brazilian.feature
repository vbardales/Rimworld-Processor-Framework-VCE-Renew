# T15 of TEST_SCENARIOS.md, in the optional pass "brazilian" (wsl-deps.brazilian.map): Kit's Brazilian Crops staged next to
# the Stews add-on and Vanilla Cooking Expanded. Kit's Brazilian Crops also needs Vanilla Brewing Expanded
# (VanillaExpanded.VBrewE, 2186560858): without it KIT_Guarana has a null thingClass and the save
# does not load (ReadingPolicyDatabase NRE, ticket 5b84). Same steps and limits as 04-cuisine.feature.
@requires:nelim.pickletools.colonistrace
Feature: the Brazilian Crops bean stews go through the pot

  Background:
    Given the save "test-colony" is loaded

  @requires:zal.braziliancrops
  Scenario: one uncooked bean stew becomes ten bean stews in the electric pot
    When I spawn a "VCE_ElectricPot" at (144, 155)
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is filled with 1 of "KIT_UncookedStewFine"
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_ElectricPot" at (144, 155) is 10 of "KIT_BeanStewFine"
    And no errors were logged
