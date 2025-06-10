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
 * @property {cLBRButton} Nav Point for first panel tab
 * @property {cLBRButton} Artifacts Artifacts 
 * @property {cLBRButton} Equipment Equipment
 * @property {cLBRButton} Materials Materials
 * @property {cLBRButton} Scrolls Scrolls
 * @property {cLBRButton} CardParts Card Parts
 * @property {cLBRButton} CardPartsFont1 Card Parts for fontsize 1
 */
Class cBrewTab1Points {
    ; First tab and sub points
    Nav := cLBRButton(526, 1180)
    ; Artifacts
    Artifacts := cLBRButton(1745, 310)
    ; Equipment
    Equipment := cLBRButton(1745, 463)
    ; Materials
    Materials := cLBRButton(1745, 610)
    ; Scrolls
    Scrolls := cLBRButton(1745, 780)
    ; Card Parts
    CardParts := cLBRButton(1745, 931)
    ; Card Parts for fontsize 1
    CardPartsFont1 := cLBRButton(1745, 960)
}
