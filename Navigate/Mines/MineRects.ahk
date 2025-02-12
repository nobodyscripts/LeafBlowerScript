#Requires AutoHotkey v2.0

#Include ..\..\Lib\cRects.ahk

/**
 * Mine pixel areas
 * @memberof module:cRects
 * @property {cRect} PanelTabs Panel main tabs area (for testing ocr)
 */
Class cMineRects {
    /** @type {cRect} */
    PanelTabs := cRect(284, 1158, 2238, 1202)
}