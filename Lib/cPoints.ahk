#Requires AutoHotkey v2.0

#Include cPoint.ahk
#Include Navigate.ahk

/** @type {cPoints} */
Global Points := cPoints()

/**
 * Collection of points x/y that allow for colour sampling, clicking and other
 * tasks useful for the script.
 * @module cPoints
 * @property {cPoint} ZoneSample
 * @property {cAreasPoints} Areas
 * @property {cBankPoints} Bank
 * @property {cBorbventuresPoints} Borbventures
 * @property {cBrewPoints} Brew
 * @property {cCardPoints} Card
 * @property {cClawPoints} Claw
 * @property {cCraftingPoints} Crafting
 * @property {cGemFarmPoints} GemFarm
 * @property {cHyacinthPoints} Hyacinth
 * @property {cLeaftonPoints} Leafton
 * @property {cMinePoints} Mine
 * @property {cCavePoints} Mine.Cave
 * @property {cTransmutePoints} Mine.Transmute
 * @property {cVeinPoints} Mine.Vein
 * @property {cMiscPoints} Misc
 * 
 */
Class cPoints {
    ZoneSample := cPoint(0, 0)
    Areas := cAreasPoints()
    Bank := cBankPoints()
    Borbventures := cBorbventuresPoints()
    Brew := cBrewPoints()
    Card := cCardPoints()
    Claw := cClawPoints()
    Crafting := cCraftingPoints()
    GemFarm := cGemFarmPoints()
    Hyacinth := cHyacinthPoints()
    Leafton := cLeaftonPoints()
    Mine := cMinePoints()
    Mine.Cave := cCavePoints()
    Mine.Transmute := cTransmutePoints()
    Mine.Vein := cVeinPoints()
    Misc := cMiscPoints()
}