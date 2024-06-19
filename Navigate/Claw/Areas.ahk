#Requires AutoHotkey v2.0

#Include ..\..\Lib\cAreas.ahk

/**
 * Claw pixel areas
 * @memberof module:cAreas
 * @property {cArea} BearoSearch Area to check for Bearo being equipped
 */
Class cClawAreas {
    ; Area to check for Bearo being equipped
    BearoSearch := cArea(675, 1070, 1494, 1138)
}