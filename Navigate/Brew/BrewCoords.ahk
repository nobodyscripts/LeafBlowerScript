#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Brew points for buttons
 * @memberof module:cPoints
 * @property {cPoint} Tab1.Nav Point for first panel tab
 * @property {cPoint} Tab1.Artifacts Artifacts 
 * @property {cPoint} Tab1.Equipment Equipment
 * @property {cPoint} Tab1.Materials Materials
 * @property {cPoint} Tab1.CardParts Card Parts
 * @property {cPoint} Tab1.CardPartsFont1 Card Parts for fontsize 1
 */
Class cBrewPoints {
    ; Obj to hold sub points
    Tab1 := {}
    ; First tab and sub points
    Tab1.Nav := cPoint(526, 1180)
    ; Artifacts
    Tab1.Artifacts := cPoint(1745, 310)
    ; Equipment
    Tab1.Equipment := cPoint(1745, 463)
    ; Materials
    Tab1.Materials := cPoint(1745, 610)
    ; Card Parts
    Tab1.CardParts := cPoint(1745, 931)
    ; Card Parts for fontsize 1
    Tab1.CardPartsFont1 := cPoint(1745, 960)
}