#Requires AutoHotkey v2.0

fFarmGFSS() {
    ResettingGF := false
    global GFSSNoReset
    SpamViolins()
    loop {
        if (!IsWindowActive()) {
            break ; Kill if no game
        }
        GFKills := 0
        SSKills := 0
        IsInGF := true
        IsInSS := false
        Log("GFSSFarm: Going to Green Flame")
        GoToGF()
        if (IsPanelActive()) {
            ClosePanel()
        }
        TimerLastCheckStatus := IsBossTimerActive()

        while (SSToKillPerCycle != SSKills) {
            if (!IsWindowActive()) {
                break ; Kill if no game
            }
            while (GFToKillPerCycle != GFKills) {
                if (!IsWindowActive()) {
                    break ; Kill if no game
                }
                if (!IsInGF) {
                    Log("GFSSFarm: Going to Green Flame")
                    GoToGF()
                    if (IsPanelActive()) {
                        ClosePanel()
                    }
                    IsInGF := true
                    IsInSS := false
                }
                TimerCurrentState := IsBossTimerActive()
                ; if state of timer has changed and is now off, we killed
                if (TimerLastCheckStatus != TimerCurrentState &&
                    TimerCurrentState) {
                        GFKills++
                }
                ; If boss killed us at gf assume we're weak and reset gf
                ; If user set gf kills too high it'll hit this
                if (IsAreaResetToGarden()) {
                    if (GFSSNoReset) {
                        break
                    }
                    Log("GFSSFarm: User killed by GF boss, resetting.")
                    ToolTip("Killed by GF boss, resetting",
                        W / 2 - WinRelPosLargeW(70),
                        H / 2)
                    SetTimer(ToolTip, -200)
                    ResetGF()
                    ResettingGF := true
                    break
                }
                ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                    W / 2 - WinRelPosLargeW(70),
                    H / 2)
                SetTimer(ToolTip, -250)
                TimerLastCheckStatus := TimerCurrentState
            }
            if (!IsInSS) {
                Log("GFSSFarm: Going to Soulseeker")
                GoToSS()
                Sleep(101)
                if (IsPanelActive()) {
                    ClosePanel()
                }
                IsInSS := true
                IsInGF := false
            }
            TimerCurrentState := IsBossTimerActive()
            ; if state of timer has changed and is now off, we killed
            if (TimerLastCheckStatus != TimerCurrentState &&
                TimerCurrentState) {
                    SSKills++
                    GFKills := 0
            }
            ; if boss killed us exit this loop, then let the master loop
            ; reset
            if (IsAreaResetToGarden() && !ResettingGF) {
                if (GFSSNoReset) {
                    break
                }
                Log("GFSSFarm: Killed by SS boss, resetting.")
                ToolTip("Killed by boss, resetting",
                    W / 2 - WinRelPosLargeW(100),
                    H / 2)
                SetTimer(ToolTip, -1000)
                break
            }
            ToolTip(" GF Kills " . GFKills . " SS Kills " . SSKills,
                W / 2 - WinRelPosLargeW(70),
                H / 2)
            SetTimer(ToolTip, -250)
            TimerLastCheckStatus := TimerCurrentState

        }
        ; if we're done looping or got killed reset ss
        if (!ResettingGF && !GFSSNoReset) {
            Log("GFSSFarm: Have met SS Kill count, resetting.")
            ToolTip("Resetting at: GF Kills " . GFKills .
                " SS Kills " . SSKills,
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            SetTimer(ToolTip, -5000)
            sleep(250)
            ResetSS()
        }
        ResettingGF := false
    }
}