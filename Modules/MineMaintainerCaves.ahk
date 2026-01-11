#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\ScriptLib\cRect.ahk

; TODO Travel and opening review

CavesSinglePass() {
    NavigateTime := S.Get("NavigateTime")
    id := 1
    Buttons := GetCaveTabButtons()
    If (!Window.IsPanel()) {
        Return
    }
    If (!Points.Mine.Cave.Select1.IsButton()) {
        Return
    }
    For button in Buttons {
        While (!IsCaveSelected(id)) {
            ; until the caves selected redundantly click
            If (!Window.IsPanel()) {
                Return
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
    If (id > 0 && S.Get("DebugAll")) {
        Out.I("Currently on cave " id " Diamond " BinToStr(IsCaveDiamond())
        " Drill state is " BinToStr(IsCaveDrilling()) " Locked " BinToStr(
            IsCaveLocked(id))
        " Selected " BinToStr(IsCaveSelected(id)))
    }
    If (id = 0) {
        Out.D("Didn't find a selected cave")
        Return
    }
    If (IsCaveDiamond() && !IsCaveDrilling()) {
        Points.Mine.Cave.DrillToggle.ClickOffset()
    }
}

IsCaveDrilling() {
    If (Rects.Mine.Cave.DrillStatus.PixelSearch("0xFFFFFF")) {
        Return false
    }
    Return true
}

IsCaveLocked(id) {
    LockAreas := [Rects.Mine.Cave.LockInd1, Rects.Mine.Cave.LockInd2, Rects.Mine
        .Cave.LockInd3, Rects.Mine.Cave.LockInd4, Rects.Mine.Cave.LockInd5]
    If (!LockAreas[id].PixelSearch("0xFFFF79")) {
        Return false
    }
    Return true
}

IsCaveSelected(id) {
    Buttons := GetCaveTabButtons()
    colour := Buttons[id].GetColour()
    ; Green mouseover colour 0x78D063 clicked 0xA0EC84
    If (colour = "0x78D063" || colour = "0xA0EC84") {
        Return true
    }
    Return false
}

IsCaveDiamond() {
    If (!Rects.Mine.Cave.DiamondIcon.PixelSearch("0x3210B0")) {
        Return false
    }
    Return true
}

GetCurrentCave() {
    Buttons := GetCaveTabButtons()
    id := 1
    For button in Buttons {
        colour := button.GetColour()
        If (colour = "0x78D063" || colour = "0xA0EC84") {
            Return id
        }
        id++
    }
    Return 0
}

GetCaveTabButtons() {
    Return [Points.Mine.Cave.Select1, Points.Mine.Cave.Select2, Points.Mine.Cave
        .Select3, Points.Mine.Cave.Select4, Points.Mine.Cave.Select5]
}
