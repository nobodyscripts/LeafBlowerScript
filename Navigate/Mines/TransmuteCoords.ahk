#Requires AutoHotkey v2.0


; ------------ Mines transmute tab buttons for overkill tabcheck ------------


cMineTransmuteButton() { ; Button for Transmute all bars
    o := RelCoord()
    o.SetCoordRel(703, 385)
    return o
}

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

cMineTransmuteMaxCBar() { ; Duplicates cMineTransmuteButton, no real need
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

cMineTransmuteMaxSdiaToCB() { 
    o := RelCoord()
    o.SetCoordRel(1750, 512)
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

