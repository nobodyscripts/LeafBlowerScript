#Requires AutoHotkey v2.0

#Include ..\..\Lib\cAreas.ahk

/**
 * GemFarm pixel areas
 * @memberof module:cAreas
 * @property {cArea} GemFarm GemFarm area
 * @property {cArea} AutoRefreshTimer Area for timer text if active
 */
Class cGemFarmAreas {
    BearoSearch := cArea(675, 1070, 1494, 1138)
    AutoRefreshTimer := cArea(615, 292, 698, 326)
}