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

Global ArtifactSleepAmount := 1
Global settings := cSettings()
settings.initSettings(true)

Out.I("Secondary: Tower Passive Started")

fTowerPassiveSpammer()
fTowerPassiveSpammer() {
    Loop {
        If (!Window.Exist()) {
            Out.I("Secondary: Tower Passive Spammer exiting as no game.")
            Return
        }
        If (!Window.IsActive()) {
            Window.Activate()
        } Else {
            If (Travel.HomeGarden.IsAreaGarden()) {
                GoToLeafTower()
            }
            If (!IsBossTimerActive() && !Travel.HomeGarden.IsAreaGarden()) {
                GameKeys.TriggerBlazingSkull()
                GameKeys.TriggerWind()
                Sleep(ArtifactSleepAmount)
            }
        }
    }
}