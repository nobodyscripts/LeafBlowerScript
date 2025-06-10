#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Leafton points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} Center Center of the screen for clicking the 
 * background object
 * @property {cLBRButton} Start Start button
 */
Class cLeaftonPoints {
    Center := cLBRButton(1270, 680)
    Start := cLBRButton(690, 370)
}
