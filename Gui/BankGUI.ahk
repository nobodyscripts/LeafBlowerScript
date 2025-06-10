#Requires AutoHotkey v2.0

Button_Click_Bank(thisGui, info) {

    BankEnableStorageUpgrade := S.Get("BankEnableStorageUpgrade")
    BankDepositTime := S.Get("BankDepositTime")
    BankRunsSpammer := S.Get("BankRunsSpammer")
    BankEnableLGDeposit := S.Get("BankEnableLGDeposit")
    BankEnableSNDeposit := S.Get("BankEnableSNDeposit")
    BankEnableEBDeposit := S.Get("BankEnableEBDeposit")
    BankEnableFFDeposit := S.Get("BankEnableFFDeposit")
    BankEnableSRDeposit := S.Get("BankEnableSRDeposit")
    BankEnableQADeposit := S.Get("BankEnableQADeposit")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "Bank Maintainer Settings")
    MyGui.SetUserFontSettings()

    If (BankEnableStorageUpgrade = true) {
        MyGui.Add("CheckBox", "vBankEnableStorageUpgrade checked",
            "Enable Storage Upgrade")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableStorageUpgrade",
            "Enable Storage Upgrade")
    }

    MyGui.Add("Text", "", "Bank Deposit Timer (m):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(BankDepositTime) || IsFloat(BankDepositTime)) {
        MyGui.Add("UpDown", "vBankDepositTime Range0-9999",
            BankDepositTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vBankDepositTime Range0-9999", S.defaultNobodySettings
                .BankDepositTime)
        } Else {
            MyGui.Add("UpDown", "vBankDepositTime Range0-9999", S.defaultSettings
                .BankDepositTime)
        }
    }

    If (BankRunsSpammer = true) {
        MyGui.Add("CheckBox", "vBankRunsSpammer checked",
            "Enable Boss Spammer")
    } Else {
        MyGui.Add("CheckBox", "vBankRunsSpammer",
            "Enable Boss Spammer")
    }

    If (BankEnableLGDeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableLGDeposit checked",
            "Enable Leaf Galaxy Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableLGDeposit",
            "Enable Leaf Galaxy Bank")
    }

    If (BankEnableSNDeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableSNDeposit checked",
            "Enable Sacred Nebula Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableSNDeposit",
            "Enable Sacred Nebula Bank")
    }

    If (BankEnableEBDeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableEBDeposit checked",
            "Enable Energy Belt Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableEBDeposit",
            "Enable Energy Belt Bank")
    }

    If (BankEnableFFDeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableFFDeposit checked",
            "Enable Fire Fields Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableFFDeposit",
            "Enable Fire Fields Bank")
    }

    If (BankEnableSRDeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableSRDeposit checked",
            "Enable Soul Realm Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableSRDeposit",
            "Enable Soul Realm Bank")
    }

    If (BankEnableQADeposit = true) {
        MyGui.Add("CheckBox", "vBankEnableQADeposit checked",
            "Enable Quark Ambit Bank")
    } Else {
        MyGui.Add("CheckBox", "vBankEnableQADeposit",
            "Enable Quark Ambit Bank")
    }

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunBank)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBank)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessBankSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBankSettings)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessBankSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()
        SaveBank()
        Saving.Hide()
        Temp.Show()
        MyGui.Show()
    }

    RunSaveBank(*) {
        SaveBank()
        MyGui.Hide()
        fBankStart()
    }

    RunBank(*) {
        MyGui.Hide()
        fBankStart()
    }

    CloseBankSettings(*) {
        MyGui.Hide()
    }

    SaveBank() {
        values := MyGui.Submit()
        S.Set("BankEnableStorageUpgrade", values.BankEnableStorageUpgrade)
        S.Set("BankDepositTime", values.BankDepositTime)
        S.Set("BankRunsSpammer", values.BankRunsSpammer)
        S.Set("BankEnableLGDeposit", values.BankEnableLGDeposit)
        S.Set("BankEnableSNDeposit", values.BankEnableSNDeposit)
        S.Set("BankEnableEBDeposit", values.BankEnableEBDeposit)
        S.Set("BankEnableFFDeposit", values.BankEnableFFDeposit)
        S.Set("BankEnableSRDeposit", values.BankEnableSRDeposit)
        S.Set("BankEnableQADeposit", values.BankEnableQADeposit)
        S.SaveCurrentSettings()
    }

}
