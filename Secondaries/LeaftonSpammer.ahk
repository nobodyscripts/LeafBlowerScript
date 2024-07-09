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

Global ArtifactSleepAmount := 1
Global BossFarmUsesSeeds := true
Global settings := cSettings()
settings.initSettings(true)

Log("Secondary: Wind Spammer Started")

GameWindowExist()
fWindSpammer()

fWindSpammer() {
    Loop {
        If (!IsWindowActive()) {
            Log("Secondary: Wind Spammer exiting as no game.")
            Return
        }
        If (IsWindowActive() && !IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()
        ) {
            GameKeys.TriggerWind()
            If (BossFarmUsesSeeds) {
                GameKeys.TriggerSeeds()
            }
            Sleep(ArtifactSleepAmount)
        }
    }
}