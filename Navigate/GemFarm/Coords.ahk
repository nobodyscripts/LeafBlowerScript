#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * GemFarm points for buttons
 * @memberof module:cPoints
 * @property {cPoint} Icon1 Sample point on icon for what type of trade in slot 
 * 1
 * @property {cpoint} StartCheck1 Check for start button existing
 * @property {cpoint} StartCheck2 Check for start button active
 * @property {cpoint} SuitcaseCheck1 Check for buttons moving up when suitcase 
 * used
 * @property {cpoint} SuitcaseCheck2 Check for buttons moving up when suitcase 
 * used
 * @property {cpoint} Detailed Check for detailed mode
 * @property {cpoint} AutoRefreshToggle Button for auto refresh
 * @property {cpoint} DetailedToggle Button for detailed mode
 */
Class cGemFarmPoints {
    Icon1 := cPoint(1252, 397)
    StartCheck1 := cPoint(1040, 227)
    StartCheck2 := cPoint(1040, 222)
    SuitcaseCheck1 := cPoint(960, 195)
    SuitcaseCheck2 := cPoint(997, 195)
    Detailed := cPoint(1186, 456)
    AutoRefreshToggle := cPoint(1000, 1100)
    DetailedToggle := cPoint(1357, 1100)
}