#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Borbventures points for buttons
 * @memberof module:cPoints
 * @property {cPoint} BVTab First tab (Borbventures)
 * @property {cPoint} BorbsTab Second tab (Borbs)
 * @property {cPoint} AutoStartFont0 Point for checking autostart status
 * with font size 0
 * @property {cPoint} AutoStartFont1 Point for checking autostart status
 * with font size 1
 * @property {cPoint} Detailed Detailed mode button for checks
 * @property {cPoint} ScaleMin Scale minimum button for checks
 */
Class cBorbventuresPoints {
    ; First tab (Borbventures)
    BVTab := cPoint(400, 1167)
    ; Second tab (Borbs)
    BorbsTab := cPoint(630, 1167)
    ; Point for checking autostart status with font size 0
    AutoStartFont0 := cPoint(586, 1097)
    ; Point for checking autostart status with font size 1
    AutoStartFont1 := cPoint(597, 1097)
    ; Detailed mode button for checks
    Detailed := cPoint(1100, 314)
    ; Scale minimum button for checks
    ScaleMin := cPoint(1574, 314)
}