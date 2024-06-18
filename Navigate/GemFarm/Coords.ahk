#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * GemFarm points for buttons
 * @memberof module:cPoints
 * @property {cPoint} Icon1 Sample point on icon for what type of trade in slot 
 * 1
 * @property {cPoint} StartCheck1 Check for start button existing
 * @property {cPoint} StartCheck2 Check for start button active
 * @property {cPoint} FirstTradeCancel Cancel first trade point
 * @property {cPoint} FirstTradeCollect Collect first trade point
 * @property {cPoint} SuitcaseCheck1 Check for buttons moving up when suitcase 
 * used
 * @property {cPoint} SuitcaseCheck2 Check for buttons moving up when suitcase 
 * used
 * @property {cPoint} Detailed Check for detailed mode
 * @property {cPoint} AutoRefreshToggle Button for auto refresh
 * @property {cPoint} DetailedToggle Button for detailed mode
 */
Class cGemFarmPoints {
    ; Sample point on icon for what type of trade in slot 1
    Icon1 := cPoint(1252, 397)
    ; Check for start button existing
    StartCheck1 := cPoint(1040, 227)
    ; Check for start button active
    StartCheck2 := cPoint(1040, 222)
    ; Cancel first trade point
    FirstTradeCancel := cPoint(1920, 400)
    ; Collect first trade point
    FirstTradeCollect := cPoint(1990, 400)
    ; Check for buttons moving up when suitcase used
    SuitcaseCheck1 := cPoint(960, 195)
    ; Check for buttons moving up when suitcase used
    SuitcaseCheck2 := cPoint(997, 195)
    ; Check for detailed mode
    Detailed := cPoint(1186, 456)
    ; Button for auto refresh
    AutoRefreshToggle := cPoint(1000, 1100)
    ; Button for detailed mode
    DetailedToggle := cPoint(1357, 1100)
}