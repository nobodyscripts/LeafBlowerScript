#Requires AutoHotkey v2.0

#Include ../Lib/cPoints.ahk

global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankEnableStorageUpgrade := true
global BankRunsSpammer := true
global BankDepositTime := 5
global NavigateTime := 150

fBankAutoDeposit() {
    global BankDepositTime
    DepositRESS := Points.Bank.DepositRESS
    UpgradeButton := Points.Bank.UpgradeStorage
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    if (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    if (BankRunsSpammer) {
        NormalBossSpammerStart()
    }
    GameKeys.OpenBank()
    ToolTip("Bank Maintainer Active", W / 2 - WinRelPosLargeW(100), H / 2, 4)
    loop {
        if (!IsWindowActive()) {
            break
        }
        i := 0
        while (i < 6) {
            if (!IsWindowActive()) {
                break
            }
            ResetBankScroll()
            if (BankIsTabEnabled(i)) {
                buttonTab := BankTabCoordByInd(i)
                if (!IsOnBankTab(buttonTab)) {
                    BankTravelAreaByInd(i)
                    Sleep(NavigateTime)
                }
                loop {
                    if (!IsWindowActive()) {
                        break
                    }
                    if (DepositRESS.IsButtonActive()) {
                        DepositRESS.ClickOffset(5, 5)
                        Sleep(NavigateTime)
                    } else {
                        break
                    }
                }
                if (BankEnableStorageUpgrade) {
                    loop {
                        if (!IsWindowActive()) {
                            break
                        }
                        if (UpgradeButton.IsButtonActive()) {
                            UpgradeButton.ClickOffset(5, 5)
                            Sleep(NavigateTime)
                        } else {
                            break
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
    if (IsPanelActive()) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }
    GameKeys.OpenBank()
    Sleep(NavigateTime + 100)
    if (!IsPanelActive()) {
        GameKeys.OpenBank()
        Sleep(NavigateTime)
    }
    i := 0
    while (i < 6) {
        if (!IsWindowActive()) {
            break
        }
        ResetBankScroll()
        if (BankIsTabEnabled(i)) {
            buttonTab := BankTabCoordByInd(i)
            if (!IsOnBankTab(buttonTab)) {
                BankTravelAreaByInd(i)
                Sleep(NavigateTime)
            }
            loop {
                if (!IsWindowActive()) {
                    break
                }
                if (DepositRESS.IsButtonActive()) {
                    DepositRESS.ClickOffset(5, 5)
                    Sleep(NavigateTime)
                } else {
                    break
                }
            }
            if (BankEnableStorageUpgrade) {
                loop {
                    if (!IsWindowActive()) {
                        break
                    }
                    if (UpgradeButton.IsButtonActive()) {
                        UpgradeButton.ClickOffset(5, 5)
                        Sleep(NavigateTime)
                    } else {
                        break
                    }
                }
            }
        }
        i++
    }
    if (IsPanelActive()) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }
}

BankTravelAreaByInd(index) {
    switch index {
        case 0:
            Points.Bank.TabQA.Click()
        case 1:
            Points.Bank.TabSR.Click()
        case 2:
            Points.Bank.TabFF.Click()
        case 3:
            Points.Bank.TabEB.Click()
        case 4:
            Points.Bank.TabSN.Click()
        case 5:
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
    switch index {
        case 0:
            return Points.Bank.TabQA
        case 1:
            return Points.Bank.TabSR
        case 2:
            return Points.Bank.TabFF
        case 3:
            return Points.Bank.TabEB
        case 4:
            return Points.Bank.TabSN
        case 5:
            return Points.Bank.TabLG
        default:
    }
}
BankIsTabEnabled(index) {
    if (index = 5 && BankEnableLGDeposit) {
        return true
    }
    if (index = 4 && BankEnableSNDeposit) {
        return true
    }
    if (index = 3 && BankEnableEBDeposit) {
        return true
    }
    if (index = 2 && BankEnableFFDeposit) {
        return true
    }
    if (index = 1 && BankEnableSRDeposit) {
        return true
    }
    if (index = 0 && BankEnableQADeposit) {
        return true
    }
    return false
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
    if (colour = "0x82805D" || colour = "0xA8EC7F") {
        return true
    }
    DebugLog("IsOnBankTab false: found " colour)
    return false
}

ResetBankScroll() {
    maxIter := 20
    Deposit := Points.Bank.DepositRESS
    UpgStorage := Points.Bank.UpgradeStorage
    while (!Deposit.IsButton() && !UpgStorage.IsButton()) {
        if (!IsWindowActive() || !IsPanelActive() || maxIter <= 1) {
            return
        }
        ScrollAmountUp(1)
        maxIter--
    }
}