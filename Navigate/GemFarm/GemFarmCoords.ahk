#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * GemFarm points for buttons
 * @memberof module:cPoints
 * @property {cPoint} Icon1 Sample point on icon for what type of trade in slot 
 * 1
 * @property {cPoint} Start Check for start button slot 1
 * @property {cPoint} FirstTradeCancel Cancel first trade point
 * @property {cPoint} FirstTradeCollect Collect first trade point
 * @property {cPoint} Detailed Check for detailed mode
 * @property {cPoint} AutoRefreshToggle Button for auto refresh
 * @property {cPoint} DetailedToggle Button for detailed mode
 */
Class cGemFarmPoints {
    ; Sample point on icon for what type of trade in slot 1
    Icon1 := cPoint(1252, 397)
    ; Check for start button existing
    Start := cPoint(2079, 384)
    ; Check for second start button existing
    Start2 := cPoint(2079, 460)
    ; Cancel first trade point
    FirstTradeCancel := cPoint(1920, 400)
    ; Collect first trade point
    FirstTradeCollect := cPoint(1990, 400)
    ; Check for detailed mode (tip of second blue arrow)
    Detailed := cPoint(1186, 456)
    ; Button for auto refresh
    AutoRefreshToggle := cPoint(1000, 1100)
    ; Button for detailed mode
    DetailedToggle := cPoint(1357, 1100)
}