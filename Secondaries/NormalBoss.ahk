#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/** Using Out instead of Log as thats taken by a func
 * @type {cLog} Global cLog object */
Global Out := cLog(A_ScriptDir "\..\Secondaries.Log", true, 3, true)

/** @type {cLBRWindow} */
Global Window := cLBRWindow("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe", 2560, 1369)
#Include ..\ScriptLib\cSettings.ahk
#Include ..\Lib\Misc.ahk
#Include ..\Lib\cLBRButton.ahk
#Include ..\Lib\cLBRWindow.ahk
#Include ..\Lib\Navigate.ahk
#Include ..\Lib\cHotkeysInitGame.ahk
#Include ..\Modules\FarmNormalBoss.ahk

S.Filename := A_ScriptDir "\..\UserSettings.ini"
S.initSettings()

Scriptkeys.sFilename := A_ScriptDir "\..\ScriptHotkeys.ini"
Scriptkeys.initHotkeys()

GameKeys.sFilename := A_ScriptDir "\..\UserHotkeys.ini"
GameKeys.initHotkeys()

OnExit(CleanupTimer)

Out.I("Secondary: Normal Boss Started")

fNormalBoss()
fNormalBoss() {
    ArtifactSleepAmount := S.Get("ArtifactSleepAmount")
    BossFarmUsesSeeds := S.Get("BossFarmUsesSeeds")
    BossFarmUsesWind := S.Get("BossFarmUsesWind")
    BossFarmUsesWobblyWings := S.Get("BossFarmUsesWobblyWings")
    WobblyWingsSleepAmount := S.Get("WobblyWingsSleepAmount")
    BossFarmFast := S.Get("BossFarmFast")
    startTime := A_Now
    Window.StartOrExit()
    If (BossFarmUsesWobblyWings && Window.IsActive() && IsBossTimerActive()) {
        SetTimer(UseWings, WobblyWingsSleepAmount)
        ; Use it once to avoid getting stuck
        GameKeys.TriggerWobblyWings()
    }
    If (BossFarmFast) {
        cLBRButton(705, 72).Click()
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
        Window.StartOrExit()
        If (IsBossTimerActive() || DateDiff(A_Now, startTime, "Seconds") >=
        30) {

            If (BossFarmFast) {
                AmountToModifier(10)
                Sleep(17)
                While (IsBossTimerActive()) {
                    cLBRButton(1796, 567).ClickButtonActive()
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

UseWings() {
    If (Window.IsActive() && IsBossTimerActive()) {
        GameKeys.TriggerWobblyWings()
    }
}

CleanupTimer(ExitReason, ExitCode) {
    SetTimer(UseWings, -1)
    ExitApp()
}
