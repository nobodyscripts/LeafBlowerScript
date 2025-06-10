#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\Spammers.ahk

S.AddSetting("Leafton", "LeaftonCraftEnabled", true, "bool")
S.AddSetting("Leafton", "LeaftonSpamsWind", true, "bool")
S.AddSetting("Leafton", "LeaftonBanksEnabled", true, "bool")
S.AddSetting("Leafton", "LeaftonRunOnceEnabled", false, "bool")
S.AddSetting("Leafton", "LeaftonEnableBrewing", false, "bool")
S.AddSetting("Leafton", "LeaftonBrewCycleTime", 10, "int")
S.AddSetting("Leafton", "LeaftonBrewCutOffTime", 30, "int")

fLeaftonTaxi() {
    NavigateTime := S.Get("NavigateTime")
    LeaftonBanksEnabled := S.Get("LeaftonBanksEnabled")
    LeaftonCraftEnabled := S.Get("LeaftonCraftEnabled")
    LeaftonSpamsWind := S.Get("LeaftonSpamsWind")
    LeaftonRunOnceEnabled := S.Get("LeaftonRunOnceEnabled")
    LeaftonEnableBrewing := S.Get("LeaftonEnableBrewing")
    LeaftonBrewCycleTime := S.Get("LeaftonBrewCycleTime")
    LeaftonBrewCutOffTime := S.Get("LeaftonBrewCutOffTime")
    BankDepositTime := S.Get("BankDepositTime")
    
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    GoToAnteLeafton()
    starttime := A_Now
    If (S.Get("LeaftonSpamsWind")) {
        Spammer.LeaftonStart()
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

    Shops.OpenPets()
    Sleep(NavigateTime)
    If (LeaftonBanksEnabled) {
        BankSinglePass()
    }
    Loop {
        ;@region Banks
        If (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
        LeaftonBanksEnabled) {
            Out.I("Leafton: Bank Maintainer starting.")
            ToolTip("Leafton Bank Maintainer Active", Window.W / 2, Window.RelH(
                200), 4)
            BankSinglePass()
            ToolTip(, , , 4)
            starttime := A_Now
        }
        ;@endregion

        ;@region Brew
        If (Window.IsActive() && LeaftonEnableBrewing && !BrewCycleTimer.Running
        ) {
            Out.I("Leafton: Brewing")
            If (Shops.OpenAlchemyGeneral()) {
                Out.D("Traveled brew")
                BrewCutOffTimer.CoolDownS(LeaftonBrewCutOffTime, &
                    BrewCutOffRunning)
                While (BrewCutOffRunning && Shops.IsAlchGeneralTab()) {
                    Out.D("Brewing")
                    If (!SpamBrewButtons()) {
                        Out.D("Brew ending")
                        Break
                    }
                }
                BrewCycleTimer.CoolDownS(LeaftonBrewCycleTime, &
                    BrewCycleRunning)
                Sleep(NavigateTime)
                Travel.ClosePanelIfActive()
            } Else {
                Out.I("Leafton Brew: Travel to Alch general tab failed after 4" .
                    " attempts.")
            }
        }
        ;@endregion
        If (!Window.IsActive() || StopRunning) {
            Out.I("No window or stop called.")
            Break
        }
        ToolTip("Leafton Active", Window.W / 2, Window.RelH(200), 4)
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
                If (!Window.IsActive() || DateDiff(A_Now, starttime, "Seconds") >=
                BankDepositTime * 60) {
                    Break
                }
                If (LeaftonCraftEnabled && !Window.IsPanel()) {
                    Sleep(NavigateTime)
                    Shops.OpenCrafting()
                    Sleep(NavigateTime)
                    Points.Crafting.Tab1.ClickOffset()
                    Sleep(NavigateTime)
                    If (!Window.IsPanel()) {
                        Shops.OpenCrafting()
                        Sleep(NavigateTime)
                        Points.Crafting.Tab1.ClickOffset()
                        Sleep(NavigateTime)
                    }
                }
                If (LeaftonCraftEnabled && craftStopCoord.IsButtonActive()) {
                    craftStopCoord.ClickOffset(, , 17)
                }
                ; If button isn't there allow cycle to brew
                If (LeaftonCraftEnabled && craftStopCoord.IsBackground() && !
                BrewCycleTimer.Running) {
                    Break
                }
            }
            If (LeaftonCraftEnabled) {
                Travel.ClosePanelIfActive()
            }
        }
        ToolTip(, , , 4)
    }
    Spammer.KillLeafton()
    If (StopRunning) {
        Reload()
    }
}

LeaftonTaxiSinglePassStart() {
    NavigateTime := S.Get("NavigateTime")
    LeaftonSpamsWind := S.Get("LeaftonSpamsWind")
    GoToAnteLeafton()
    If (LeaftonSpamsWind) {
        Spammer.LeaftonStart()
    }
    Shops.OpenPets()
    Sleep(NavigateTime)
}

LeaftonTaxiSinglePassEnd() {
    Spammer.KillLeafton()
}

LeaftonTaxiSinglePass() {
    NavigateTime := S.Get("NavigateTime")
    centerCoord := Points.Leafton.Center
    startCoord := Points.Leafton.Start
    If (!Window.IsActive()) {
        Return false
    }

    If (IsAreaBlack() && IsBossTimerActive()) {
        Travel.ClosePanelIfActive()
        If (!startCoord.IsBackground()) {
            Out.V("Center Click")
            centerCoord.Click()
        }
        Sleep(NavigateTime)
        If (startCoord.IsButtonActive()) {
            Out.I("Starting Leafton Pit")
            startCoord.Click()
            Sleep(NavigateTime)
        }
        Travel.ClosePanelIfActive()
    }
}
