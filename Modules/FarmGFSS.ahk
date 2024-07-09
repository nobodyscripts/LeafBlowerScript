#Requires AutoHotkey v2.0

Global GFSSNoReset := 0
Global GFToKillPerCycle := 1
Global SSToKillPerCycle := 1

fFarmGFSS() {
    ResettingGF := false
    Global GFSSNoReset
    GFSSBossSpammerStart()
    Loop {
        If (!IsWindowActive()) {
            Break ; Kill if no game
        }
        GFKills := 0
        SSKills := 0
        IsInGF := true
        IsInSS := false
        Log("GFSSFarm: Going to Green Flame")
        GoToGF()
        IsPrevTimerLong := IsBossTimerLong()
        Travel.ClosePanelIfActive()

        While (SSToKillPerCycle != SSKills) {
            If (!IsWindowActive()) {
                Break ; Kill if no game
            }
            While (GFToKillPerCycle != GFKills) {
                If (!IsWindowActive()) {
                    Break ; Kill if no game
                }
                If (!IsInGF) {
                    Log("GFSSFarm: Going to Green Flame")
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
                    Log("GFKill marked")
                }
                /* DebugLog("GFKill timerlast " TimerLastCheckStatus " timer
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
                    Log("GFSSFarm: User killed by GF boss, resetting.")
                    ToolTip("Killed by GF boss, resetting", W / 2 -
                        WinRelPosLargeW(70), H / 2)
                    SetTimer(ToolTip, -200)
                    ResetGF()
                    ResettingGF := true
                    Break
                }
                ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills, W / 2 -
                    WinRelPosLargeW(70), H / 2)
                SetTimer(ToolTip, -250)
            }
            If (!IsInSS) {
                Log("GFSSFarm: Going to Soulseeker")
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
                Log("SSKill marked")
            }
            /* DebugLog("SSKill timerlast " TimerLastCheckStatus " timer cur "
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
                Log("GFSSFarm: Killed by SS boss, resetting.")
                ToolTip("Killed by boss, resetting", W / 2 - WinRelPosLargeW(
                    100), H / 2)
                SetTimer(ToolTip, -1000)
                Break
            }
            ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills, W / 2 -
                WinRelPosLargeW(70), H / 2)
            SetTimer(ToolTip, -250)

        }
        ; if we're done looping or got killed reset ss
        If (!ResettingGF && !GFSSNoReset) {
            Log("GFSSFarm: Have met SS Kill count, resetting.")
            ToolTip("Resetting at: GF Kills " . GFKills . " SS Kills " .
                SSKills, W / 2 - WinRelPosLargeW(100), H / 2)
            SetTimer(ToolTip, -5000)
            Sleep(250)
            ResetSS()
        }
        ResettingGF := false
    }
}