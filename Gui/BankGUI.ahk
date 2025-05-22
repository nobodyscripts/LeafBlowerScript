#Requires AutoHotkey v2.0

Button_Click_Bank(thisGui, info) {
    Global Settings, BankEnableLGDeposit, BankEnableSNDeposit,
        BankEnableEBDeposit, BankEnableFFDeposit, BankEnableSRDeposit,
        BankEnableQADeposit, BankRunsSpammer, BankDepositTime,
        BankEnableStorageUpgrade

    /** @type {GUI} */
    optionsGUI := Gui(, "Bank Maintainer Settings")
    optionsGUI.Opt("")
    SetFontOptions(optionsGUI)

    If (BankEnableStorageUpgrade = true) {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade checked",
            "Enable Storage Upgrade")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade",
            "Enable Storage Upgrade")
    }

    optionsGUI.Add("Text", "", "Bank Deposit Timer (m):")
    optionsGUI.AddEdit("cDefault")
    If (IsInteger(BankDepositTime) || IsFloat(BankDepositTime)) {
        optionsGUI.Add("UpDown", "vBankDepositTime Range0-9999",
            BankDepositTime)
    } Else {
        If (Settings.sUseNobody) {
            optionsGUI.Add("UpDown", "vBankDepositTime Range0-9999", Settings.defaultNobodySettings
                .BankDepositTime)
        } Else {
            optionsGUI.Add("UpDown", "vBankDepositTime Range0-9999", Settings.defaultSettings
                .BankDepositTime)
        }
    }

    If (BankRunsSpammer = true) {
        optionsGUI.Add("CheckBox", "vBankRunsSpammer checked",
            "Enable Boss Spammer")
    } Else {
        optionsGUI.Add("CheckBox", "vBankRunsSpammer",
            "Enable Boss Spammer")
    }

    If (BankEnableLGDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableLGDeposit checked",
            "Enable Leaf Galaxy Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableLGDeposit",
            "Enable Leaf Galaxy Bank")
    }

    If (BankEnableSNDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableSNDeposit checked",
            "Enable Sacred Nebula Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableSNDeposit",
            "Enable Sacred Nebula Bank")
    }

    If (BankEnableEBDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableEBDeposit checked",
            "Enable Energy Belt Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableEBDeposit",
            "Enable Energy Belt Bank")
    }

    If (BankEnableFFDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableFFDeposit checked",
            "Enable Fire Fields Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableFFDeposit",
            "Enable Fire Fields Bank")
    }

    If (BankEnableSRDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableSRDeposit checked",
            "Enable Soul Realm Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableSRDeposit",
            "Enable Soul Realm Bank")
    }

    If (BankEnableQADeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableQADeposit checked",
            "Enable Quark Ambit Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableQADeposit",
            "Enable Quark Ambit Bank")
    }

    optionsGUI.Add("Button", "+Background" GuiBGColour " default", "Run").OnEvent("Click", RunBank)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save and Run").OnEvent("Click",
        RunSaveBank)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Save").OnEvent("Click",
        ProcessBankSettings)
    optionsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseBankSettings)

    ShowGUIPosition(optionsGUI)
    optionsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessBankSettings(*) {
        Temp := thisGui.Gui
        Saving := SavingGUI()
        optionsGUI.Hide()
        Temp.Hide()
        Saving.Show()
        SaveBank()
        Saving.Hide()
        Temp.Show()
        optionsGUI.Show()
    }

    RunSaveBank(*) {
        SaveBank()
        optionsGUI.Hide()
        Window.Activate()
        fBankStart()
    }

    RunBank(*) {
        optionsGUI.Hide()
        Window.Activate()
        fBankStart()
    }

    CloseBankSettings(*) {
        optionsGUI.Hide()
    }

    SaveBank() {
        values := optionsGUI.Submit()
        BankEnableStorageUpgrade := values.BankEnableStorageUpgrade
        BankDepositTime := values.BankDepositTime
        BankRunsSpammer := values.BankRunsSpammer
        BankEnableLGDeposit := values.BankEnableLGDeposit
        BankEnableSNDeposit := values.BankEnableSNDeposit
        BankEnableEBDeposit := values.BankEnableEBDeposit
        BankEnableFFDeposit := values.BankEnableFFDeposit
        BankEnableSRDeposit := values.BankEnableSRDeposit
        BankEnableQADeposit := values.BankEnableQADeposit
        Settings.SaveCurrentSettings()
    }

}
