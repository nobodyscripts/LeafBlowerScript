#Requires AutoHotkey v2.0

#MaxThreadsPerHotkey 8
#SingleInstance Force

global ScriptsLogFile := A_ScriptDir "\..\Secondaries.Log"
global IsSecondary := true

#Include ..\Lib\hGlobals.ahk
#Include ..\Lib\ScriptSettings.ahk
#Include ..\Lib\Functions.ahk
#Include ..\Lib\cGameWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk

global settings := cSettings()
settings.initSettings(true)

Out.I("Secondary: Tower Passive Started")

fTowerPassiveSpammer()
fTowerPassiveSpammer() {
    loop {
        if (!Window.Exist()) {
            Out.I("Secondary: Tower Passive Spammer exiting as no game.")
            return
        }
        if (!Window.IsActive()) {
            Window.Activate()
        } else {
            if (Travel.HomeGarden.IsAreaGarden()) {
                GoToLeafTower()
            }
            if (!IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()) {
                GameKeys.TriggerBlazingSkull()
                Sleep(17)
                GameKeys.TriggerWind()
                Sleep(17)
            }
        }
    }
}
