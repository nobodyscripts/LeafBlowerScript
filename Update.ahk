#Requires AutoHotkey v2.0.0

If (WinExist("LBR ahk_class AutoHotkeyGUI ahk_exe AutoHotkey64.exe")) {
    WinClose("LBR ahk_class AutoHotkeyGUI ahk_exe AutoHotkey64.exe")
}

Download("*0 https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip", "Install.zip")

DirCopy("Install.zip", A_ScriptDir , 1)
DirCopy(A_ScriptDir "\LeafBlowerScript-main", A_ScriptDir, 2)
DirDelete(A_ScriptDir "\LeafBlowerScript-main", 1)
FileDelete(A_ScriptDir "\Install.zip")
MsgBox("LBR Script Update Completed.")