#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cAreas.ahk

/**
 * Areas points for buttons
 * This is for areas panel stuff which unfortunately has the same name as my rect class
 * @memberof module:cPoints
 * @property {Object} Favs Favourites
 * @property {cPoint} Favs.Tab Tab for areas panel (Favourites)
 * @property {Object} LeafG Leaf Galaxy
 * @property {cPoint} LeafG.Tab Tab for areas panel (Leaf Galaxy)
 * @property {cPoint} LeafG.Pub Pub (scroll down 46)
 * @property {Object} SacredN Sacred Nebula
 * @property {Object} EnergyB Energy Belt
 * @property {Object} FireF Fire Fields
 * @property {Object} SoulR Soul Realm
 * @property {Object} QuarkA Quark Ambit
 * @property {cPoint} QuarkA.Tab Tab for areas panel (Quark Ambit)
 * @property {Object} Events Events
 * @property {cPoint} Events.Tab Tab for areas panel (Events)
 * @property {cPoint} Events.CursedHalloween Button in Events for Cursed 
 * Halloween
 */
Class cAreasPoints {
    ; Favourites
    Favs := {}
    ; Tab for areas panel (Favourites)
    Favs.Tab := cPoint(300, 1180)
    ; Leaf Galaxy
    LeafG := {}
    ; Tab for areas panel (Leaf Galaxy)
    LeafG.Tab := cPoint(535, 1164)
    ; Pub (scroll down 46)
    LeafG.Pub := cPoint(1662, 740)
    ; Sacred Nebula
    SacredN := {}
    ; Energy Belt
    EnergyB := {}
    ; Fire Fields
    FireF := {}
    ; Soul Realm
    SoulR := {}
    ; Quark Ambit
    QuarkA := {}
    ; Tab for areas panel (Quark Ambit)
    QuarkA.Tab := cPoint(1760, 1164)
    ; Events
    Events := {}
    ; Tab for areas panel (Events)
    Events.Tab := cPoint(2006, 1164)
    ; Button in Events for Cursed Halloween
    Events.CursedHalloween := cPoint(1674, 329)
}

/**
 * Areas areas areas areas areas areas areas areas areas 
 * @property {cArea} GardenReset Garden reset area
 */
Class cAreasAreas {
    GardenReset := cArea(1240, 5, 1280, 40)
}