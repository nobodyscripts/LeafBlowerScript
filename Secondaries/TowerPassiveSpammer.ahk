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
            TriggerBlazingSkull()
            TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
    }
}
