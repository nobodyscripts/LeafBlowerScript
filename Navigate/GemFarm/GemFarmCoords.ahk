#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * GemFarm points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} Icon1 Sample point on icon for what type of trade in slot 
 * 1
 * @property {cLBRButton} Start Check for start button slot 1
 * @property {cLBRButton} FirstTradeCancel Cancel first trade point
 * @property {cLBRButton} FirstTradeCollect Collect first trade point
 * @property {cLBRButton} Detailed Check for detailed mode
 * @property {cLBRButton} AutoRefreshToggle Button for auto refresh
 * @property {cLBRButton} DetailedToggle Button for detailed mode
 */
Class cGemFarmPoints {
    ; Sample point on icon for what type of trade in slot 1
    Icon1 := cLBRButton(1252, 397)
    ; Check for start button existing
    Start := cLBRButton(2079, 384)
    ; Check for second start button existing
    Start2 := cLBRButton(2079, 460)
    ; Cancel first trade point
    FirstTradeCancel := cLBRButton(1920, 400)
    ; Collect first trade point
    FirstTradeCollect := cLBRButton(1990, 400)
    ; Check for detailed mode (tip of second blue arrow)
    Detailed := cLBRButton(1186, 456)
    ; Button for auto refresh
    AutoRefreshToggle := cLBRButton(1000, 1100)
    ; Button for detailed mode
    DetailedToggle := cLBRButton(1357, 1100)
}
