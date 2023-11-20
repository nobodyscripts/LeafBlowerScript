#Requires AutoHotkey v2.0

global WWSpammerPID := 0
global WWFarmActive
WWFarmActive := false

fFarmWWBoss() {
    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    Log("WWFarm: Equipped Quark Loadout")
    GotoResetSS()
    SpamWWArtifacts()
    loop {
        if (!IsWindowActive()) {
            Log("WWFarm: Exiting as no game.")
            reload() ; Kill if no game
            return
        }
        ToolTip("WW Boss Mode",
            W / 2 - WinRelPosLargeW(100),
            H / 2 - WinRelPosLargeH(50), 1)
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount++
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("WWFarm: User killed.")
            ToolTip("Killed by boss", W / 2, H / 2 +
                WinRelPosLargeH(50), 2)
            SetTimer(ToolTip.Bind(, , , 2), -3000)
            break
        }
        if (IsButtonActive(WinRelPosW(412), WinRelPosH(244))) {
            fSlowClick(517, 245, NavigateTime) ; Reset SpectralSeeker
        }
        ToolTip("WW Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(75),
            H / 2 + WinRelPosLargeH(20), 3)
        TimerLastCheckStatus := TimerCurrentState
    }
    SetTimer(ToolTip.Bind(, , , 1), -1)
    SetTimer(ToolTip.Bind(, , , 3), -1)
    KillWWSpammer()
}

SpamWWArtifacts() {
    global WWSpammerPID
    if (IsWindowActive() && IsBossTimerActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\WWBoss.ahk"',
            , , &OutPid)
        WWSpammerPID := OutPid
    }
}

KillWWSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\WWBoss.ahk - AutoHotkey v2.0.4
    if (WWSpammerPID && ProcessExist(WWSpammerPID)) {
        ProcessClose(WWSpammerPID)
        Log("Closed WWBoss.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\WWBoss.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\WWBoss.ahk ahk_class AutoHotkey")
            Log("Closed WWBoss.ahk using filename.")
        }
        /* if (WinExist("WWBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")) {
            WinClose("WWBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")
        } */
    }
}