#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Claw points for buttons
 * @memberof module:cPoints
 * @property {cPoint} CloseArea Close the area screen
 * @property {cPoint} OpenClaw Open claw machine
 */
Class cClawPoints {
    ; Close the area screen
    CloseArea := cPoint(100, 519)
    ; Open claw machine
    OpenClaw := cPoint(552, 519)
}