#Requires AutoHotkey v2.0

; TODO Travel and opening review
; TODO Add setting for standalone WW in GFSS spammer.
; TODO Review ending of gfssnoreset mode.
; TODO Add BossFastFarm.

S.AddSetting("SSFarm", "GFToKillPerCycle", 8, "int")
S.AddSetting("SSFarm", "SSToKillPerCycle", 1, "int")
S.AddSetting("SSFarm", "GFSSNoReset", false, "bool")

fFarmGFSS() {
    ResettingGF := false
    GFSSNoReset := S.Get("GFSSNoReset")
    SSToKillPerCycle := S.Get("SSToKillPerCycle")
    GFToKillPerCycle := S.Get("GFToKillPerCycle")
    Spammer.GFSSBossStart()
    Loop {
        If (!Window.IsActive()) {
            Break ; Kill if no game
        }
        GFKills := 0
        SSKills := 0
        IsInGF := true
        IsInSS := false
        Out.I("GFSSFarm: Going to Green Flame")
        GoToGF()
        IsPrevTimerLong := IsBossTimerLong()
        Travel.ClosePanelIfActive()

        While (SSToKillPerCycle != SSKills) {
            If (!Window.IsActive()) {
                Break ; Kill if no game
            }
            While (GFToKillPerCycle != GFKills) {
                If (!Window.IsActive()) {
                    Break ; Kill if no game
                }
                If (!IsInGF) {
                    Out.I("GFSSFarm: Going to Green Flame")
                    GoToGF()
                    IsPrevTimerLong := IsBossTimerLong()
                    Travel.ClosePanelIfActive()
                    IsInGF := true
                    IsInSS := false
                }
                IsTimerLong := IsBossTimerLong()
                ; if state of timer has changed and is now off, we killed
                If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                    ; If the timer is longer, killed too quick to get a gap
                    GFKills++
                    Out.I("GFKill marked")
                }
                /* Out.D("GFKill timerlast " TimerLastCheckStatus " timer
                cur " TimerCurrentState " waslong " IsPrevTimerLong " islong "
                IsTimerLong)
                */
                IsPrevTimerLong := IsTimerLong
                ; If boss killed us at gf assume we're weak and reset gf
                ; If user set gf kills too high it'll hit this
                If (Travel.HomeGarden.IsAreaGarden()) {
                    If (GFSSNoReset) {
                        Break
                    }
                    Out.I("GFSSFarm: User killed by GF boss, resetting.")
                    ToolTip("Killed by GF boss, resetting", Window.W / 2 -
                        Window.RelW(70), Window.H / 2)
                    SetTimer(ToolTip, -200)
                    ResetGF()
                    ResettingGF := true
                    Break
                }
                ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills, Window
                    .W / 2 - Window.RelW(70), Window.H / 2)
                SetTimer(ToolTip, -250)
            }
            If (!IsInSS) {
                Out.I("GFSSFarm: Going to Soulseeker")
                GoToSS()
                Sleep(101)
                Travel.ClosePanelIfActive()
                IsInSS := true
                IsInGF := false
            }
            IsTimerLong := IsBossTimerLong()
            ; if state of timer has changed and is now off, we killed
            If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                ; If the timer is longer, killed too quick to get a gap
                SSKills++
                GFKills := 0
                Out.I("SSKill marked")
            }
            /* Out.D("SSKill timerlast " TimerLastCheckStatus " timer cur "
                    TimerCurrentState " waslong " IsPrevTimerLong
                    " islong " IsTimerLong)
            */
            IsPrevTimerLong := IsTimerLong
            ; if boss killed us exit this loop, then let the master loop
            ; reset
            If (Travel.HomeGarden.IsAreaGarden() && !ResettingGF) {
                If (GFSSNoReset) {
                    Break
                }
                Out.I("GFSSFarm: Killed by SS boss, resetting.")
                ToolTip("Killed by boss, resetting", Window.W / 2 - Window.RelW(
                    100), Window.H / 2)
                SetTimer(ToolTip, -1000)
                Break
            }
            ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills, Window.W /
                2 - Window.RelW(70), Window.H / 2)
            SetTimer(ToolTip, -250)

        }
        ; if we're done looping or got killed reset ss
        If (!ResettingGF && !GFSSNoReset) {
            Out.I("GFSSFarm: Have met SS Kill count, resetting.")
            ToolTip("Resetting at: GF Kills " . GFKills . " SS Kills " .
                SSKills, Window.W / 2 - Window.RelW(100), Window.H / 2)
            SetTimer(ToolTip, -5000)
            Sleep(250)
            ResetSS()
        }
        ResettingGF := false
    }
}
