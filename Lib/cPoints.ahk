#Requires AutoHotkey v2.0

#Include cPoint.ahk
#Include ..\Navigate\Header.ahk

/** @type {cPoints} */
global Points := cPoints()

/**
 * @module cPoints
 * @property {cPoint} ZoneSample
 * @property {cAreasPanelPoints} AreasPanel
 * @property {cBankPoints} Bank
 * @property {cBorbventuresPoints} Borbventures
 * @property {cBrewPoints} Brew
 * @property {cCardPoints} Card
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
    AreasPanel := cAreasPanelPoints()
    Bank := cBankPoints()
    Borbventures := cBorbventuresPoints()
    Brew := cBrewPoints()
    Card := cCardPoints()
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