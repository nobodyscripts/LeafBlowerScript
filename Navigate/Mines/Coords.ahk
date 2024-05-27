#Requires AutoHotkey v2.0

; ------------------- Mining Coords --------------------

; Mine navigate tabs

cMineTabVein() { ; First tab
    o := RelCoord()
    o.SetCoordRel(526, 1180)
    return o
}

cMineTabMines() { ; Mines tab
    o := RelCoord()
    o.SetCoordRel(760, 1180)
    return o
}

cMineTabDrill() { ; Drill tab
    o := RelCoord()
    o.SetCoordRel(1320, 1180)
    return o
}

cMineTabShop() { ; Shop tab
    o := RelCoord()
    o.SetCoordRel(1600, 1180)
    return o
}

cMineTabTransmute() { ; Transmute tab
    o := RelCoord()
    o.SetCoordRel(1900, 1180)
    return o
}

; Small features

cMineFreeFuelButton() { ; Button for free fuel refill
    o := RelCoord()
    o.SetCoordRel(1220, 615)
    return o
}

cMineDrillSphereButton() { ; Button for sphere use
    o := RelCoord()
    o.SetCoordRel(1260, 445)
    return o
}
