#Requires AutoHotkey v2.0

Button_Click_BorbVenture(thisGui, info) {
    HaveBorbDLC := S.Get("HaveBorbDLC")
    BVBlockMythLeg := S.Get("BVBlockMythLeg")
    BVItemsArr := S.Get("BVItemsArr")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Borbventures Farm Settings")
    MyGui.SetUserFontSettings()

    If (HaveBorbDLC = true) {
        MyGui.Add("CheckBox", "vHaveBorbDLC checked",
            "Own Borbventure DLC")
    } Else {
        MyGui.Add("CheckBox", "vHaveBorbDLC",
            "Own Borbventure DLC")
    }

    If (BVBlockMythLeg = true) {
        MyGui.Add("CheckBox", "vBVBlockMythLeg checked",
            "Block Mythic and Legendries")
    } Else {
        MyGui.Add("CheckBox", "vBVBlockMythLeg",
            "Block Mythic and Legendries")
    }

    MyGui.Add("Text", "", "Which Borbv Colours to Scan:")
    MyGui.Add("Edit", "cDefault vBVItemsArr r5 w275", ArrToCommaDelimStr(BVItemsArr
    ))
    ; TODO Convert borbventures gui to checkboxes for item selection
    MyGui.Add("Text", "",
        "0xF91FF6 Borb ascention juice (purple default)`n"
        "0x70F928 Borb juice (green)`n"
        "0x0F2A1D Nature time sphere`n"
        "0x55B409 Borb rune (green)`n"
        "0x018C9C Magic mulch`n"
        "0x01D814 Nature gem`n"
        "0xAB5A53 Random item box (all types)`n"
        "0x98125F Borb rune (purple)`n"
        "0xC1C1C1 Candy`n"
        "0x6CD820 Both clovers (uses same colours)`n"
        "0x6BEA15 Borb token`n"
        "0xCEF587 Free borb token`n"
        "0xC9C9C9 Dice Points (white)`n"
        "0x0E44BE Power Dice Points (blue)`n"
        "0x11CF1C Quantum Blob (green)`n"
        "0x250D05 Quark Blob (purple)`n"
        "0x120D1C Quark Structures")

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunBorbv)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBorbv)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessBorbvSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBorbvSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessBorbvSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        BorbvSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunBorbv(*) {
        MyGui.Hide()
        fBorbvStart()
    }

    RunSaveBorbv(*) {
        BorbvSave()
        MyGui.Hide()
        fBorbvStart()
    }

    CloseBorbvSettings(*) {
        MyGui.Hide()
    }

    BorbvSave() {
        values := MyGui.Submit()
        S.Set("HaveBorbDLC", values.HaveBorbDLC)
        S.Set("BVBlockMythLeg", values.BVBlockMythLeg)
        S.Set("BVItemsArr", values.BVItemsArr)
        S.SaveCurrentSettings()
    }
}
