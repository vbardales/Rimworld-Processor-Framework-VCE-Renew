# T13, T14 and T15 of TEST_SCENARIOS.md, in the optional pass "cuisine" (wsl-deps.cuisine.map): Stews, Sushi and
# Kit's Brazilian Crops staged next to the framework and Vanilla Cooking Expanded. Same steps and same limits as
# 02-production.feature: the ingredient goes in through the framework's own path, the clock is moved by days,
# power, fuel and a hauling colonist are not exercised. Figures: efficiency 10 for stews, soups and bean stews,
# so one uncooked meal gives ten cooked ones.
@requires:nelim.pickletools.colonistrace
Feature: the add-on buildings and processes make their product

  Background:
    Given the save "test-colony" is loaded

  @requires:VanillaExpanded.VCookEStews
  Scenario: one uncooked stew becomes ten cooked stews in the stew pot
    When I spawn a "VCE_StewPot" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is filled with 1 of "VCE_UncookedStewSimple"
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_StewPot" at (140, 155) is 10 of "VCE_CookedStewSimple"
    And no errors were logged

  @requires:VanillaExpanded.VCookEStews
  Scenario: one uncooked soup becomes ten cooked soups in the stew pot
    When I spawn a "VCE_StewPot" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is filled with 1 of "VCE_UncookedSoupSimple"
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_StewPot" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_StewPot" at (140, 155) is 10 of "VCE_CookedSoupSimple"
    And no errors were logged

  @requires:VanillaExpanded.VCookEStews
  Scenario: one uncooked stew becomes ten cooked stews in the electric pot
    When I spawn a "VCE_ElectricPot" at (144, 155)
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is filled with 1 of "VCE_UncookedStewSimple"
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_ElectricPot" at (144, 155) is 10 of "VCE_CookedStewSimple"
    And no errors were logged

  # Soy sauce has no quality and no stated count (capacityFactor 2.5, efficiency left at its default): the
  # scenario asserts that the batch finishes, the product exists and nothing is logged (a quality process on a
  # thing without CompQuality would throw at this moment).
  @requires:VanillaExpanded.VCookESushi
  Scenario: soybeans become soy sauce in the fermenter, without a quality error
    When I spawn a "VCE_SoyFermenter" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_SoyFermenter" at (140, 155) is filled with 10 of "VCE_RawSoybean"
    And Nelim's Pickle Tools: the "VCE_SoyFermenter" at (140, 155) is advanced until its process is complete
    And Nelim's Pickle Tools: the "VCE_SoyFermenter" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the "VCE_SoySauce" product of the "VCE_SoyFermenter" at (140, 155) is labelled "soy"
    And no errors were logged

  @requires:zal.braziliancrops
  Scenario: one uncooked bean stew becomes ten bean stews in the electric pot
    When I spawn a "VCE_ElectricPot" at (144, 155)
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is filled with 1 of "KIT_UncookedStewFine"
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is advanced by 0.5 days
    And Nelim's Pickle Tools: the "VCE_ElectricPot" at (144, 155) is emptied
    Then Nelim's Pickle Tools: the product of the "VCE_ElectricPot" at (144, 155) is 10 of "KIT_BeanStewFine"
    And no errors were logged
