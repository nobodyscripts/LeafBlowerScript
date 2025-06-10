#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/** @type {cLog} */
Out := cLog(A_ScriptDir "\Installer.log", true, 3, false)

#Include ScriptLib\cSettings.ahk
#Include Lib\Misc.ahk
#Include Lib\cLBRWindow.ahk
#Include Lib\Navigate.ahk
#Include Lib\cHotkeysInitGame.ahk

S.initSettings(true)


InstallScript()
;@region InstallScript()
/**
 * 
 */
InstallScript(*) {
    full_command_line := DllCall("GetCommandLine", "str")

    If !(A_IsAdmin || RegExMatch(full_command_line, " /restart(?!\S)")) {
        Try {
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
        }
        Return
    }
    Try {
        ShortcutFolder := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\NobodyScripts"
        If (!DirExist(ShortcutFolder)) {
            DirCreate(ShortcutFolder)
        }
        ; Leafblower shortcut
        FileCreateShortcut(A_ScriptDir "\LeafBlowerV3.ahk", ShortcutFolder "\Leafblower NobodyScript.lnk",
            ShortcutFolder, ,
            "Start the Leafblower Script by Nobody")

        ; Updater shortcut
        FileCreateShortcut(A_ScriptDir "\Update.ahk", ShortcutFolder "\Update Leafblower.lnk", ShortcutFolder, ,
            "Update Leafblower Script")

        ; Uninstaller shortcut
        FileCreateShortcut(A_ScriptDir "\Uninstaller.ahk", ShortcutFolder "\Uninstall Leafblower.lnk", ShortcutFolder, ,
            "Remove Leafblower Script")
        If (FileExist(ShortcutFolder "\Leafblower NobodyScript.lnk")) {
            MsgBox("Shortcuts created in Start Menu")
        } Else {
            MsgBox("Failed to create shortcuts")
        }
    } Catch Error As OutputVar {
        Out.E(OutputVar)
    }
}
;@endregion
