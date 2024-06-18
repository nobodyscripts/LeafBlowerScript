#Requires AutoHotkey v2.0

#Include ..\..\Lib\cAreas.ahk

/**
 * Cave pixel areas
 * @memberof module:cAreas
 * @property {cArea} DiamondIcon Cave area for diamond icon in rewards next to 
 * drilling
 * @property {cArea} DrillStatus Cave area to the right of drill (On) text
 * display
 * @property {cArea} LockInd1 Cave area indicator for lock on cave 1
 * @property {cArea} LockInd2 Cave area indicator for lock on cave 2
 * @property {cArea} LockInd3 Cave area indicator for lock on cave 3
 * @property {cArea} LockInd4 Cave area indicator for lock on cave 4
 * @property {cArea} LockInd5 Cave area indicator for lock on cave 5
 */
Class cCaveAreas {
    DiamondIcon := cArea(1144, 966, 1186, 999)
    DrillStatus := cArea(880, 866, 885, 890)
    LockInd1 := cArea(628, 474, 655, 501)
    LockInd2 := cArea(628, 538, 655, 563)
    LockInd3 := cArea(628, 601, 655, 627)
    LockInd4 := cArea(628, 665, 655, 691)
    LockInd5 := cArea(628, 730, 655, 756)
}