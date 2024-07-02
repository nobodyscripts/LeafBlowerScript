#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global IsSecondary := true

#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\ScriptSettings.ahk
#Include ..\Lib\Functions.ahk
#Include ..\Lib\SettingsCheck.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

global BossFarmUsesWind := false
global BossFarmUsesSeeds := false
global ArtifactSleepAmount := 1
global settings := cSettings()
settings.initSettings(true)

Log("Secondary: GFSS Boss Started")

GameWindowExist()
fGFSSBoss()

fGFSSBoss() {
    startTime := A_Now
    loop {
        if (!IsWindowActive()) {
            Log("GFSSBoss: Exiting as no game.")
            return
        }
        if ((IsWindowActive() && IsBossTimerActive()) || (IsWindowActive() &&
            DateDiff(A_Now, startTime, "Seconds") >= 30)) {
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