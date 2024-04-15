#Requires AutoHotkey v2.0

; Lock indicator area markers

cMineCaveLockInd1() {
    o := RelSampleArea()
    o.SetCoordRel(628, 474, 655, 501)
    return o
}

cMineCaveLockInd2() {
    o := RelSampleArea()
    o.SetCoordRel(628, 538, 655, 563)
    return o
}

cMineCaveLockInd3() {
    o := RelSampleArea()
    o.SetCoordRel(628, 601, 655, 627)
    return o
}

cMineCaveLockInd4() {
    o := RelSampleArea()
    o.SetCoordRel(628, 665, 655, 691)
    return o
}

cMineCaveLockInd5() {
    o := RelSampleArea()
    o.SetCoordRel(628, 730, 655, 756)
    return o
}

; Diamond icon in rewards next to drilling
cMineCaveDiamondIcon() {
    o := RelSampleArea()
    o.SetCoordRel(1144, 966, 1186, 999)
    return o
}

; Area to the right of drill (On) text display
cMineCaveIsDrillOff() {
    o := RelSampleArea()
    o.SetCoordRel(880, 866, 885, 890)
    return o
}
