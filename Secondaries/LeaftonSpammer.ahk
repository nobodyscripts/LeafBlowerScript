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

global ArtifactSleepAmount := 1
global BossFarmUsesSeeds := true
global settings := cSettings()
settings.initSettings(true)

Log("Secondary: Wind Spammer Started")

GameWindowExist()
fWindSpammer()

fWindSpammer() {
    loop {
        if (!IsWindowActive()) {
            Log("Secondary: Wind Spammer exiting as no game.")
            return
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            Gamekeys.TriggerWind()
            if (BossFarmUsesSeeds) {
                Gamekeys.TriggerSeeds()
            }
            Sleep(ArtifactSleepAmount)
        }
    }
}