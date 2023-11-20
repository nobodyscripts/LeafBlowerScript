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
settings.initSettings()

OnExit(CleanupTimer)

Log("Secondary: Normal Boss Started")

InitGameWindow()
fNormalBoss()

fNormalBoss() {
    if (F9UsesWobblyWings && IsWindowActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        TriggerWobblyWings()
    }
    loop {
        if (!IsWindowActive()) {
            Log("NormBoss: Exiting as no game.")
            return
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("NormBoss: User killed. Aborted.")
            return
        }
        if (IsWindowActive() && IsBossTimerActive()) {
            TriggerViolin()
            Sleep(ArtifactSleepAmount)
        }
        if (F9UsesWind && IsWindowActive() && !IsBossTimerActive()) {
            TriggerWind()
            Log("Used wind " F9UsesWind " " F9UsesWobblyWings)
            Sleep(ArtifactSleepAmount)
        }
        if (IsAreaGFOrSS() && IsWindowActive() && !IsBossTimerActive()) {
            TriggerGravity()
            TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
    }
}

UseWings() {
    if (IsWindowActive() && IsBossTimerActive()) {
        TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}