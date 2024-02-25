#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include Spammers.ahk

global LeaftonCraftEnabled := true
global LeaftonSpamsWind := true
global LeaftonBanksEnabled := true
global LeaftonRunOnceEnabled := false
global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankDepositTime := 5
global NavigateTime := 150
global WindSpammerPID := 0

fLeaftonTaxi() {
    starttime := A_Now
    if (LeaftonSpamsWind) {
        SpamJustWind()
    }
    centerCoord := cLeaftonCenter()
    startCoord := cLeaftonStart()
    craftStopCoord := cCraftingStop()
    HasRun := false
    StopRunning := false
    OpenPets()
    Sleep(NavigateTime)
    if (LeaftonBanksEnabled) {
        BankLeaftonSinglePass()
    }
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    loop {
        if (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            LeaftonBanksEnabled) {
                Log("Leafton: Bank Maintainer starting.")
                BankLeaftonSinglePass()
                starttime := A_Now
        }
        if (!IsWindowActive() || StopRunning) {
            break
        }
        ToolTip("Leafton Active", W / 2, WinRelPosLargeH(200), 4)
        if (IsAreaBlack() && IsBossTimerActive()) {
            if (!startCoord.IsBackground()) {
                centerCoord.Click()
            }
            Sleep(NavigateTime)
            if (startCoord.IsButtonActive()) {
                startCoord.Click()
            }
            HasRun := true
        } else {
            if (LeaftonRunOnceEnabled && HasRun) {
                StopRunning := true
            }
            if (LeaftonCraftEnabled) {
                Sleep(NavigateTime)
                OpenCrafting()
                Sleep(NavigateTime)
                if (!IsPanelActive()) {
                    OpenCrafting()
                    Sleep(NavigateTime)
                }
            }
            while (!IsBossTimerActive()) {
                if (!IsWindowActive() ||
                    DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60) {
                        break
                }
                if (LeaftonCraftEnabled && craftStopCoord.IsButtonActive()) {
                    craftStopCoord.ClickOffset(, , 17)
                }
            }
            if (LeaftonCraftEnabled && IsPanelActive()) {
                ClosePanel()
                Sleep(NavigateTime)
            }
        }
        ToolTip(, , , 4)
    }
    KillWindSpammer()
    if (StopRunning) {
        cReload()
    }
}

BankLeaftonSinglePass() {
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    OpenBank()
    ToolTip("Leafton Bank Maintainer Active", W / 2, WinRelPosLargeH(200), 4)
    i := 0
    while (i < 6) {
        if (!IsWindowActive()) {
            break
        }
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
                if (cBankDepositRESS().IsButtonActive()) {
                    cBankDepositRESS().ClickOffset()
                    Sleep(NavigateTime)
                } else {
                    break
                }
            }
        }
        i++
    }
    ToolTip(, , , 4)
}