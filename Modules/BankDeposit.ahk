#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk

S.AddSetting("Bank", "BankEnableLGDeposit", true, "bool")
S.AddSetting("Bank", "BankEnableSNDeposit", true, "bool")
S.AddSetting("Bank", "BankEnableEBDeposit", true, "bool")
S.AddSetting("Bank", "BankEnableFFDeposit", true, "bool")
S.AddSetting("Bank", "BankEnableSRDeposit", true, "bool")
S.AddSetting("Bank", "BankEnableQADeposit", true, "bool")
S.AddSetting("Bank", "BankEnableStorageUpgrade", false, "bool")
S.AddSetting("Bank", "BankRunsSpammer", true, "bool")
S.AddSetting("Bank", "BankDepositTime", 5, "int")

fBankAutoDeposit() {
    NavigateTime := S.Get("NavigateTime")
    BankDepositTime := S.Get("BankDepositTime")
    BankRunsSpammer := S.Get("BankRunsSpammer")
    BankEnableStorageUpgrade := S.Get("BankEnableStorageUpgrade")
    DepositRESS := Points.Bank.DepositRESS
    UpgradeButton := Points.Bank.UpgradeStorage
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    If (BankRunsSpammer) {
        Spammer.NormalBossStart()
    }
    Shops.OpenBank()
    ToolTip("Bank Maintainer Active", Window.W / 2 - Window.RelW(100), Window.H /
    2, 4)
    Loop {
        If (!Window.IsActive()) {
            Break
        }
        i := 0
        While (i < 6) {
            If (!Window.IsActive() || !Window.IsPanel()) {
                Break
            }
            ResetBankScroll()
            If (BankIsTabEnabled(i)) {
                buttonTab := BankTabCoordByInd(i)
                If (!IsOnBankTab(buttonTab)) {
                    BankTravelAreaByInd(i)
                    Sleep(NavigateTime)
                }
                Loop {
                    If (!Window.IsActive() || !Window.IsPanel()) {
                        Break
                    }
                    If (DepositRESS.IsButtonActive()) {
                        DepositRESS.ClickOffset(5, 5)
                        Sleep(NavigateTime)
                    } Else {
                        Break
                    }
                }
                If (BankEnableStorageUpgrade) {
                    Loop {
                        If (!Window.IsActive() || !Window.IsPanel()) {
                            Break
                        }
                        If (UpgradeButton.IsButtonActive()) {
                            UpgradeButton.ClickOffset(5, 5)
                            Sleep(NavigateTime)
                        } Else {
                            Break
                        }
                    }
                }
            }
            i++
        }
        Sleep(BankDepositTime * 60 * 1000)
    }
}

BankSinglePass() {
    NavigateTime := S.Get("NavigateTime")
    BankEnableStorageUpgrade := S.Get("BankEnableStorageUpgrade")
    DepositRESS := Points.Bank.DepositRESS
    UpgradeButton := Points.Bank.UpgradeStorage
    Shops.OpenBank()
    Sleep(NavigateTime + 100)
    If (!Window.IsPanel()) {
        Shops.OpenBank()
        Sleep(NavigateTime)
    }
    i := 0
    While (i < 6) {
        If (!Window.IsActive() || !Window.IsPanel()) {
            Break
        }
        ResetBankScroll()
        If (BankIsTabEnabled(i)) {
            buttonTab := BankTabCoordByInd(i)
            If (!IsOnBankTab(buttonTab)) {
                BankTravelAreaByInd(i)
                Sleep(NavigateTime)
            }
            Loop {
                If (!Window.IsActive() || !Window.IsPanel()) {
                    Break
                }
                If (DepositRESS.IsButtonActive()) {
                    DepositRESS.ClickOffset(5, 5)
                    Sleep(NavigateTime)
                } Else {
                    Break
                }
            }
            If (BankEnableStorageUpgrade) {
                Loop {
                    If (!Window.IsActive() || !Window.IsPanel()) {
                        Break
                    }
                    If (UpgradeButton.IsButtonActive()) {
                        UpgradeButton.ClickOffset(5, 5)
                        Sleep(NavigateTime)
                    } Else {
                        Break
                    }
                }
            }
        }
        i++
    }
    Travel.ClosePanelIfActive()
    Travel.ClosePanelIfActive()
}

;@region Support functions

BankTravelAreaByInd(index) {
    NavigateTime := S.Get("NavigateTime")
    Switch index {
    Case 0:
        Points.Bank.TabQA.ClickOffset()
    Case 1:
        Points.Bank.TabSR.ClickOffset()
    Case 2:
        Points.Bank.TabFF.ClickOffset()
    Case 3:
        Points.Bank.TabEB.ClickOffset()
    Case 4:
        Points.Bank.TabSN.ClickOffset()
    Case 5:
        Points.Bank.TabLG.ClickOffset()
    default:

    }
    Sleep(NavigateTime)
}

/**
 * Get bank tab cLBRButton by index
 * @param index 
 * @returns {cLBRButton} | null
 */
BankTabCoordByInd(index) {
    Switch index {
    Case 0:
        Return Points.Bank.TabQA
    Case 1:
        Return Points.Bank.TabSR
    Case 2:
        Return Points.Bank.TabFF
    Case 3:
        Return Points.Bank.TabEB
    Case 4:
        Return Points.Bank.TabSN
    Case 5:
        Return Points.Bank.TabLG
    default:
    }
}
BankIsTabEnabled(index) {
    If (index = 5 && S.Get("BankEnableLGDeposit")) {
        Return true
    }
    If (index = 4 && S.Get("BankEnableSNDeposit")) {
        Return true
    }
    If (index = 3 && S.Get("BankEnableEBDeposit")) {
        Return true
    }
    If (index = 2 && S.Get("BankEnableFFDeposit")) {
        Return true
    }
    If (index = 1 && S.Get("BankEnableSRDeposit")) {
        Return true
    }
    If (index = 0 && S.Get("BankEnableQADeposit")) {
        Return true
    }
    Return false
}

/**
 * If bank tab open button should be green
 * @param {cLBRButton} buttonTab 
 * @returns {Integer} 
 */
IsOnBankTab(buttonTab) {
    ; 82805D mouseoff green active button
    ; A8EC7F mouseover green active button (no mousedown, same as this)
    colour := buttonTab.GetColour()
    If (colour = "0x82805D" || colour = "0xA8EC7F") {
        Return true
    }
    Out.D("IsOnBankTab false: found " colour)
    Return false
}

ResetBankScroll() {
    maxIter := 20
    Deposit := Points.Bank.DepositRESS
    UpgStorage := Points.Bank.UpgradeStorage
    While (!Deposit.IsButton() && !UpgStorage.IsButton()) {
        If (!Window.IsActive() || !Window.IsPanel() || maxIter <= 1) {
            Return
        }
        Travel.ScrollResetToTop()
        maxIter--
    }
}
;@endregion

;@region EnableBanks()
EnableBanks(*) {
    UlcWindow()
    Shops.OpenBank(72)
    Buttons := [
        Points.Bank.TabLG,
        Points.Bank.TabSN,
        Points.Bank.TabEB,
        Points.Bank.TabFF,
        Points.Bank.TabSR,
        Points.Bank.TabQA
    ]
    AutoDeposit := cLBRButton(1378, 780)
    AutoRSS := cLBRButton(1378, 927)
    For (id, point IN Buttons) {
        point.ClickOffsetUntilColour(point.BankTabSelectedActiveMouseover)
        Sleep(50)
        AutoDeposit.ClickButtonActive()
        Sleep(50)
    }
    AmountToModifier(25)
    Sleep(50)
    Travel.ScrollAmountDown(1)
    Sleep(50)
    ResetModifierKeys()
    Sleep(50)
    For (id, point IN Buttons) {
        point.ClickOffsetUntilColour(point.BankTabSelectedActiveMouseover)
        Sleep(50)
        AutoRSS.ClickButtonActive()
        Sleep(50)
    }
}
;@endregion
