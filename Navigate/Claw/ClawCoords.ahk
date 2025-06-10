#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Claw points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} CloseArea Close the area screen
 * @property {cLBRButton} OpenClaw Open claw machine
 */
Class cClawPoints {
    ; Close the area screen
    CloseArea := cLBRButton(100, 519)
    ; Open claw machine
    OpenClaw := cLBRButton(552, 519)
}
