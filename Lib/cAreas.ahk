#Requires AutoHotkey v2.0

#Include cArea.ahk

global Areas := cAreas()

/**
 * @module cAreas
 * @property {cAreasPanelAreas} AreasPanel
 * @property {cBorbventuresAreas} Borbventures
 * @property {cGemFarmAreas} GemFarm
 * @property {cMiscAreas} Misc
 * @property {cMineAreas} Mine
 * @property {cCaveAreas} Mine.Cave
 */
Class cAreas {
    AreasPanel := cAreasPanelAreas()
    Borbventures := cBorbventuresAreas()
    GemFarm := cGemFarmAreas()
    Misc := cMiscAreas()
    Mine := cMineAreas()
    Mine.Cave := cCaveAreas()
}