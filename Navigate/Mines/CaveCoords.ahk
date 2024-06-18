#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Cave points for buttons
 * 78d063 (Some colour that was left in old file)
 * @property {cPoint} DrillToggle Button for toggling drill on/off
 * @property {cPoint} AutoSearch Button for toggling auto search on/off
 * @property {cPoint} Select1 Button for selecting which cave to show
 * @property {cPoint} Select2 Button for selecting which cave to show
 * @property {cPoint} Select3 Button for selecting which cave to show
 * @property {cPoint} Select4 Button for selecting which cave to show
 * @property {cPoint} Select5 Button for selecting which cave to show
 */
Class cCavePoints {
    DrillToggle := cPoint(970, 940)
    AutoSearch := cPoint(768, 288)
    Select1 := cPoint(328, 490)
    Select2 := cPoint(328, 555)
    Select3 := cPoint(328, 619)
    Select4 := cPoint(328, 682)
    Select5 := cPoint(328, 747)
}