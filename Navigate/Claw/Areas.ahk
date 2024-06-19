#Requires AutoHotkey v2.0

#Include ..\..\Lib\cAreas.ahk

/**
 * Claw pixel areas
 * @memberof module:cAreas
 * @property {cArea} Items Area to check for items to pick up
 */
Class cClawAreas {
    ; Area to check for items to pick up
    Items := cArea(406, 672, 2070, 970)
}