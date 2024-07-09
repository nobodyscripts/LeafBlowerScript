#Requires AutoHotkey v2.0

#Include cRect.ahk

/** @type {cRects} */
Global Rects := cRects()

/**
 * @module cRects
 * @property {cAreasRects} Areas
 * @property {cBorbventuresRects} Borbventures
 * @property {cClawRects} Claw
 * @property {cGemFarmRects} GemFarm
 * @property {cMiscRects} Misc
 * @property {cMineRects} Mine
 * @property {cCaveRects} Mine.Cave
 */
Class cRects {
    Areas := cAreasRects()
    Borbventures := cBorbventuresRects()
    Claw := cClawRects()
    GemFarm := cGemFarmRects()
    Misc := cMiscRects()
    Mine := cMineRects()
    Mine.Cave := cCaveRects()
}