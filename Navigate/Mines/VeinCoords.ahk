#Requires AutoHotkey v2.0


cMineVeinSearchButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(327, 353)
    return o
}

cMineVeinAutoMineButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(1495, 288)
    return o
}

cMineVeinUpgradeButton() { ; Button for upgrading vein level
    o := RelCoord()
    o.SetCoordRel(840, 370)
    return o
}

cMineVeinCancelConfirmButton() {
    o := RelCoord()
    o.SetCoordRel(1190, 520) ; Formerly 1247 527, 1063, 505
    return o
}

; Enhance button locations

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
