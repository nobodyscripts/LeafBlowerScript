#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cPoint.ahk
#Include cLBRButton.ahk
#Include Navigate.ahk

/** @type {cPoints} */
Global Points := cPoints()

/**
 * Collection of points x/y that allow for colour sampling, clicking and other
 * tasks useful for the script.
 * @module cPoints
 * @property {cLBRButton} ZoneSample
 * @property {cAreasPoints} Areas
 * @property {cBankPoints} Bank
 * @property {cBorbventuresPoints} Borbventures
 * @property {cBrewPoints} Brew
 * @property {cCardPoints} Card
 * @property {cClawPoints} Claw
 * @property {cCraftingPoints} Crafting
 * @property {cCardPoints} Dice
 * @property {cGemFarmPoints} GemFarm
 * @property {cHyacinthPoints} Hyacinth
 * @property {cLeaftonPoints} Leafton
 * @property {cMinePoints} Mine
 * @property {cMiscPoints} Misc
 * 
 */
Class cPoints {
    /** @type {cLBRButton} Zone sample point */
    ZoneSample := cLBRButton(0, 0)

    /** @type {cAreasPoints} Areas points */
    Areas := cAreasPoints()

    /** @type {cBankPoints} Bank points */
    Bank := cBankPoints()

    /** @type {cBorbventuresPoints} Borbventures points */
    Borbventures := cBorbventuresPoints()

    /** @type {cBrewPoints} Brew points */
    Brew := cBrewPoints()

    /** @type {cCardPoints} Card points */
    Card := cCardPoints()

    /** @type {cClawPoints} Claw points */
    Claw := cClawPoints()

    /** @type {cCraftingPoints} Crafting points */
    Crafting := cCraftingPoints()

    /** @type {cDicePoints} Dice points */
    Dice := cDicePoints()

    /** @type {cGemFarmPoints} GemFarm points */
    GemFarm := cGemFarmPoints()

    /** @type {cHyacinthPoints} Hyacinth points */
    Hyacinth := cHyacinthPoints()

    /** @type {cLeaftonPoints} Leafton points */
    Leafton := cLeaftonPoints()

    /** @type {cMinePoints} Mine points */
    Mine := cMinePoints()

    /** @type {cMiscPoints} Misc points */
    Misc := cMiscPoints()
}
