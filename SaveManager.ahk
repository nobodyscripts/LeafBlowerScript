#Requires AutoHotkey v2.0
#SingleInstance Force


global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"

*F1:: {
    ExitApp()
}
*F2:: {
    Reload()
}

*F3:: {
    if (WinExist(LBRWindowTitle)) {
        MsgBox("CLOSE GAME BEFORE RUNNING BACKUP SCRIPT")
        ExitApp()
    }
    ActiveSavePath := A_AppData "\..\Local\blow_the_leaves_away\save.dat"
    localPath := A_ScriptDir "\Backups\"
    NewBackupSavePath := localPath "LBR Save " FormatTime(A_Now, "yyyy MM dd '-' HH'-'mm'-'ss") ".dat"
    if (!DirExist(localPath)) {
        DirCreate(localPath)
    }
    if (!FileExist(NewBackupSavePath)) {

        FileCopy(ActiveSavePath, NewBackupSavePath)
    }
    MsgBox("Have backed up save to:\n" NewBackupSavePath)
}
