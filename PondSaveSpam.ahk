#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\PondSaveSpam.Log"
Global IsSecondary := false

#Include Lib\hGlobals.ahk
#Include Lib\ScriptSettings.ahk
#Include Lib\Functions.ahk
#Include Lib\cGameWindow.ahk
#Include Lib\Navigate.ahk
#Include Lib\cHotkeysInitGame.ahk
#Include Modules\Fishing.ahk

/** @type {cSettings} */
Global settings := cSettings()
settings.initSettings(true)

Out.I("PondSaveSpam: Started")
F1::
{
    ExitApp()
}
F2::
{
    Reload()
}

F3::
{
    Loop {
        Out.I("Running LBR")
        If (FileExist("C:\Program Files (x86)\Steam\steamapps\common\Leaf Blower Revolution\game.exe")) {
            Run("C:\Program Files (x86)\Steam\steamapps\common\Leaf Blower Revolution\game.exe",
                "C:\Program Files (x86)\Steam\steamapps\common\Leaf Blower Revolution", , &pid)
        } else if (FileExist("D:\Games\Steam\steamapps\common\Leaf Blower Revolution\game.exe")) {
            Run("D:\Games\Steam\steamapps\common\Leaf Blower Revolution\game.exe",
                "D:\Games\Steam\steamapps\common\Leaf Blower Revolution", , &pid)
        } else {
            MsgBox("Game not found, please edit script to modify the game path to your case")
            ExitApp()
        }

        WinWait("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe")
        Sleep(150)
        Window.Activate()

        Window.AwaitPanel(10)

        Travel.ClosePanelIfActive()
        Travel.ClosePanelIfActive()
        Sleep(100)

        Out.I("Opening fishing")
        cPoint(329, 1116).ClickOffset(2, 2)

        Window.AwaitPanel()
        Fishing().Search.WaitUntilActiveButtonS(5)

        Out.I("Clicking search")
        Fishing().Search.ClickButtonActive()

        If (Pond(4).Rarity.IsBackground()) {
            Fishing().Search.ClickButtonActive()
        }
        If (!Pond(4).Rarity.IsBackground()) {
            rarity := Pond(4).GetPondRarity()
            Out.I("Pond rarity: " rarity)

            If (rarity = 6 || rarity = 0) {
                Out.I("Found target, reloading")
                Break
            }
            If ((pid && ProcessExist(pid))) {
                Out.I("Closing LBR")
                ProcessClose(pid)
            } Else {
                Out.I("Closing LBR")
                WinClose("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe")
            }
            WinWaitClose("Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe")
        } Else {
            Out.I("Search failed to occur exiting script")
            Break
        }
        Sleep(250)
        If (GetKeyState("F4", "P")) {
            Out.I("Script aborted due to F4")
            Break
        }

    }
    Reload()
}
