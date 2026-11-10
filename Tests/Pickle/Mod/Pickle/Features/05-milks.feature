# T16 of TEST_SCENARIOS.md, in the optional pass "laits" (wsl-deps.laits.map): the milks of Alpha Animals, RimBees
# and Vanilla Genetics Expanded are in the cheese press filter behind MayRequire. Filling the press goes through
# the framework's add-ingredient path, which takes the first process whose filter allows the ingredient: a milk
# the filter does not list is refused and the step fails. One cheese is then made, to show the product exists.
@requires:nelim.pickletools.colonistrace
Feature: the cheese press accepts the milks of the animal add-ons

  Background:
    Given the save "test-colony" is loaded

  @requires:sarg.alphaanimals
  Scenario: the press takes gow milk from Alpha Animals
    When I spawn a "VCE_CheesePress" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is filled with 10 of "AA_GowMilk"
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is advanced by 6 days
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the "VCE_Cheese" product of the "VCE_CheesePress" at (140, 155) is labelled "cheese"
    And no errors were logged

  @requires:sarg.rimbees
  Scenario: the press takes bee milk from RimBees
    When I spawn a "VCE_CheesePress" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is filled with 10 of "RB_BeeMilk"
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is advanced by 6 days
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the "VCE_Cheese" product of the "VCE_CheesePress" at (140, 155) is labelled "cheese"
    And no errors were logged

  @requires:VanillaExpanded.VGeneticsE
  Scenario: the press takes rat milk from Vanilla Genetics Expanded
    When I spawn a "VCE_CheesePress" at (140, 155)
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is filled with 10 of "GR_RatMilk"
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is advanced by 6 days
    And Nelim's Pickle Tools: the "VCE_CheesePress" at (140, 155) is emptied
    Then Nelim's Pickle Tools: the "VCE_Cheese" product of the "VCE_CheesePress" at (140, 155) is labelled "cheese"
    And no errors were logged
