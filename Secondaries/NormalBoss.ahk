#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
Global IsSecondary := true

#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\ScriptSettings.ahk
#Include ..\Lib\Functions.ahk
#Include ..\Lib\SettingsCheck.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

Global BossFarmUsesWobblyWings := false
Global BossFarmUsesWind := false
Global BossFarmUsesSeeds := false
Global WobblyWingsSleepAmount := 1
Global ArtifactSleepAmount := 1
Global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer)

Log("Secondary: Normal Boss Started")

GameWindowExist()
fNormalBoss()

fNormalBoss() {
    startTime := A_Now
    If (BossFarmUsesWobblyWings && IsWindowActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        GameKeys.TriggerWobblyWings()
    }
    Loop {
        If (!IsWindowActive()) {
            Log("NormBoss: Exiting as no game.")
            Return
        }
        If ((IsWindowActive() && IsBossTimerActive()) || (IsWindowActive() &&
            DateDiff(A_Now, startTime, "Seconds") >= 30)) {
            GameKeys.TriggerViolin()
            Sleep(ArtifactSleepAmount)
            startTime := A_Now
        }
        If (IsWindowActive() && !IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()
        ) {
            If (BossFarmUsesSeeds) {
                GameKeys.TriggerSeeds()
            }
            If (IsAreaGFOrSS()) {
                GameKeys.TriggerGravity()
                GameKeys.TriggerWind()
                Sleep(ArtifactSleepAmount)
            } Else {
                If (BossFarmUsesWind) {
                    GameKeys.TriggerWind()
                    Sleep(ArtifactSleepAmount)
                }
            }
        }
    }
}

UseWings() {
    If (IsWindowActive() && IsBossTimerActive()) {
        GameKeys.TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}