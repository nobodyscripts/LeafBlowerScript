#Requires AutoHotkey v2.0

#Include ..\..\Lib\cRects.ahk

/**
 * Cave pixel areas
 * @memberof module:cRects
 * @property {cRect} DiamondIcon Cave area for diamond icon in rewards next to 
 * drilling
 * @property {cRect} DrillStatus Cave area to the right of drill (On) text
 * display
 * @property {cRect} LockInd1 Cave area indicator for lock on cave 1
 * @property {cRect} LockInd2 Cave area indicator for lock on cave 2
 * @property {cRect} LockInd3 Cave area indicator for lock on cave 3
 * @property {cRect} LockInd4 Cave area indicator for lock on cave 4
 * @property {cRect} LockInd5 Cave area indicator for lock on cave 5
 */
Class cCaveRects {
    DiamondIcon := cRect(1144, 966, 1186, 999)
    DrillStatus := cRect(880, 866, 885, 890)
    LockInd1 := cRect(628, 474, 655, 501)
    LockInd2 := cRect(628, 538, 655, 563)
    LockInd3 := cRect(628, 601, 655, 627)
    LockInd4 := cRect(628, 665, 655, 691)
    LockInd5 := cRect(628, 730, 655, 756)
}