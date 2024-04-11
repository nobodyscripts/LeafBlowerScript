#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 8
#SingleInstance Force
#Include '../Lib/ScriptSettings.ahk'
#Include '../Lib/Functions.ahk'
#Include '../Lib/SettingsCheck.ahk'
#Include '../Lib/Navigate.ahk'
#Include '../Hotkeys.ahk'

global X, Y, W, H
X := Y := W := H := 0
global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global BossFarmUsesWobblyWings := false
global BossFarmUsesWind := false
global WobblyWingsSleepAmount := 1
global ArtifactSleepAmount := 1
global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer)

Log("Secondary: Normal Boss Started")

InitGameWindow()
fNormalBoss()

fNormalBoss() {
    startTime := A_Now
    if (BossFarmUsesWobblyWings && IsWindowActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        TriggerWobblyWings()
    }
    loop {
        if (!IsWindowActive()) {
            Log("NormBoss: Exiting as no game.")
            return
        }
        if ((IsWindowActive() && IsBossTimerActive()) || 
            (IsWindowActive() && DateDiff(A_Now, startTime, "Seconds") >= 30)) {
            TriggerViolin()
            Sleep(ArtifactSleepAmount)
            startTime := A_Now
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            if (IsAreaGFOrSS()) {
                TriggerGravity()
                TriggerWind()
                Sleep(ArtifactSleepAmount)
            } else {
                if (BossFarmUsesWind) {
                    TriggerWind()
                    Sleep(ArtifactSleepAmount)
                }
            }
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