#Requires AutoHotkey v2.0

#Include ../Lib/cPoints.ahk
#Include ../Lib/Spammers.ahk

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
    global BankDepositTime
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    if (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    GoToAnteLeafton()
    starttime := A_Now
    if (LeaftonSpamsWind) {
        LeaftonSpammerStart()
    }
    centerCoord := Points.Leafton.Center
    startCoord := Points.Leafton.Start
    craftStopCoord := Points.Crafting.Stop
    HasRun := false
    StopRunning := false
    Travel.OpenPets()
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
            Log("No window or stop called.")
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
            if (IsBossTimerActive() && IsScrollAblePanel()) {
                ; We're in bank screen still so close it
                Travel.ClosePanelIfActive()
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
                    Travel.OpenCrafting()
                    Sleep(NavigateTime)
                    Points.Crafting.Tab1.ClickOffset()
                    Sleep(NavigateTime)
                    if (!IsPanelActive()) {
                        Travel.OpenCrafting()
                        Sleep(NavigateTime)
                        Points.Crafting.Tab1.ClickOffset()
                        Sleep(NavigateTime)
                    }
                }
                if (LeaftonCraftEnabled && craftStopCoord.IsButtonActive()) {
                    craftStopCoord.ClickOffset(, , 17)
                }
            }
            if (LeaftonCraftEnabled) {
                Travel.ClosePanelIfActive()
            }
        }
        ToolTip(, , , 4)
    }
    KillLeaftonSpammer()
    if (StopRunning) {
        cReload()
    }
}

LeaftonTaxiSinglePassStart() {
    GoToAnteLeafton()
    if (LeaftonSpamsWind) {
        LeaftonSpammerStart()
    }
    Travel.OpenPets()
    Sleep(NavigateTime)
}

LeaftonTaxiSinglePassEnd() {
    KillLeaftonSpammer()
}

LeaftonTaxiSinglePass() {
    centerCoord := Points.Leafton.Center
    startCoord := Points.Leafton.Start
    if (!IsWindowActive()) {
        return false
    }

    if (IsAreaBlack() && IsBossTimerActive()) {
        Travel.ClosePanelIfActive()
        if (!startCoord.IsBackground()) {
            centerCoord.Click()
        }
        Sleep(NavigateTime)
        if (startCoord.IsButtonActive()) {
            Log("Starting Leafton Pit")
            startCoord.Click()
            Sleep(NavigateTime)
        }
    }
}