#Requires AutoHotkey v2.0

Button_Click_BorbVenture(thisGui, info) {
    Global settings, HaveBorbDLC, BVBlockMythLeg, BVItemsArr

    optionsGUI := Gui(, "Borbventures Farm Settings")
    optionsGUI.Opt("+MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    If (HaveBorbDLC = true) {
        optionsGUI.Add("CheckBox", "vHaveBorbDLC ccfcfcf checked",
            "Own Borbventure DLC")
    } Else {
        optionsGUI.Add("CheckBox", "vHaveBorbDLC ccfcfcf",
            "Own Borbventure DLC")
    }

    If (BVBlockMythLeg = true) {
        optionsGUI.Add("CheckBox", "vBVBlockMythLeg ccfcfcf checked",
            "Block Mythic and Legendries")
    } Else {
        optionsGUI.Add("CheckBox", "vBVBlockMythLeg ccfcfcf",
            "Block Mythic and Legendries")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Which Borbv Colours to Scan:")
    optionsGUI.Add("Edit", "vBVItemsArr r5 w275", ArrToCommaDelimStr(BVItemsArr
    ))

    optionsGUI.Add("Text", "ccfcfcf",
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

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunBorbv)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBorbv)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessBorbvSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseBorbvSettings)

    optionsGUI.Show("w300")

    ProcessBorbvSettings(*) {
        BorbvSave()
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
