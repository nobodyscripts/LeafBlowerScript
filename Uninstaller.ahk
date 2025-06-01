#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

Global ScriptsLogFile := A_ScriptDir "\Secondaries.Log"
Global IsSecondary := false

#Include Lib\hGlobals.ahk
#Include Lib\ScriptSettings.ahk
;#Include Lib\Functions.ahk
;#Include Lib\cGameWindow.ahk
;#Include Lib\Navigate.ahk
;#Include Lib\cHotkeysInitGame.ahk

/** @type {cSettings} */
Global settings := cSettings()
settings.initSettings(true)

UninstallScript()

;@region UninstallScript()
/**
 * 
 */
UninstallScript(*) {
    full_command_line := DllCall("GetCommandLine", "str")

    If !(A_IsAdmin || RegExMatch(full_command_line, " /restart(?!\S)")) {
        Try {
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
        }
        Return
    }
    Try {
        ShortcutFolder := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\NobodyScripts"
        If (DirExist(ShortcutFolder)) {
            If (FileExist(ShortcutFolder "\Leafblower NobodyScript.lnk")) {
                FileDelete(ShortcutFolder "\Leafblower NobodyScript.lnk")
            }
            If (FileExist(ShortcutFolder "\Update Leafblower.lnk")) {
                FileDelete(ShortcutFolder "\Update Leafblower.lnk")
            }
            If (FileExist(ShortcutFolder "\Uninstall Leafblower.lnk")) {
                FileDelete(ShortcutFolder "\Uninstall Leafblower.lnk")
            }
            DirDelete(ShortcutFolder, 0)
        }
        HasPressed := MsgBox("Delete script folder? This removes everything in " A_ScriptDir,
            "Delete folder?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            DirDelete(A_ScriptDir, 1)
        }
    } Catch Error As OutputVar {
        Out.E(OutputVar)
    }
}
;@endregion
