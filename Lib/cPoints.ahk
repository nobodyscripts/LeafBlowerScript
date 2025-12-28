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
 * @property {cHarborPoints} Harbor
 * @property {cHyacinthPoints} Hyacinth
 * @property {cLeaftonPoints} Leafton
 * @property {cMinePoints} Mine
 * @property {cMiscPoints} Misc
 * 
 */
Class cPoints {
    /** Zone sample point
     * @type {cLBRButton} */
    ZoneSample := cLBRButton(0, 0)

    /** Areas points
     * @type {cAreasPoints} */
    Areas := cAreasPoints()

    /** Bank points
     * @type {cBankPoints} */
    Bank := cBankPoints()

    /** Borbventures points
     * @type {cBorbventuresPoints} */
    Borbventures := cBorbventuresPoints()

    /** Brew points
     * @type {cBrewPoints} */
    Brew := cBrewPoints()

    /** Card points
     * @type {cCardPoints} */
    Card := cCardPoints()

    /** Claw points
     * @type {cClawPoints} */
    Claw := cClawPoints()

    /** Crafting points
     * @type {cCraftingPoints} */
    Crafting := cCraftingPoints()

    /** Dice points
     * @type {cDicePoints} */
    Dice := cDicePoints()

    /** GemFarm points
     * @type {cGemFarmPoints} */
    GemFarm := cGemFarmPoints()

    /** Harbor points
     *  @type {cHarborPoints} */
    Harbor := cHarborPoints()

    /** Hyacinth points
     * @type {cHyacinthPoints} */
    Hyacinth := cHyacinthPoints()

    /** Leafton points
     * @type {cLeaftonPoints} */
    Leafton := cLeaftonPoints()

    /** Mine points
     * @type {cMinePoints} */
    Mine := cMinePoints()

    /** Misc points
     * @type {cMiscPoints} */
    Misc := cMiscPoints()
}
