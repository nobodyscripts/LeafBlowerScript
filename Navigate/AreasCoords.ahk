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

    /** @type {cAreasUmbralClusterPoints} Umbral Cluster */
    UmbralCluster := cAreasUmbralClusterPoints()

    /** @type {cAreasEventsPoints} Events */
    Events := cAreasEventsPoints()
}

;@region cAreasFavPoints
/**
 * Points.Areas.Favs
 * @memberof module:cAreasPoints
 * @property {cLBRButton} Tab Tab for areas panel (Favourites)
 */
Class cAreasFavPoints {
    /** @type {cLBRButton} Tab for areas panel (Favourites) */
    Tab := cLBRButton(300, 1167)
}
;@endregion

;@region cAreasLeafGPoints
/**
 * Points.Areas.LeafGalaxy
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Tab Tab for areas panel (Leaf Galaxy)
 * @property {cLBRButton} HomeGarden Home Garden
 * @property {cLBRButton} Pub Pub (scroll down 46)
 */
Class cAreasLeafGPoints {
    /** @type {cLBRButton} Tab for areas panel (Leaf Galaxy) */
    Tab := cLBRButton(506, 1162)

    /** @type {cLBRButton} Home Garden */
    HomeGarden := cLBRButton(1662, 325)

    /** @type {cLBRButton} Pub (scroll down 46) */
    Pub := cLBRButton(1662, 740)
}
;@endregion

;@region cAreasSacredNPoints
/**
 * Points.Areas.SacredNebula
 * @memberof module:cVeinPoints
 */
Class cAreasSacredNPoints {
    /** @type {cLBRButton} Tab for areas panel */
    Tab := cLBRButton(919, 1182)
}
;@endregion

;@region cAreasEnergyBPoints
/**
 * Points.Areas.EnergyBelt
 * @memberof module:cVeinPoints
 */
Class cAreasEnergyBPoints {
    /** @type {cLBRButton} Tab for areas panel */
    Tab := cLBRButton(1137, 1180)
}
;@endregion

;@region cAreasFireFPoints
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Tab Tab for areas panel (Fire Fields)
 * @property {cLBRButton} BorbianaJones Borbiana Jones screen
 * @property {cLBRButton} ResetGF Reset GF
 * @property {cLBRButton} ResetSS Reset SS
 */
Class cAreasFireFPoints {
    /** @type {cLBRButton} Tab for areas panel (Fire Fields) */
    Tab := cLBRButton(1356, 1182)
    /** @type {cLBRButton} Borbiana Jones screen */
    BorbianaJones := cLBRButton(1735, 397)
    /** @type {cLBRButton} Reset GF */
    ResetGF := cLBRButton(820, 500)
    /** @type {cLBRButton} Reset SS */
    ResetSS := cLBRButton(1280, 500)
}
;@endregion

;@region cAreasSoulRPoints
/**
 * @memberof module:cVeinPoints
 */
Class cAreasSoulRPoints {
    /** @type {cLBRButton} Tab for areas panel */
    Tab := cLBRButton(1576, 1180)
}
;@endregion

;@region cAreasQuarkAPoints
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Tab Tab for areas panel (Quark Ambit)
 * @property {cLBRButton} AstralOasis Astral Oasis
 * @property {cLBRButton} DimentionalTapestry Dimentional Tapestry
 * @property {cLBRButton} PlankScope Plank Scope
 * @property {cLBRButton} PlankScope2 Plank Scope second location
 * @property {cLBRButton} AnteLeafton Ante Leafton (scroll down 2)
 * @property {cLBRButton} AnteLeafton2 Ante Leafton (scroll down 2)
 */
Class cAreasQuarkAPoints {
    /** @type {cLBRButton} Tab for areas panel (Quark Ambit) */
    Tab := cLBRButton(1792, 1179)
    /** @type {cLBRButton} Astral Oasis */
    AstralOasis := cLBRButton(1665, 643)
    /** @type {cLBRButton} Dimentional Tapestry */
    DimentionalTapestry := cLBRButton(1665, 820)
    /** @type {cLBRButton} Plank Scope */
    PlankScope := cLBRButton(1665, 970)
    /** @type {cLBRButton} Plank Scope second location */
    PlankScope2 := cLBRButton(1665, 1020)
    /** @type {cLBRButton} Ante Leafton (scroll down 2) */
    AnteLeafton := cLBRButton(1665, 970)
    /** @type {cLBRButton} Ante Leafton (scroll down 2) */
    AnteLeafton2 := cLBRButton(1665, 1020)
}
;@endregion

;@region cAreasUmbralClusterPoints
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Tab Tab for areas panel (Umbral Cluster)
 * @property {cLBRButton} AstralOasis Astral Oasis
 * @property {cLBRButton} DimentionalTapestry Dimentional Tapestry
 * @property {cLBRButton} PlankScope Plank Scope
 * @property {cLBRButton} PlankScope2 Plank Scope second location
 * @property {cLBRButton} AnteLeafton Ante Leafton (scroll down 2)
 * @property {cLBRButton} AnteLeafton2 Ante Leafton (scroll down 2)
 */
Class cAreasUmbralClusterPoints {
    /** @type {cLBRButton} Tab for areas panel (Umbral Cluster) */
    Tab := cLBRButton(1809, 1162)
}
;@endregion

cAreasUmbralClusterPoints

;@region cAreasEventsPoints
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Tab Tab for areas panel (Events)
 * @property {cLBRButton} CursedHalloween Button in Events for Cursed Halloween
 * @property {cLBRButton} NatureBoss Nature boss button location depends on events
 * active
 * @property {cLBRButton} NatureBoss2 Nature boss button location depends on events
 * active
 * @property {cLBRButton} FarmField Farm Field
 */
Class cAreasEventsPoints {
    /** @type {cLBRButton} Tab for areas panel (Events) */
    Tab := cLBRButton(2030, 1164)
    /** @type {cLBRButton} Button in Events for Cursed Halloween */
    CursedHalloween := cLBRButton(1674, 329)
    /** @type {cLBRButton} Nature boss button location depends on events active */
    NatureBoss := cLBRButton(1682, 946)
    /** @type {cLBRButton} Nature boss button location depends on events active */
    NatureBoss2 := cLBRButton(1682, 860)
    /** @type {cLBRButton} Farm field */
    FarmField := cLBRButton(1682, 525)
}
;@endregion
