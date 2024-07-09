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
Global settings := cSettings()
settings.initSettings(true)

Log("Secondary: Tower Passive Started")

GameWindowExist()
fTowerPassiveSpammer()

fTowerPassiveSpammer() {
    Loop {
        If (!IsWindowActive()) {
            Log("Secondary: Tower Passive Spammer exiting as no game.")
            Return
        }
        If (Travel.HomeGarden.IsAreaGarden()) {
            GoToLeafTower()
        }
        If (IsWindowActive() && !IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()
        ) {
            GameKeys.TriggerBlazingSkull()
            GameKeys.TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
    }
}