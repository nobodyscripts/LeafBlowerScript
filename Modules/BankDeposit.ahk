#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk

Global BankEnableLGDeposit := true
Global BankEnableSNDeposit := true
Global BankEnableEBDeposit := true
Global BankEnableFFDeposit := true
Global BankEnableSRDeposit := true
Global BankEnableQADeposit := true
Global BankEnableStorageUpgrade := true
Global BankRunsSpammer := true
Global BankDepositTime := 5
Global NavigateTime := 150

fBankAutoDeposit() {
    Global BankDepositTime
    DepositRESS := Points.Bank.DepositRESS
    UpgradeButton := Points.Bank.UpgradeStorage
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    If (BankRunsSpammer) {
        NormalBossSpammerStart()
    }
    Travel.OpenBank()
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
    DepositRESS := Points.Bank.DepositRESS
    UpgradeButton := Points.Bank.UpgradeStorage
    Travel.OpenBank()
    Sleep(NavigateTime + 100)
    If (!Window.IsPanel()) {
        Travel.OpenBank()
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
    Switch index {
        Case 0:
            Points.Bank.TabQA.Click()
        Case 1:
            Points.Bank.TabSR.Click()
        Case 2:
            Points.Bank.TabFF.Click()
        Case 3:
            Points.Bank.TabEB.Click()
        Case 4:
            Points.Bank.TabSN.Click()
        Case 5:
            Points.Bank.TabLG.Click()
        default:

    }
    Sleep(NavigateTime)
}

/**
 * Get bank tab cPoint by index
 * @param index 
 * @returns {cPoint} | null
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
    If (index = 5 && BankEnableLGDeposit) {
        Return true
    }
    If (index = 4 && BankEnableSNDeposit) {
        Return true
    }
    If (index = 3 && BankEnableEBDeposit) {
        Return true
    }
    If (index = 2 && BankEnableFFDeposit) {
        Return true
    }
    If (index = 1 && BankEnableSRDeposit) {
        Return true
    }
    If (index = 0 && BankEnableQADeposit) {
        Return true
    }
    Return false
}

/**
 * If bank tab open button should be green
 * @param {cPoint} buttonTab 
 * @returns {Integer} 
 */
IsOnBankTab(buttonTab) {
    ; 82805D mouseoff green active button
    ; A8EC7F mouseover green active button (no mousedown, same as this)
    colour := buttonTab.GetColour()
    If (colour = "0x82805D" || colour = "0xA8EC7F") {
        Return true
    }
    DebugLog("IsOnBankTab false: found " colour)
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
        Travel.ScrollAmountUp(1)
        maxIter--
    }
}
;@endregion
