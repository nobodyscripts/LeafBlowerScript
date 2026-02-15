#Requires AutoHotkey v2.0

Button_Click_BorbVenture(thisGui, info) {
    HaveBorbDLC := S.Get("HaveBorbDLC")
    BVBlockMythLeg := S.Get("BVBlockMythLeg")
    /**
     * @type {Array[string]}
     */
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

    checked := (BVArrContains("0xF91FF6")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbAscJuiceP" checked,
        "Enable Borb ascention juice (purple)")

    checked := (BVArrContains("0x70F928")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbJuiceG" checked,
        "Enable Borb juice (green)")

    checked := (BVArrContains("0x0F2A1D")) ? " checked" : ""
    MyGui.Add("CheckBox", "vNatureTimeSphere" checked,
        "Enable Nature time sphere")

    checked := (BVArrContains("0x55B409")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbRuneG" checked,
        "Enable Borb rune (green)")

    checked := (BVArrContains("0x98125F")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbRuneP" checked,
        "Enable Borb rune (purple)")

    checked := (BVArrContains("0x018C9C")) ? " checked" : ""
    MyGui.Add("CheckBox", "vMagicMulch" checked,
        "Enable Magic mulch")

    checked := (BVArrContains("0x01D814")) ? " checked" : ""
    MyGui.Add("CheckBox", "vNatureGem" checked,
        "Enable Nature gem")

    checked := (BVArrContains("0xAB5A53")) ? " checked" : ""
    MyGui.Add("CheckBox", "vRandomItemBox" checked,
        "Enable Random item box")

    checked := (BVArrContains("0xC1C1C1")) ? " checked" : ""
    MyGui.Add("CheckBox", "vCandy" checked,
        "Enable Candy")

    checked := (BVArrContains("0x6CD820")) ? " checked" : ""
    MyGui.Add("CheckBox", "vClovers" checked,
        "Enable Both clovers (uses same colours)")

    checked := (BVArrContains("0x6BEA15")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbToken" checked,
        "Enable Borb token")

    checked := (BVArrContains("0xCEF587")) ? " checked" : ""
    MyGui.Add("CheckBox", "vBorbTokenFree" checked,
        "Enable Free Borb token")

    checked := (BVArrContains("0xC9C9C9")) ? " checked" : ""
    MyGui.Add("CheckBox", "vDicePointsWhite" checked,
        "Enable Dice Points (white)")

    checked := (BVArrContains("0x0E44BE")) ? " checked" : ""
    MyGui.Add("CheckBox", "vDicePointsBlue" checked,
        "Enable Power Dice Points (blue)")

    checked := (BVArrContains("0x11CF1C")) ? " checked" : ""
    MyGui.Add("CheckBox", "vQuantumBlobGreen" checked,
        "Enable Quantum Blob (green)")

    checked := (BVArrContains("0x250D05")) ? " checked" : ""
    MyGui.Add("CheckBox", "vQuarkBlobpurple" checked,
        "Enable Quark Blob (purple)")

    checked := (BVArrContains("0x120D1C")) ? " checked" : ""
    MyGui.Add("CheckBox", "vQuarkStructures" checked,
        "Enable Quark Structures")

    /* MyGui.Add("Edit", "cDefault vBVItemsArr r5 w275", ArrToCommaDelimStr(BVItemsArr
    ))
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
    "0x120D1C Quark Structures") */

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
        If (MyGui["BorbAscJuiceP"].Value) {
            BVArrAdd("0xF91FF6")
        } Else {
            BVArrRemove("0xF91FF6")
        }
        If (MyGui["BorbJuiceG"].Value) {
            BVArrAdd("0x70F928")
        } Else {
            BVArrRemove("0x70F928")
        }
        If (MyGui["NatureTimeSphere"].Value) {
            BVArrAdd("0x0F2A1D")
        } Else {
            BVArrRemove("0x0F2A1D")
        }
        If (MyGui["BorbRuneG"].Value) {
            BVArrAdd("0x55B409")
        } Else {
            BVArrRemove("0x55B409")
        }
        If (MyGui["BorbRuneP"].Value) {
            BVArrAdd("0x98125F")
        } Else {
            BVArrRemove("0x98125F")
        }
        If (MyGui["MagicMulch"].Value) {
            BVArrAdd("0x018C9C")
        } Else {
            BVArrRemove("0x018C9C")
        }
        If (MyGui["NatureGem"].Value) {
            BVArrAdd("0x01D814")
        } Else {
            BVArrRemove("0x01D814")
        }
        If (MyGui["RandomItemBox"].Value) {
            BVArrAdd("0xAB5A53")
        } Else {
            BVArrRemove("0xAB5A53")
        }
        If (MyGui["Candy"].Value) {
            BVArrAdd("0xC1C1C1")
        } Else {
            BVArrRemove("0xC1C1C1")
        }
        If (MyGui["Clovers"].Value) {
            BVArrAdd("0x6CD820")
        } Else {
            BVArrRemove("0x6CD820")
        }
        If (MyGui["BorbToken"].Value) {
            BVArrAdd("0x6BEA15")
        } Else {
            BVArrRemove("0x6BEA15")
        }
        If (MyGui["BorbTokenFree"].Value) {
            BVArrAdd("0xCEF587")
        } Else {
            BVArrRemove("0xCEF587")
        }
        If (MyGui["DicePointsWhite"].Value) {
            BVArrAdd("0xC9C9C9")
        } Else {
            BVArrRemove("0xC9C9C9")
        }
        If (MyGui["DicePointsBlue"].Value) {
            BVArrAdd("0x0E44BE")
        } Else {
            BVArrRemove("0x0E44BE")
        }
        If (MyGui["QuantumBlobGreen"].Value) {
            BVArrAdd("0x11CF1C")
        } Else {
            BVArrRemove("0x11CF1C")
        }
        If (MyGui["QuarkBlobpurple"].Value) {
            BVArrAdd("0x250D05")
        } Else {
            BVArrRemove("0x250D05")
        }
        If (MyGui["QuarkStructures"].Value) {
            BVArrAdd("0x120D1C")
        } Else {
            BVArrRemove("0x120D1C")
        }
        S.Set("BVItemsArr", BVItemsArr)
        S.SaveCurrentSettings()
    }

    BVArrContains(searchItem) {
        For id, value IN BVItemsArr {
            If (value == searchItem) {
                Return true
            }
        }
        Return false
    }

    BVArrRemove(Item) {
        _i := 1
        if (BVItemsArr.Length < 1) {
            return
        }
        Loop BVItemsArr.Length {
            If (Item == BVItemsArr[_i]) {
                BVItemsArr.RemoveAt(_i)
            }
            _i++
            if (_i > BVItemsArr.Length) {
                break
            }
        }
    }

    BVArrAdd(Item) {
        If (!BVArrContains(Item)) {
            BVItemsArr.Push(Item)
        }
    }
}
