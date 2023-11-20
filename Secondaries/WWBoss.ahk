#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 8
#SingleInstance Force
#Include '../Lib/ScriptSettings.ahk'
#Include '../Lib/Functions.ahk'
#Include '../Lib/SettingsCheck.ahk'
#Include '../Lib/Navigate.ahk'
#Include '../Hotkeys.ahk'

global X, Y, W, H
global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer2)

Log("Secondary: WW Boss Started")

InitGameWindow()

fWWBoss()

fWWBoss() {
    if (IsWindowActive() && IsBossTimerActive()) {
        SetTimer(UseWings2, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        TriggerWobblyWings()
    }
    loop {
        if (!IsWindowActive()) {
            Log("WWBoss: Exiting as no game.")
            return
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("WWBoss: User killed. Aborted.")
            return
        }
        if (IsWindowActive() && IsBossTimerActive()) {
            TriggerViolin()
            Sleep(ArtifactSleepAmount)
        }
        if (IsWindowActive() && !IsBossTimerActive()) {
            if (IsAreaGFOrSS()) {
                TriggerGravity()
                TriggerWind()
                Sleep(ArtifactSleepAmount)
            } else {
                if (F9UsesWind) {
                    TriggerWind()
                    Sleep(ArtifactSleepAmount)
                }
            }
        }
    }
}

UseWings2() {
    if (IsWindowActive() && IsBossTimerActive()) {
        TriggerWobblyWings()
    }
}

CleanupTimer2(ExitReason, ExitCode) {
    SetTimer(UseWings2, -1)
    ExitApp()
}