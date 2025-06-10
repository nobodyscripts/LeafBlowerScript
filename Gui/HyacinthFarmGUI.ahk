#Requires AutoHotkey v2.0

Button_Click_Hyacinth(thisGui, info) {

    HyacinthFarmBoss := S.Get("HyacinthFarmBoss")
    HyacinthUseSpheres := S.Get("HyacinthUseSpheres")
    HyacinthUseNextAvailableFlower := S.Get("HyacinthUseNextAvailableFlower")
    HyacinthBanksEnabled := S.Get("HyacinthBanksEnabled")
    HyacinthUseSlot := S.Get("HyacinthUseSlot")
    HyacinthUseFlower := S.Get("HyacinthUseFlower")
    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Hyacinth Farm Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    MyGui.Add("Text", "", "Which Farm Slot To Use:")
    Switch HyacinthUseSlot {
    Case "All":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose1", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "1":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose2", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "2":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose3", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "3":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose4", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "4":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose5", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "5":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose6", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "6":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose7", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "7":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose8", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "8":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose9", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "9":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose10", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    Case "10":
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose11", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    default:
        MyGui.Add("DropDownList", "vHyacinthUseSlot Choose1", [
            "All", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
        ])
    }

    MyGui.Add("Text", "", "Which Flower To Use:")
    Switch HyacinthUseFlower {
    Case "hyacinth":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose1", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "pansy":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose2", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "hibiscus":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose3", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "rose":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose4", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "poppy":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose5", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "primula":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose6", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "forget-me-not":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose7", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "tulip":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose8", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "camomile":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose9", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "dandelion":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose10", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "aster":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose11", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "daffodil":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose12", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "cornflower":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose13", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "lily of the valley":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose14", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "dames rocket":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose15", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    Case "marigold":
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose16", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    default:
        MyGui.Add("DropDownList", "vHyacinthUseFlower Choose1", [
            "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
            "forget-me-not", "tulip", "camomile",
            "dandelion", "aster", "daffodil", "cornflower", "lily of the valley",
            "dames rocket", "marigold"
        ])
    }

    If (HyacinthFarmBoss = true) {
        MyGui.Add("CheckBox", "vHyacinthFarmBoss checked",
            "Enable Boss Spammer")
    } Else {
        MyGui.Add("CheckBox", "vHyacinthFarmBoss",
            "Enable Boss Spammer")
    }

    If (HyacinthUseSpheres = true) {
        MyGui.Add("CheckBox", "vHyacinthUseSpheres checked",
            "Enable Sphere Use")
    } Else {
        MyGui.Add("CheckBox", "vHyacinthUseSpheres",
            "Enable Bar Sphere Use")
    }

    If (HyacinthUseNextAvailableFlower = true) {
        MyGui.Add("CheckBox",
            "vHyacinthUseNextAvailableFlower checked",
            "Enable Use Next Available Flower")
    } Else {
        MyGui.Add("CheckBox", "vHyacinthUseNextAvailableFlower",
            "Enable Use Next Available Flower")
    }

    If (HyacinthBanksEnabled = true) {
        MyGui.Add("CheckBox", "vHyacinthBanksEnabled checked",
            "Enable Banks")
    } Else {
        MyGui.Add("CheckBox", "vHyacinthBanksEnabled",
            "Enable Banks")
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunHyacinth)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveHyacinth)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessHyacinthSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseHyacinthSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessHyacinthSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        HyacinthSave()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunHyacinth(*) {
        MyGui.Hide()
        fHyacinthStart()
    }

    RunSaveHyacinth(*) {
        HyacinthSave()
        MyGui.Hide()
        fHyacinthStart()
    }

    CloseHyacinthSettings(*) {
        MyGui.Hide()
    }

    HyacinthSave() {
        values := MyGui.Submit()
        S.Set("HyacinthFarmBoss", values.HyacinthFarmBoss)
        S.Set("HyacinthUseSpheres", values.HyacinthUseSpheres)
        S.Set("HyacinthUseNextAvailableFlower", values.HyacinthUseNextAvailableFlower)
        S.Set("HyacinthBanksEnabled", values.HyacinthBanksEnabled)
        S.Set("HyacinthUseSlot", values.HyacinthUseSlot)
        S.Set("HyacinthUseFlower", values.HyacinthUseFlower)
        S.SaveCurrentSettings()
    }
}
