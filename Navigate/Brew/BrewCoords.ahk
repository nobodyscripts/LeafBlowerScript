#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Brew points for buttons
 * @memberof module:cPoints
 * @property {Object} Tab1 Container for sub properties
 */
Class cBrewPoints {
    ; Obj to hold sub points
    Tab1 := cBrewTab1Points()

}

/**
 * Brew points for buttons
 * @memberof module:cBrewPoints
 * @property {cPoint} Nav Point for first panel tab
 * @property {cPoint} Artifacts Artifacts 
 * @property {cPoint} Equipment Equipment
 * @property {cPoint} Materials Materials
 * @property {cPoint} CardParts Card Parts
 * @property {cPoint} CardPartsFont1 Card Parts for fontsize 1
 */
Class cBrewTab1Points{
    ; First tab and sub points
    Nav := cPoint(526, 1180)
    ; Artifacts
    Artifacts := cPoint(1745, 310)
    ; Equipment
    Equipment := cPoint(1745, 463)
    ; Materials
    Materials := cPoint(1745, 610)
    ; Card Parts
    CardParts := cPoint(1745, 931)
    ; Card Parts for fontsize 1
    CardPartsFont1 := cPoint(1745, 960)
}