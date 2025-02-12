#Requires AutoHotkey v2.0

#Include ..\Lib\cRects.ahk

/**
 * Areas panel {cRect} collection
 * @memberof module:cRects
 * @property {cAreasFavPoints} Favs Favourites
 * @property {cAreasLeafGPoints} LeafG Leaf Galaxy
 * @property {cAreasSacredNPoints} SacredN Sacred Nebula
 * @property {cAreasEnergyBPoints} EnergyB Energy Belt
 * @property {cAreasFireFPoints} FireF Fire Fields
 * @property {cAreasSoulRPoints} SoulR Soul Realm
 * @property {cAreasQuarkAPoints} QuarkA Quark Ambit
 * @property {cAreasEventsPoints} Events Events
 */
Class cAreasRects {
    
    /** @type {cAreasFavRects} Favs Favourites */
    Favs := cAreasFavRects()
    
    /** @type {cAreasLeafGRects} Leaf Galaxy */
    LeafGalaxy := cAreasLeafGRects()

    /** @type {cAreasSacredNRects} Sacred Nebula */
    SacredNebula := cAreasSacredNRects()

    /** @type {cAreasEnergyBRects} Energy Belt */
    EnergyBelt := cAreasEnergyBRects()

    /** @type {cAreasFireFRects} Fire Fields */
    FireFields := cAreasFireFRects()

    /** @type {cAreasSoulRRects} Soul Realm */
    SoulRealm := cAreasSoulRRects()

    /** @type {cAreasQuarkARects} Quark Ambit */
    QuarkAmbit := cAreasQuarkARects()

    /** @type {cAreasEventsRects} Events */
    Events := cAreasEventsRects()
}

/**
 * cAreasFavRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasFavRects
 * @property {Type} property Desc
 */
Class cAreasFavRects {
    /** @type {Type} Desc */
    property := 0

}

/**
 * Areas panel {cRect} collection (Rects.Areas.LeafGalaxy)
 * @memberof module:cRects
 * @property {cRect} LeafTower LeafTower button alignment area
 * @property {cRect} GardenReset Garden reset area
 */
Class cAreasLeafGRects {
    /** @type {cRect} LeafTower button alignment area */
    LeafTower := cRect(1563, 430, 1615, 964)

    /** @type {cRect} Gardenreset area */
    GardenReset := cRect(1240, 5, 1280, 40)
}

/**
 * cAreasSacredNRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasSacredNRects
 * @property {Type} property Desc
 */
Class cAreasSacredNRects {
    /** @type {Type} Desc */
    property := 0

    
}

/**
 * cAreasEnergyBRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasEnergyBRects
 * @property {Type} property Desc
 */
Class cAreasEnergyBRects {
    /** @type {Type} Desc */
    property := 0

}

/**
 * cAreasFireFRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasFireFRects
 * @property {Type} property Desc
 */
Class cAreasFireFRects {
    /** @type {Type} Desc */
    property := 0

}

/**
 * cAreasSoulRRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasSoulRRects
 * @property {Type} property Desc
 */
Class cAreasSoulRRects {
    /** @type {Type} Desc */
    property := 0

}

/**
 * cAreasQuarkARects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasQuarkARects
 * @property {Type} property Desc
 */
Class cAreasQuarkARects {
    /** @type {Type} Desc */
    property := 0

}

/**
 * cAreasEventsRects Areas panel {cRect} collection (Rects.Areas)
 * @module cAreasEventsRects
 * @property {Type} property Desc
 */
Class cAreasEventsRects {
    /** @type {Type} Desc */
    property := 0

}
