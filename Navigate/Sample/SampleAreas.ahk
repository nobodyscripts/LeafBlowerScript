#Requires AutoHotkey v2.0

#Include ..\..\Lib\SampleArea.ahk

cAreaSample() {
    o := RelSampleArea()
    o.SetCoordRel(1, 1, 2, 2)
    return o
}
