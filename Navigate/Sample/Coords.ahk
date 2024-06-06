#Requires AutoHotkey v2.0

#Include ..\..\Lib\Coords.ahk

cSampleButton() { ; Button for sphere use
    o := RelCoord()
    o.SetCoordRel(1, 1)
    return o
}
