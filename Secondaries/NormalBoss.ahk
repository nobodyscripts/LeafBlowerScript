#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global IsSecondary := true

#Include ../Globals.ahk
#Include '../Lib/ScriptSettings.ahk'
#Include '../Lib/Functions.ahk'
#Include '../Lib/SettingsCheck.ahk'
#Include '../Lib/Navigate.ahk'
#Include ..\Lib\cHotkeysInitGame.ahk

global BossFarmUsesWobblyWings := false
global BossFarmUsesWind := false
global BossFarmUsesSeeds := false
global WobblyWingsSleepAmount := 1
global ArtifactSleepAmount := 1
global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer)

Log("Secondary: Normal Boss Started")

GameWindowExist()
fNormalBoss()

fNormalBoss() {
    startTime := A_Now
    if (BossFarmUsesWobblyWings && IsWindowActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        Gamekeys.TriggerWobblyWings()
    }
    loop {
        if (!IsWindowActive()) {
            Log("NormBoss: Exiting as no game.")
            return
        }
        if ((IsWindowActive() && IsBossTimerActive()) ||
            (IsWindowActive() && DateDiff(A_Now, startTime, "Seconds") >= 30)) {
            Gamekeys.TriggerViolin()
            Sleep(ArtifactSleepAmount)
            startTime := A_Now
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            if (BossFarmUsesSeeds) {
                Gamekeys.TriggerSeeds()
            }
            if (IsAreaGFOrSS()) {
                Gamekeys.TriggerGravity()
                Gamekeys.TriggerWind()
                Sleep(ArtifactSleepAmount)
            } else {
                if (BossFarmUsesWind) {
                    Gamekeys.TriggerWind()
                    Sleep(ArtifactSleepAmount)
                }
            }
        }
    }
}

UseWings() {
    if (IsWindowActive() && IsBossTimerActive()) {
        Gamekeys.TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}