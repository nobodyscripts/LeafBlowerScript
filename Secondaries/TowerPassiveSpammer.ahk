#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 8
#SingleInstance Force

global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global IsSecondary := true

#Include '../Lib/ScriptSettings.ahk'
#Include '../Lib/Functions.ahk'
#Include '../Lib/SettingsCheck.ahk'
#Include '../Lib/Navigate.ahk'
#Include ..\Lib\cHotkeysInitGame.ahk

global X, Y, W, H
X := Y := W := H := 0
global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global ArtifactSleepAmount := 1
global settings := cSettings()
settings.initSettings(true)

Log("Secondary: Tower Passive Started")

InitGameWindow()
fTowerPassiveSpammer()

fTowerPassiveSpammer() {
    loop {
        if (!IsWindowActive()) {
            Log("Secondary: Tower Passive Spammer exiting as no game.")
            return
        }
        if (IsAreaResetToGarden()) {
            GoToLeafTower()
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            Gamekeys.TriggerBlazingSkull()
            Gamekeys.TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
    }
}