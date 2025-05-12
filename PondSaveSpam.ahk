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
    GamePath1 := "C:\Program Files (x86)\Steam\steamapps\common\Leaf Blower Revolution"
    GamePath2 := "D:\Games\Steam\steamapps\common\Leaf Blower Revolution"
    SaveMythical := false
    SaveLegendary := true
    /** @type {Pond} */
    TargetPond := Pond(4)

    /** @type {cPoint} */
    RarityPoint := TargetPond.Rarity
    /** @type {cPoint} */
    search := Fishing().Search
    /** @type {cPoint} */
    OpenFishing := cPoint(329, 1116)
    pid := false
    WindowPattern := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
    LastLoop := A_TickCount

    Loop {
        If (!Window.Exist()) {
            Out.I("Running LBR")
            If (FileExist(GamePath1 "\game.exe")) {
                Run(GamePath1 "\game.exe",
                    GamePath1, , &pid)
            } Else If (FileExist(GamePath2 "\game.exe")) {
                Run(GamePath2 "\game.exe",
                    GamePath2, , &pid)
            } Else {
                MsgBox("Game not found, please edit script to modify the game path to your case")
                ExitApp()
            }

            WinWait(WindowPattern)
            Sleep(150)
        }
        If (!Window.Exist()) {
            Continue
        } Else If (!pid) {
            pid := WinGetPID(WindowPattern)
        }
        Out.I("Time since last loop: " Format("{:#.3f}", (A_TickCount - LastLoop) / 1000))
        LastLoop := A_TickCount
        Window.Activate()

        Window.AwaitPanel(10)

        Travel.ClosePanelIfActive()
        Travel.ClosePanelIfActive()
        Sleep(100)

        Out.I("Opening fishing")
        OpenFishing.ClickOffset(2, 2)

        Window.AwaitPanel()
        search.WaitUntilActiveButtonS(5)

        Out.I("Clicking search")
        search.ClickOffsetUntilColourS("0xC8BDA5", 2, 2, , 3)

        If (RarityPoint.IsBackground()) {
            search.ClickButtonActive()
        }
        If (!RarityPoint.IsBackground()) {
            rarity := TargetPond.GetPondRarity()
            Out.I("Pond rarity: " rarity)
            If (SaveMythical && rarity = 5) {
                Out.I("Found mythical target, reloading")
                Break
            }
            If (SaveLegendary && rarity = 6) {
                Out.I("Found legendary target, reloading")
                Break
            }
            If ((pid && ProcessExist(pid))) {
                Out.I("Closing LBR")
                ProcessClose(pid)
            } Else {
                Out.I("Closing LBR")
                WinClose(WindowPattern)
            }
            WinWaitClose(WindowPattern)
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
