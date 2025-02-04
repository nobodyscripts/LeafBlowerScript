#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk

/**
 * Areas points for buttons (Points.Areas)
 * This is for areas panel stuff which unfortunately has the same name as my rect class
 * @memberof module:cPoints
 * @property {cAreasFavPoints} Favs Favourites
 * @property {cAreasLeafGPoints} LeafGalaxy Leaf Galaxy
 * @property {cAreasSacredNPoints} SacredNebula Sacred Nebula
 * @property {cAreasEnergyBPoints} EnergyBelt Energy Belt
 * @property {cAreasFireFPoints} FireFields Fire Fields
 * @property {cAreasSoulRPoints} SoulRealm Soul Realm
 * @property {cAreasQuarkAPoints} QuarkAmbit Quark Ambit
 * @property {cAreasEventsPoints} Events Events
 */
Class cAreasPoints {
    /** @type {cAreasFavPoints} Favs Favourites */
    Favs := cAreasFavPoints()
    
    /** @type {cAreasLeafGPoints} Leaf Galaxy */
    LeafGalaxy := cAreasLeafGPoints()

    /** @type {cAreasSacredNPoints} Sacred Nebula */
    SacredNebula := cAreasSacredNPoints()

    /** @type {cAreasEnergyBPoints} Energy Belt */
    EnergyBelt := cAreasEnergyBPoints()

    /** @type {cAreasFireFPoints} Fire Fields */
    FireFields := cAreasFireFPoints()

    /** @type {cAreasSoulRPoints} Soul Realm */
    SoulRealm := cAreasSoulRPoints()

    /** @type {cAreasQuarkAPoints} Quark Ambit */
    QuarkAmbit := cAreasQuarkAPoints()

    /** @type {cAreasEventsPoints} Events */
    Events := cAreasEventsPoints()
}

;@region cAreasFavPoints
/**
 * Points.Areas.Favs
 * @memberof module:cAreasPoints
 * @property {cPoint} Tab Tab for areas panel (Favourites)
 */
Class cAreasFavPoints {
    /** @type {cPoint} Tab for areas panel (Favourites) */
    Tab := cPoint(300, 1167)
}
;@endregion

;@region cAreasLeafGPoints
/**
 * Points.Areas.LeafGalaxy
 * @memberof module:cVeinPoints
 * @property {cPoint} Tab Tab for areas panel (Leaf Galaxy)
 * @property {cPoint} HomeGarden Home Garden
 * @property {cPoint} Pub Pub (scroll down 46)
 */
Class cAreasLeafGPoints {
    /** @type {cPoint} Tab for areas panel (Leaf Galaxy) */
    Tab := cPoint(535, 1164)

    /** @type {cPoint} Home Garden */
    HomeGarden := cPoint(1662, 325)

    /** @type {cPoint} Pub (scroll down 46) */
    Pub := cPoint(1662, 740)
}
;@endregion

;@region cAreasSacredNPoints
/**
 * Points.Areas.SacredNebula
 * @memberof module:cVeinPoints
 */
Class cAreasSacredNPoints {
}
;@endregion

;@region cAreasEnergyBPoints
/**
 * Points.Areas.EnergyBelt
 * @memberof module:cVeinPoints
 */
Class cAreasEnergyBPoints {
}
;@endregion

;@region cAreasFireFPoints
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Tab Tab for areas panel (Fire Fields)
 * @property {cPoint} BorbianaJones Borbiana Jones screen
 * @property {cPoint} ResetGF Reset GF
 * @property {cPoint} ResetSS Reset SS
 */
Class cAreasFireFPoints {
    ; Tab for areas panel (Fire Fields)
    Tab := cPoint(1272, 1163)
    ; Borbiana Jones screen
    BorbianaJones := cPoint(1735, 397)
    ; Reset GF
    ResetGF := cPoint(820, 500)
    ; Reset SS
    ResetSS := cPoint(1280, 500)
}
;@endregion

;@region cAreasSoulRPoints
/**
 * @memberof module:cVeinPoints
 */
Class cAreasSoulRPoints {
}
;@endregion

;@region cAreasQuarkAPoints
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Tab Tab for areas panel (Quark Ambit)
 * @property {cPoint} AstralOasis Astral Oasis
 * @property {cPoint} DimentionalTapestry Dimentional Tapestry
 * @property {cPoint} PlankScope Plank Scope
 * @property {cPoint} PlankScope2 Plank Scope second location
 * @property {cPoint} AnteLeafton Ante Leafton (scroll down 2)
 * @property {cPoint} AnteLeafton2 Ante Leafton (scroll down 2)
 */
Class cAreasQuarkAPoints {
    ; Tab for areas panel (Quark Ambit)
    Tab := cPoint(1760, 1164)
    ; Astral Oasis
    AstralOasis := cPoint(1665, 643)
    ; Dimentional Tapestry
    DimentionalTapestry := cPoint(1665, 820)
    ; Plank Scope
    PlankScope := cPoint(1665, 970)
    ; Plank Scope second location
    PlankScope2 := cPoint(1665, 1020)
    ; Ante Leafton (scroll down 2)
    AnteLeafton := cPoint(1665, 970)
    ; Ante Leafton (scroll down 2)
    AnteLeafton2 := cPoint(1665, 1020)
}
;@endregion

;@region cAreasEventsPoints
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Tab Tab for areas panel (Events)
 * @property {cPoint} CursedHalloween Button in Events for Cursed Halloween
 * @property {cPoint} NatureBoss Nature boss button location depends on events
 * active
 * @property {cPoint} NatureBoss2 Nature boss button location depends on events
 * active
 * @property {cPoint} FarmField Farm Field
 */
Class cAreasEventsPoints {
    ; Tab for areas panel (Events)
    Tab := cPoint(2030, 1164)
    ; Button in Events for Cursed Halloween
    CursedHalloween := cPoint(1674, 329)
    ; Nature boss button location depends on events active
    NatureBoss := cPoint(1682, 946)
    ; Nature boss button location depends on events active
    NatureBoss2 := cPoint(1682, 860)
    ; Farm field
    FarmField := cPoint(1682, 525)
}
;@endregion
