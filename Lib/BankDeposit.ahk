#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk

global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankRunsSpammer := true
global BankCycleTime := 10
global NavigateTime := 150

fBankAutoDeposit() {
    if (BankRunsSpammer) {
        SpamViolins()
    }
    OpenBank()
    ToolTip("Bank Maintainer Active", W / 2 - WinRelPosLargeW(100), H / 2, 4)
    loop {
        i := 0
        while (i < 6) {
            if (BankIsTabEnabled(i)) {
                buttonTab := BankTabCoordByInd(i)
                if (!IsOnBankTab(buttonTab)) {
                    BankTravelAreaByInd(i)
                    Sleep(NavigateTime)
                }
                loop {
                    if (cBankDepositRESS().IsCoordButtonActive()) {
                        cBankDepositRESS().ClickOffset()
                        Sleep(NavigateTime)
                    } else {
                        Log("Loop broken")
                        break
                    }
                }
            }
            i++
        }
        Sleep(BankCycleTime * 1000)
    }

}

BankTravelAreaByInd(index) {
    switch index {
        case 0:
            cBankTabQA().Click()
        case 1:
            cBankTabSR().Click()
        case 2:
            cBankTabFF().Click()
        case 3:
            cBankTabEB().Click()
        case 4:
            cBankTabSN().Click()
        case 5:
            cBankTabLG().Click()
        default:

    }
    Sleep(NavigateTime)
}

BankTabCoordByInd(index) {
    switch index {
        case 0:
            return cBankTabQA()
        case 1:
            return cBankTabSR()
        case 2:
            return cBankTabFF()
        case 3:
            return cBankTabEB()
        case 4:
            return cBankTabSN()
        case 5:
            return cBankTabLG()
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

IsOnBankTab(buttonTab) {
    ; 82805D mouseoff green active button
    ; A8EC7F mouseover green active button (no mousedown, same as this)
    try {
        colour := PixelGetColor(buttonTab.x, buttonTab.y)
    } catch as exc {
        Log("IsOnBankTab: Check failed with error - "
            exc.Message)
        MsgBox("Could not conduct the search due to the following error:`n"
            exc.Message)
    }
    if (colour = "0x82805D" || colour = "0xA8EC7F") {
        return true
    }
    return false
}