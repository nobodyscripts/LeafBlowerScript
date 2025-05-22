#Requires AutoHotkey v2.0

Button_Click_BorbVenture(thisGui, info) {
    Global settings, HaveBorbDLC, BVBlockMythLeg, BVItemsArr

    /** @type {GUI} */
    optionsGUI := Gui(, "Borbventures Farm Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    If (HaveBorbDLC = true) {
        optionsGUI.Add("CheckBox", "vHaveBorbDLC checked",
            "Own Borbventure DLC")
    } Else {
        optionsGUI.Add("CheckBox", "vHaveBorbDLC",
            "Own Borbventure DLC")
    }

    If (BVBlockMythLeg = true) {
        optionsGUI.Add("CheckBox", "vBVBlockMythLeg checked",
            "Block Mythic and Legendries")
    } Else {
        optionsGUI.Add("CheckBox", "vBVBlockMythLeg",
            "Block Mythic and Legendries")
    }

    optionsGUI.Add("Text", "", "Which Borbv Colours to Scan:")
    optionsGUI.Add("Edit", "cDefault vBVItemsArr r5 w275", ArrToCommaDelimStr(BVItemsArr
    ))

    optionsGUI.Add("Text", "",
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

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunBorbv)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBorbv)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessBorbvSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBorbvSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessBorbvSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        BorbvSave()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunBorbv(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBorbvStart()
    }

    RunSaveBorbv(*) {
        BorbvSave()
        optionsGUI.Hide()
        Window.Activate()
        fBorbvStart()
    }

    CloseBorbvSettings(*) {
        optionsGUI.Hide()
    }

    BorbvSave() {
        values := optionsGUI.Submit()
        HaveBorbDLC := values.HaveBorbDLC
        BVBlockMythLeg := values.BVBlockMythLeg
        BVItemsArr := CommaDelimStrToArr(values.BVItemsArr)
        settings.SaveCurrentSettings()
    }
}
