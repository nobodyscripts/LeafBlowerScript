#Requires AutoHotkey v2.0


Button_Click_Bank(thisGui, info) {
    Global Settings, BankEnableLGDeposit, BankEnableSNDeposit,
        BankEnableEBDeposit, BankEnableFFDeposit, BankEnableSRDeposit,
        BankEnableQADeposit, BankRunsSpammer, BankDepositTime,
        BankEnableStorageUpgrade

    optionsGUI := Gui(, "Bank Maintainer Settings")
    optionsGUI.Opt("+Owner +MinSize +MinSize500x")
    optionsGUI.BackColor := "0c0018"

    If (BankEnableStorageUpgrade = true) {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade ccfcfcf checked",
            "Enable Storage Upgrade")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableStorageUpgrade ccfcfcf",
            "Enable Storage Upgrade")
    }

    optionsGUI.Add("Text", "ccfcfcf", "Bank Deposit Timer (m):")
    optionsGUI.AddEdit()
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
        optionsGUI.Add("CheckBox", "vBankRunsSpammer ccfcfcf checked",
            "Enable Boss Spammer")
    } Else {
        optionsGUI.Add("CheckBox", "vBankRunsSpammer ccfcfcf",
            "Enable Boss Spammer")
    }

    If (BankEnableLGDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableLGDeposit ccfcfcf checked",
            "Enable Leaf Galaxy Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableLGDeposit ccfcfcf",
            "Enable Leaf Galaxy Bank")
    }

    If (BankEnableSNDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableSNDeposit ccfcfcf checked",
            "Enable Sacred Nebula Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableSNDeposit ccfcfcf",
            "Enable Sacred Nebula Bank")
    }

    If (BankEnableEBDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableEBDeposit ccfcfcf checked",
            "Enable Energy Belt Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableEBDeposit ccfcfcf",
            "Enable Energy Belt Bank")
    }

    If (BankEnableFFDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableFFDeposit ccfcfcf checked",
            "Enable Fire Fields Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableFFDeposit ccfcfcf",
            "Enable Fire Fields Bank")
    }

    If (BankEnableSRDeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableSRDeposit ccfcfcf checked",
            "Enable Soul Realm Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableSRDeposit ccfcfcf",
            "Enable Soul Realm Bank")
    }

    If (BankEnableQADeposit = true) {
        optionsGUI.Add("CheckBox", "vBankEnableQADeposit ccfcfcf checked",
            "Enable Quark Ambit Bank")
    } Else {
        optionsGUI.Add("CheckBox", "vBankEnableQADeposit ccfcfcf",
            "Enable Quark Ambit Bank")
    }


    optionsGUI.Add("Button", "default", "Run").OnEvent("Click", RunBank)
    optionsGUI.Add("Button", "default yp", "Save and Run").OnEvent("Click",
        RunSaveBank)
    optionsGUI.Add("Button", "default yp", "Save").OnEvent("Click",
        ProcessBankSettings)
    optionsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseBankSettings)

    optionsGUI.Show("w300")

    ProcessBankSettings(*) {
        SaveBank()
    }

    RunSaveBank(*) {
        SaveBank()
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
        fBankStart()
    }

    RunBank(*) {
        optionsGUI.Hide()
        WinActivate(LBRWindowTitle)
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