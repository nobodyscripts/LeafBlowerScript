#Requires AutoHotkey v2.0.0

#SingleInstance Force
#Include Lib\Logging.ahk
#Include Gui\UpdatingGUI.ahk

Global EnableLogging := true
Global Debug := true
Global Verbose := true
Global LogBuffer := true
Global TimestampLogs := true
Global DebugAll := true
Global IsSecondary := false

Out := cLog("Updater.log", true, 3, false)

Dialog := UpdatingGUI()
Dialog.Show()
closedScript := false
If (WinExist("LBR ahk_class AutoHotkeyGUI ahk_exe AutoHotkey64.exe")) {
    WinClose("LBR ahk_class AutoHotkeyGUI ahk_exe AutoHotkey64.exe")
    Out.I("Closed main script")
    closedScript := true
}

Try {
    If (FileExist("Install.zip")) {
        FileDelete("Install.zip")
        Out.I("Removed old Install.zip")
    }
    Download("https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip", "Install.zip")
} Catch Error As uperr {
    Dialog.Hide()
    MsgBox("Error occured during update download:`r`n" uperr.Message)
    Out.E("Install.zip download failed with error.")
    Out.E(uperr)
    ExitApp()
}
If (!FileExist("Install.zip")) {
    Dialog.Hide()
    Out.I("Install.zip failed to download.")
    MsgBox("Error: Zip failed to download.")
    ExitApp()
}
Try {
    Out.I("Install.zip downloaded. Unpacking.")
    DirCopy("Install.zip", A_ScriptDir, 1)
    DirCopy(A_ScriptDir "\LeafBlowerScript-main", A_ScriptDir, 2)
    DirDelete(A_ScriptDir "\LeafBlowerScript-main", 1)
    FileDelete(A_ScriptDir "\Install.zip")
} Catch Error As unpackerr {
    Dialog.Hide()
    MsgBox("Error occured during update:`r`n" unpackerr.Message " " unpackerr.Extra)
    Out.E("Update failed to extract with error.")
    Out.E(unpackerr)
    ExitApp()
}
Dialog.Hide()
MsgBox("LBR Script Update Completed.")
If (closedScript) {
    Run("LeafBlowerV3.ahk")
}
ExitApp()