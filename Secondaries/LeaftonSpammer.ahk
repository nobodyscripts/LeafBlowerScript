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
global BossFarmUsesSeeds := true
global settings := cSettings()
settings.initSettings(true)

Log("Secondary: Wind Spammer Started")

InitGameWindow()
fWindSpammer()

fWindSpammer() {
    loop {
        if (!IsWindowActive()) {
            Log("Secondary: Wind Spammer exiting as no game.")
            return
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            TriggerWind()
            if (BossFarmUsesSeeds) {
                TriggerSeeds()
            }
            Sleep(ArtifactSleepAmount)
        }
    }
}