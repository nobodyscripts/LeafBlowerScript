#Requires AutoHotkey v2.0

#Include cArea.ahk

global Areas := cAreas()

/**
 * @module cAreas
 * @property {cAreasAreas} Areas
 * @property {cBorbventuresAreas} Borbventures
 * @property {cClawAreas} Claw
 * @property {cGemFarmAreas} GemFarm
 * @property {cMiscAreas} Misc
 * @property {cMineAreas} Mine
 * @property {cCaveAreas} Mine.Cave
 */
Class cAreas {
    Areas := cAreasAreas()
    Borbventures := cBorbventuresAreas()
    Claw := cClawAreas()
    GemFarm := cGemFarmAreas()
    Misc := cMiscAreas()
    Mine := cMineAreas()
    Mine.Cave := cCaveAreas()
}