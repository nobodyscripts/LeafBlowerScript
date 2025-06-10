#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Crafting points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} Stop Stop button in crafting panel
 * @property {cLBRButton} Tab1 First tab in panel
 */
Class cCraftingPoints {
    Stop := cLBRButton(675, 750)
    Tab1 := cLBRButton(500, 1180)
}
