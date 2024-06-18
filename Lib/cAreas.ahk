#Requires AutoHotkey v2.0

#Include cArea.ahk

global Areas := cAreas()

/**
 * @property {cAreasPanelAreas} AreasPanel
 * @property {cBorbventuresAreas} Borbventures
 * @property {cMiscAreas} Misc
 * @property {cMineAreas} Mine
 * @property {cCaveAreas} Mine.Cave
 */
Class cAreas {
    AreasPanel := cAreasPanelAreas()
    Borbventures := cBorbventuresAreas()
    Misc := cMiscAreas()
    Mine := cMineAreas()
    Mine.Cave := cCaveAreas()
}