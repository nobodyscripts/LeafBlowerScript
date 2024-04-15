#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include ../Lib/SampleArea.ahk

CavesSinglePass() {
    id := 1
    Buttons := [cMineCaveSelectButton1(), cMineCaveSelectButton2(),
        cMineCaveSelectButton3(), cMineCaveSelectButton4(), cMineCaveSelectButton5()]
    if (!IsPanelActive()) {
        return
    }
    for button in Buttons {
        while (!IsCaveSelected(id)) {
            ; until the caves selected redundantly click
            if (!IsPanelActive()) {
                return
            }
            button.ClickOffset(5, 5, 51)
            Sleep(NavigateTime)
        }
        CavesSingleCheck()
        id++
    }
}

CavesSingleCheck() {
    id := GetCurrentCave()
    if (id > 0 && Debug) {
        Log("Currently on cave " id " Diamond " BinaryToStr(IsCaveDiamond())
            " Drill state is " BinaryToStr(IsCaveDrilling()) " Locked " BinaryToStr(IsCaveLocked(id))
            " Selected " BinaryToStr(IsCaveSelected(id)))
    }
    if (id = 0) {
        if (Debug) {
            Log("Didn't find a selected cave")
        }
        return
    }
    if (IsCaveDiamond() && !IsCaveDrilling()) {
        cMineCaveDrillButton().ClickOffset()
    }
}

IsCaveDrilling() {
    if (cMineCaveIsDrillOff().AreaPixelSearch("0xFFFFFF")) {
        return false
    }
    return true
}

IsCaveLocked(id) {
    Areas := [cMineCaveLockInd1(), cMineCaveLockInd2(),
        cMineCaveLockInd3(), cMineCaveLockInd4(), cMineCaveLockInd5()]
    if (!Areas[id].AreaPixelSearch("0xFFFF79")) {
        return false
    }
    return true
}


IsCaveSelected(id) {
    Buttons := [cMineCaveSelectButton1(), cMineCaveSelectButton2(),
        cMineCaveSelectButton3(), cMineCaveSelectButton4(), cMineCaveSelectButton5()]
    colour := Buttons[id].GetColour()
    ; Green mouseover colour 0x78D063 clicked 0xA0EC84
    if (colour = "0x78D063" || colour = "0xA0EC84") {
        return true
    }
    return false
}

IsCaveDiamond() {
    if (!cMineCaveDiamondIcon().AreaPixelSearch("0x3210B0")) {
        return false
    }
    return true
}

GetCurrentCave() {
    Buttons := [cMineCaveSelectButton1(), cMineCaveSelectButton2(),
        cMineCaveSelectButton3(), cMineCaveSelectButton4(), cMineCaveSelectButton5()]
    id := 1
    for button in Buttons {
        colour := button.GetColour()
        if (colour = "0x78D063" || colour = "0xA0EC84") {
            return id
        }
        id++
    }
    return 0
}