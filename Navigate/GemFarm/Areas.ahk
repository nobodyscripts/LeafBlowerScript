#Requires AutoHotkey v2.0

#Include ..\..\Lib\cAreas.ahk

/**
 * GemFarm pixel areas
 * @memberof module:cAreas
 * @property {cArea} BearoSearch Area to check for Bearo being equipped
 * @property {cArea} AutoRefreshTimer Area for timer text if active
 */
Class cGemFarmAreas {
    ; Area to check for Bearo being equipped
    BearoSearch := cArea(675, 1070, 1494, 1138)
    ; Area for timer text if active
    AutoRefreshTimer := cArea(615, 292, 698, 326)
}