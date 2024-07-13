#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\Spammers.ahk

Global LeaftonCraftEnabled := true
Global LeaftonSpamsWind := true
Global LeaftonBanksEnabled := true
Global LeaftonRunOnceEnabled := false
Global BankEnableLGDeposit := true
Global BankEnableSNDeposit := true
Global BankEnableEBDeposit := true
Global BankEnableFFDeposit := true
Global BankEnableSRDeposit := true
Global BankEnableQADeposit := true
Global BankDepositTime := 5
Global NavigateTime := 150
Global LeaftonEnableBrewing := true
Global LeaftonBrewCycleTime := 10
Global LeaftonBrewCutOffTime := 30

fLeaftonTaxi() {
    Global BankDepositTime
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    GoToAnteLeafton()
    starttime := A_Now
    If (LeaftonSpamsWind) {
        LeaftonSpammerStart()
    }
    centerCoord := Points.Leafton.Center
    startCoord := Points.Leafton.Start
    craftStopCoord := Points.Crafting.Stop
    HasRun := false
    StopRunning := false
    /** @type {Timer} */
    BrewCycleTimer := Timer()
    /** @type {Timer} */
    BrewCutOffTimer := Timer()

    Travel.OpenPets()
    Sleep(NavigateTime)
    If (LeaftonBanksEnabled) {
        BankSinglePass()
    }
    Loop {
        ;@region Banks
        If (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            LeaftonBanksEnabled) {
            Log("Leafton: Bank Maintainer starting.")
            ToolTip("Leafton Bank Maintainer Active", W / 2, WinRelPosLargeH(
                200), 4)
            BankSinglePass()
            ToolTip(, , , 4)
            starttime := A_Now
        }
        ;@endregion

        ;@region Brew
        If (IsWindowActive() && LeaftonEnableBrewing && !BrewCycleTimer.Running) {
            Log("Leafton: Brewing")
            If (Travel.OpenAlchemyGeneral()) {
                DebugLog("Traveled brew")
                BrewCutOffTimer.CoolDownS(LeaftonBrewCutOffTime, &
                    BrewCutOffRunning)
                While (BrewCutOffRunning && Travel.IsAlchGeneralTab()) {
                    DebugLog("Brewing")
                    If (!SpamBrewButtons()) {
                        DebugLog("Brew ending")
                        Break
                    }
                }
                BrewCycleTimer.CoolDownS(LeaftonBrewCycleTime, &BrewCycleRunning)
                Sleep(NavigateTime)
                Travel.ClosePanelIfActive()
            } Else {
                Log("Leafton Brew: Travel to Alch general tab failed after 4" .
                    " attempts.")
            }
        }
        ;@endregion
        If (!IsWindowActive() || StopRunning) {
            Log("No window or stop called.")
            Break
        }
        ToolTip("Leafton Active", W / 2, WinRelPosLargeH(200), 4)
        If (IsAreaBlack() && IsBossTimerActive()) {
            If (!startCoord.IsBackground()) {
                centerCoord.Click()
            }
            Sleep(NavigateTime)
            If (startCoord.IsButtonActive()) {
                startCoord.Click()
            }
            If (IsBossTimerActive() && IsScrollAblePanel()) {
                ; We're in bank screen still so close it
                Travel.ClosePanelIfActive()
            }
            HasRun := true
        } Else {
            If (LeaftonRunOnceEnabled && HasRun) {
                StopRunning := true
            }
            While (!IsBossTimerActive()) {
                If (!IsWindowActive() || DateDiff(A_Now, starttime, "Seconds") >=
                    BankDepositTime * 60) {
                    Break
                }
                If (LeaftonCraftEnabled && !IsPanelActive()) {
                    Sleep(NavigateTime)
                    Travel.OpenCrafting()
                    Sleep(NavigateTime)
                    Points.Crafting.Tab1.ClickOffset()
                    Sleep(NavigateTime)
                    If (!IsPanelActive()) {
                        Travel.OpenCrafting()
                        Sleep(NavigateTime)
                        Points.Crafting.Tab1.ClickOffset()
                        Sleep(NavigateTime)
                    }
                }
                If (LeaftonCraftEnabled && craftStopCoord.IsButtonActive()) {
                    craftStopCoord.ClickOffset(, , 17)
                }
                ; If button isn't there allow cycle to brew
                if (LeaftonCraftEnabled && craftStopCoord.IsBackground() && !BrewCycleTimer.Running) {
                    break
                }
            }
            If (LeaftonCraftEnabled) {
                Travel.ClosePanelIfActive()
            }
        }
        ToolTip(, , , 4)
    }
    KillLeaftonSpammer()
    If (StopRunning) {
        cReload()
    }
}

LeaftonTaxiSinglePassStart() {
    GoToAnteLeafton()
    If (LeaftonSpamsWind) {
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
    If (!IsWindowActive()) {
        Return false
    }

    If (IsAreaBlack() && IsBossTimerActive()) {
        Travel.ClosePanelIfActive()
        If (!startCoord.IsBackground()) {
            VerboseLog("Center Click")
            centerCoord.Click()
        }
        Sleep(NavigateTime)
        If (startCoord.IsButtonActive()) {
            Log("Starting Leafton Pit")
            startCoord.Click()
            Sleep(NavigateTime)
        }
        Travel.ClosePanelIfActive()
    }
}