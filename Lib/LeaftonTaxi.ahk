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
        BankSinglePass()
    }
    loop {
        if (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            LeaftonBanksEnabled) {
                Log("Leafton: Bank Maintainer starting.")
                ToolTip("Leafton Bank Maintainer Active", W / 2,
                    WinRelPosLargeH(200), 4)
                BankSinglePass()
                ToolTip(, , , 4)
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
            if (IsBossTimerActive() && IsPanelActive() && IsScrollAblePanel()) {
                ; We're in bank screen still so close it
                ClosePanel()
            }
            HasRun := true
        } else {
            if (LeaftonRunOnceEnabled && HasRun) {
                StopRunning := true
            }
            while (!IsBossTimerActive()) {
                if (!IsWindowActive() ||
                    DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60) {
                        break
                }
                if (LeaftonCraftEnabled && !IsPanelActive()) {
                    Sleep(NavigateTime)
                    OpenCrafting()
                    Sleep(NavigateTime)
                    if (!IsPanelActive()) {
                        OpenCrafting()
                        Sleep(NavigateTime)
                    }
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
