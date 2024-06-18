#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
* Crafting points for buttons
* @property {cPoint} Stop Stop button in crafting panel
* @property {cPoint} Tab1 First tab in panel
*/
Class cCraftingPoints {
    Stop := cPoint(675, 750)
    Tab1 := cPoint(500, 1180)
}
