#Requires AutoHotkey v2.0

#Include ..\..\Lib\cRects.ahk

/**
 * Claw pixel areas
 * @memberof module:cRects
 * @property {cRect} Items Area to check for items to pick up
 */
Class cClawRects {
    ; Area to check for items to pick up
    Items := cRect(406, 672, 2070, 970)
}