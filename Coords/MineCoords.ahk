#Requires AutoHotkey v2.0

#Include MineSampleAreas.ahk

; ------------------- Mining Coords --------------------

cMineEnhanceSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(1016, 575)
    return o
}

cMineEnhanceSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1980, 575)
    return o
}

cMineEnhanceSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(1016, 725)
    return o
}

cMineEnhanceSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1980, 725)
    return o
}

cMineEnhanceSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(1016, 870)
    return o
}

cMineEnhanceSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1980, 870)
    return o
}

; Vein rarity colours

cMineColourSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(410, 575)
    return o
}

cMineColourSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1368, 575)
    return o
}

cMineColourSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(410, 720)
    return o
}

cMineColourSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1368, 720)
    return o
}

cMineColourSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(410, 870)
    return o
}

cMineColourSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1368, 870)
    return o
}

; Vein type icon locations

cMineVeinIconSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(829, 561)
    return o
}

cMineVeinIconSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(1789, 561)
    return o
}

cMineVeinIconSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(829, 711)
    return o
}

cMineVeinIconSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(1789, 711)
    return o
}

cMineVeinIconSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(829, 860)
    return o
}

cMineVeinIconSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(1789, 860)
    return o
}

; Vein cancel button locations

cMineVeinCancelSlot1() { ; Top left
    o := RelCoord()
    o.SetCoordRel(1140, 575)
    return o
}

cMineVeinCancelSlot2() { ; Top right
    o := RelCoord()
    o.SetCoordRel(2100, 575)
    return o
}

cMineVeinCancelSlot3() { ; Mid left
    o := RelCoord()
    o.SetCoordRel(1140, 723)
    return o
}

cMineVeinCancelSlot4() { ; Mid right
    o := RelCoord()
    o.SetCoordRel(2100, 723)
    return o
}

cMineVeinCancelSlot5() { ; Bottom left
    o := RelCoord()
    o.SetCoordRel(1140, 874)
    return o
}

cMineVeinCancelSlot6() { ; Bottom right
    o := RelCoord()
    o.SetCoordRel(2100, 874)
    return o
}

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

cMineTransmuteButton() { ; Button for Transmute all bars
    o := RelCoord()
    o.SetCoordRel(703, 385)
    return o
}

cMineVeinUpgradeButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(840, 370)
    return o
}

cMineVeinCancelConfirmButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(1190, 520) ; Formerly 1247 527, 1063, 505
    return o
}

; ------------ Mines transmute tab buttons for overkill tabcheck ------------

cMineTransmuteSingleCBar() { 
    o := RelCoord()
    o.SetCoordRel(600, 387)
    return o
}


cMineTransmuteSingleSdia() { 
    o := RelCoord()
    o.SetCoordRel(603, 518)
    return o
}

cMineTransmuteSingleFuel() { 
    o := RelCoord()
    o.SetCoordRel(603, 644)
    return o
}

cMineTransmuteSingleSphere() { 
    o := RelCoord()
    o.SetCoordRel(602, 774)
    return o
}

cMineTransmuteMaxCBar() { 
    o := RelCoord()
    o.SetCoordRel(724, 387)
    return o
}

cMineTransmuteMaxSdia() { 
    o := RelCoord()
    o.SetCoordRel(723, 516)
    return o
}

cMineTransmuteMaxFuel() { 
    o := RelCoord()
    o.SetCoordRel(724, 644)
    return o
}

cMineTransmuteMaxSphere() { 
    o := RelCoord()
    o.SetCoordRel(722, 772)
    return o
}

cMineTransmuteAutoCBar() { 
    o := RelCoord()
    o.SetCoordRel(1082, 384)
    return o
}

cMineTransmuteAutoSdia() { 
    o := RelCoord()
    o.SetCoordRel(1083, 514)
    return o
}

cMineTransmuteAutoFuel() { 
    o := RelCoord()
    o.SetCoordRel(1085, 643)
    return o
}

cMineTransmuteAutoSphere() { 
    o := RelCoord()
    o.SetCoordRel(1083, 771)
    return o
}

