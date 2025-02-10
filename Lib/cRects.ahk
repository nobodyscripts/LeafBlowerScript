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
 * @property {cMLCShopRects} MLCShop Subclass for mlc shop rects
 */
Class cRects {

    /** @type {cAreasRects} Areas Rects */
    Areas := cAreasRects()
    
    /** @type {cBorbventuresRects} Borbventures Rects */
    Borbventures := cBorbventuresRects()
    
    /** @type {cClawRects} Claw Rects */
    Claw := cClawRects()
    
    /** @type {cGemFarmRects} GemFarm Rects */
    GemFarm := cGemFarmRects()
    
    /** @type {cMiscRects} Misc Rects */
    Misc := cMiscRects()
    
    /** @type {cMineRects} Mine Rects */
    Mine := cMineRects()
    
    /** @type {cCaveRects} Mine.Cave Rects */
    Mine.Cave := cCaveRects()
    
    /** @type {cMLCShopRects} */
    MLCShop := cMLCShopRects()
}