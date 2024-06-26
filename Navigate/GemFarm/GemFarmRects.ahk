#Requires AutoHotkey v2.0

#Include ..\..\Lib\cRects.ahk

/**
 * GemFarm pixel areas
 * @memberof module:cRects
 * @property {cRect} BearoSearch Area to check for Bearo being equipped
 * @property {cRect} AutoRefreshTimer Area for timer text if active
 * @property {cRect} TravelLeafSearch Travel search area to find leaf
 */
Class cGemFarmRects {
    ; Area to check for Bearo being equipped
    BearoSearch := cRect(675, 1070, 1494, 1138)
    ; Area for timer text if active
    AutoRefreshTimer := cRect(615, 292, 698, 326)
    ; Travel search area to find leaf
    TravelLeafSearch := cRect(1433, 278, 1472, 1072)
}