#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
Global IsSecondary := true

#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\ScriptSettings.ahk
#Include ..\Lib\Functions.ahk
#Include ..\Lib\cGameWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

Global BossFarmUsesWobblyWings := false
Global BossFarmUsesWind := false
Global BossFarmUsesSeeds := false
Global BossFarmFast := false
Global WobblyWingsSleepAmount := 1
Global ArtifactSleepAmount := 1
Global settings := cSettings()
settings.initSettings(true)

OnExit(CleanupTimer)

Out.I("Secondary: Normal Boss Started")

fNormalBoss()
fNormalBoss() {
    startTime := A_Now
    If (BossFarmUsesWobblyWings && Window.IsActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        GameKeys.TriggerWobblyWings()
    }
    If (BossFarmFast) {
        cPoint(705, 72).Click()
        Sleep(150)
        AmountToModifier(25)
        Sleep(17)
        Travel.ScrollAmountDown(1)
        Sleep(17)
        ResetModifierKeys()
        Travel.ScrollAmountUp(7)
        Sleep(17)
    }
    Loop {
        If (!Window.Exist()) {
            Out.I("Secondary: Normal Boss Spammer exiting as no game.")
            Return
        }
        If (!Window.IsActive()) {
            Window.Activate()
        } Else {
            If (IsBossTimerActive() || DateDiff(A_Now, startTime, "Seconds") >=
            30) {

                If (BossFarmFast) {
                    AmountToModifier(10)
                    Sleep(17)
                    While (IsBossTimerActive()) {
                        cPoint(1796, 567).ClickButtonActive()
                        Sleep(17)
                    }
                    ResetModifierKeys()
                } Else {
                    GameKeys.TriggerViolin()
                    Sleep(ArtifactSleepAmount)
                }
                startTime := A_Now
            }
            If (!IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()) {
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
}

UseWings() {
    If (Window.IsActive() && IsBossTimerActive()) {
        GameKeys.TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}
