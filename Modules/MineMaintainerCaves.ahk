#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRect.ahk

CavesSinglePass() {
    id := 1
    Buttons := GetCaveTabButtons()
    if (!IsPanelActive()) {
        return
    }
    if (!Points.Mine.Cave.Select1.IsButton()) {
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
        DebugLog("Didn't find a selected cave")
        return
    }
    if (IsCaveDiamond() && !IsCaveDrilling()) {
        Points.Mine.Cave.DrillToggle.ClickOffset()
    }
}

IsCaveDrilling() {
    if (Rects.Mine.Cave.DrillStatus.PixelSearch("0xFFFFFF")) {
        return false
    }
    return true
}

IsCaveLocked(id) {
    LockAreas := [Rects.Mine.Cave.LockInd1,
        Rects.Mine.Cave.LockInd2,
        Rects.Mine.Cave.LockInd3,
        Rects.Mine.Cave.LockInd4,
        Rects.Mine.Cave.LockInd5]
    if (!LockAreas[id].PixelSearch("0xFFFF79")) {
        return false
    }
    return true
}


IsCaveSelected(id) {
    Buttons := GetCaveTabButtons()
    colour := Buttons[id].GetColour()
    ; Green mouseover colour 0x78D063 clicked 0xA0EC84
    if (colour = "0x78D063" || colour = "0xA0EC84") {
        return true
    }
    return false
}

IsCaveDiamond() {
    if (!Rects.Mine.Cave.DiamondIcon.PixelSearch("0x3210B0")) {
        return false
    }
    return true
}

GetCurrentCave() {
    Buttons := GetCaveTabButtons()
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

GetCaveTabButtons() {
    return [Points.Mine.Cave.Select1,
        Points.Mine.Cave.Select2,
        Points.Mine.Cave.Select3,
        Points.Mine.Cave.Select4,
        Points.Mine.Cave.Select5]
}