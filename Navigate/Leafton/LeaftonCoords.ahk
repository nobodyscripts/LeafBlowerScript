#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Leafton points for buttons
 * @property {cPoint} Center Center of the screen for clicking the 
 * background object
 * @property {cPoint} Start Start button
 */
Class cLeaftonPoints {
    Center := cPoint(1270, 680)
    Start := cPoint(690, 370)
}