#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk

/**
 * Areas points for buttons
 * This is for areas panel stuff which unfortunately has the same name as my rect class
 * @memberof module:cPoints
 * @property {Object} Favs Favourites
 * @property {cPoint} Favs.Tab Tab for areas panel (Favourites)
 * @property {Object} LeafG Leaf Galaxy
 * @property {cPoint} LeafG.Tab Tab for areas panel (Leaf Galaxy)
 * @property {cPoint} LeafG.HomeGarden Home Garden
 * @property {cPoint} LeafG.Pub Pub (scroll down 46)
 * @property {Object} SacredN Sacred Nebula
 * @property {Object} EnergyB Energy Belt
 * @property {Object} FireF Fire Fields
 * @property {Object} FireF.Tab Tab for areas panel (Fire Fields)
 * @property {Object} FireF.BorbianaJones Borbiana Jones screen
 * @property {Object} FireF.ResetGF Reset GF
 * @property {Object} FireF.ResetSS Reset SS
 * @property {Object} SoulR Soul Realm
 * @property {Object} QuarkA Quark Ambit
 * @property {cPoint} QuarkA.Tab Tab for areas panel (Quark Ambit)
 * @property {cPoint} QuarkA.AstralOasis Astral Oasis
 * @property {cPoint} QuarkA.DimentionalTapestry Dimentional Tapestry
 * @property {cPoint} QuarkA.PlankScope Plank Scope
 * @property {cPoint} QuarkA.PlankScope2 Plank Scope second location
 * @property {cPoint} QuarkA.AnteLeafton Ante Leafton (scroll down 2)
 * @property {cPoint} QuarkA.AnteLeafton2 Ante Leafton (scroll down 2)
 * @property {Object} Events Events
 * @property {cPoint} Events.Tab Tab for areas panel (Events)
 * @property {cPoint} Events.CursedHalloween Button in Events for Cursed 
 * Halloween
 * @property {cPoint} Events.NatureBoss Nature boss button location depends on events active
 * @property {cPoint} Events.NatureBoss2 Nature boss button location depends on events active
 * @property {cPoint} Events.FarmField Farm Field
 */
Class cRectsPoints {
    ; Favourites
    Favs := {}
    ; Tab for areas panel (Favourites)
    Favs.Tab := cPoint(300, 1180)
    ; Leaf Galaxy
    LeafG := {}
    ; Tab for areas panel (Leaf Galaxy)
    LeafG.Tab := cPoint(535, 1164)
    ; Home Garden
    LeafG.HomeGarden := cPoint(1662, 325)
    ; Pub (scroll down 46)
    LeafG.Pub := cPoint(1662, 740)
    ; Sacred Nebula
    SacredN := {}
    ; Energy Belt
    EnergyB := {}
    ; Fire Fields
    FireF := {}
    ; Tab for areas panel (Fire Fields)
    FireF.Tab := cPoint(1272, 1163)
    ; Borbiana Jones screen
    FireF.BorbianaJones := cPoint(1735, 397)
    ; Reset GF
    FireF.ResetGF := cPoint(820, 500)
    ; Reset SS
    FireF.ResetSS := cPoint(1280, 500)
    ; Soul Realm
    SoulR := {}
    ; Quark Ambit
    QuarkA := {}
    ; Tab for areas panel (Quark Ambit)
    QuarkA.Tab := cPoint(1760, 1164)
    ; Astral Oasis
    QuarkA.AstralOasis := cPoint(1665, 643)
    ; Dimentional Tapestry
    QuarkA.DimentionalTapestry := cPoint(1665, 820)
    ; Plank Scope
    QuarkA.PlankScope := cPoint(1665, 970)
    ; Plank Scope second location
    QuarkA.PlankScope2 := cPoint(1665, 1020)
    ; Ante Leafton (scroll down 2)
    QuarkA.AnteLeafton := cPoint(1665, 970)
    ; Ante Leafton (scroll down 2)
    QuarkA.AnteLeafton2 := cPoint(1665, 1020)
    ; Events
    Events := {}
    ; Tab for areas panel (Events)
    Events.Tab := cPoint(2006, 1164)
    ; Button in Events for Cursed Halloween
    Events.CursedHalloween := cPoint(1674, 329)
    ; Nature boss button location depends on events active
    Events.NatureBoss := cPoint(1682, 946)
    ; Nature boss button location depends on events active
    Events.NatureBoss2 := cPoint(1682, 860)
    ; Farm field
    Events.FarmField := cPoint(1682, 525)
}