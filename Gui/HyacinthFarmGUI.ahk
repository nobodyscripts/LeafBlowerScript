#Requires AutoHotkey v2.0

Button_Click_Hyacinth(thisGui, info) {
    Global settings, HyacinthFarmBoss, HyacinthUseSpheres,
        HyacinthUseNextAvailableFlower, HyacinthUseSlot, HyacinthBanksEnabled,
        HyacinthUseFlower

    optionsGUI := Gui(, "Hyacinth Farm Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    optionsGUI.Add("Text", "ccfcfcf", "Which Farm Slot To Use:")
    Switch HyacinthUseSlot {
        Case "All":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose1", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "1":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose2", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "2":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose3", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "3":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose4", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "4":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose5", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "5":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose6", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "6":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose7", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "7":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose8", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "8":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose9", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "9":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose10", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        Case "10":
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose11", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        default:
            optionsGUI.Add("DropDownList", "vHyacinthUseSlot Choose1", ["All",
                "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
    }

    optionsGUI.Add("Text", "ccfcfcf", "Which Flower To Use:")
    Switch HyacinthUseFlower {
        Case "hyacinth":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose1", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "pansy":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose2", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "hibiscus":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose3", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "rose":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose4", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "poppy":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose5", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "primula":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose6", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "forget-me-not":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose7", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "tulip":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose8", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "camomile":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose9", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "dandelion":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose10", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "aster":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose11", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "daffodil":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose12", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "cornflower":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose13", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "lily of the valley":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose14", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "dames rocket":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose15", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        Case "marigold":
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose16", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
        default:
            optionsGUI.Add("DropDownList", "vHyacinthUseFlower Choose1", [
                "hyacinth", "pansy", "hibiscus", "rose", "poppy", "primula",
                "forget-me-not", "tulip", "camomile", "dandelion", "aster",
                "daffodil", "cornflower", "lily of the valley", "dames rocket",
                "marigold"])
    }

    If (HyacinthFarmBoss = true) {
        optionsGUI.Add("CheckBox", "vHyacinthFarmBoss ccfcfcf checked",
            "Enable Boss Spammer")
    } Else {
        optionsGUI.Add("CheckBox", "vHyacinthFarmBoss ccfcfcf",
            "Enable Boss Spammer")
    }

    If (HyacinthUseSpheres = true) {
        optionsGUI.Add("CheckBox", "vHyacinthUseSpheres ccfcfcf checked",
            "Enable Sphere Use")
    } Else {
        optionsGUI.Add("CheckBox", "vHyacinthUseSpheres ccfcfcf",
            "Enable Bar Sphere Use")
    }

    If (HyacinthUseNextAvailableFlower = true) {
        optionsGUI.Add("CheckBox",
            "vHyacinthUseNextAvailableFlower ccfcfcf checked",
            "Enable Use Next Available Flower")
    } Else {
        optionsGUI.Add("CheckBox", "vHyacinthUseNextAvailableFlower ccfcfcf",
            "Enable Use Next Available Flower")
    }

    If (HyacinthBanksEnabled = true) {
        optionsGUI.Add("CheckBox", "vHyacinthBanksEnabled ccfcfcf checked",
            "Enable Banks")
    } Else {
        optionsGUI.Add("CheckBox", "vHyacinthBanksEnabled ccfcfcf",
            "Enable Banks")
    }

    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunHyacinth)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveHyacinth)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessHyacinthSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseHyacinthSettings)

    optionsGUI.Show("w300")

    ProcessHyacinthSettings(*) {
        HyacinthSave()
    }

    RunHyacinth(*) {
        optionsGUI.Hide()
        Window.Activate()
        fHyacinthStart()
    }

    RunSaveHyacinth(*) {
        HyacinthSave()
        optionsGUI.Hide()
        Window.Activate()
        fHyacinthStart()
    }

    CloseHyacinthSettings(*) {
        optionsGUI.Hide()
    }

    HyacinthSave() {
        values := optionsGUI.Submit()
        HyacinthFarmBoss := values.HyacinthFarmBoss
        HyacinthUseSpheres := values.HyacinthUseSpheres
        HyacinthUseNextAvailableFlower := values.HyacinthUseNextAvailableFlower
        HyacinthBanksEnabled := values.HyacinthBanksEnabled
        HyacinthUseSlot := values.HyacinthUseSlot
        HyacinthUseFlower := values.HyacinthUseFlower
        settings.SaveCurrentSettings()
    }
}