#Requires AutoHotkey v2.0
#SingleInstance Force


global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"

global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
global ActiveSavePath := GameSaveDir "save.dat"
global BackupSaveDir := "\\?\" A_ScriptDir "\Backups\"
global UserBackupSaveDir := 0

LoadSettings()
RunGui()

*F1:: {
    cExit()
}

cExit(*) {
    ExitApp()
}

*F2:: {
    cReload()
}

cReload(*) {
    Reload()
}

*F3:: {
    cBackupSave()
}

cBackupSave(*) {
    if (WinExist(LBRWindowTitle)) {
        MsgBox("CLOSE GAME BEFORE RUNNING BACKUP SCRIPT")
        cReload()
        return
    }

    if (UserBackupSaveDir) {
        BackupDir := UserBackupSaveDir
    } else {
        BackupDir := BackupSaveDir
    }
    NewBackupSavePath := BackupDir "LBR Save " FormatTime(A_Now, "yyyy MM dd '-' HH'-'mm'-'ss") ".dat"
    if (!DirExist(BackupDir)) {
        DirCreate(BackupDir)
    }
    if (!FileExist(NewBackupSavePath)) {

        FileCopy(ActiveSavePath, NewBackupSavePath)
    }
    MsgBox("Have backed up save to:`n" RemoveLongPath(NewBackupSavePath), "Backup Successful")
    OpenBackupDir()

}

*F4:: {
    cOpenSaveDir()
}

cOpenSaveDir(*) {
    OpenSaveDir()
}

*F5:: {
    cOpenBackupDir()
}

cOpenBackupDir(*) {
    OpenBackupDir()
}

*F6:: {
    cRestoreNewestBackup()
}

cRestoreNewestBackup(*) {
    if (WinExist(LBRWindowTitle)) {
        MsgBox("CLOSE GAME BEFORE RUNNING RESTORE SCRIPT")
        cReload()
        return
    }
    if (UserBackupSaveDir) {
        BackupDir := UserBackupSaveDir
    } else {
        BackupDir := BackupSaveDir
    }
    newestFile := ""
    newestFileTime := 0
    timeDiff := 0
    currentTime := A_now
    loop files BackupDir "*.dat", "F" {
        if (newestFileTime = 0) {
            newestFileTime := A_LoopFileTimeCreated
            newestFile := A_LoopFileName
            timeDiff := DateDiff(currentTime, A_LoopFileTimeCreated, "Seconds")
        } else {
            if (DateDiff(currentTime, A_LoopFileTimeCreated, "Seconds") < timeDiff) {
                newestFileTime := A_LoopFileTimeCreated
                newestFile := A_LoopFileName
                timeDiff := DateDiff(currentTime, A_LoopFileTimeCreated, "Seconds")
            }
        }
    }
    if (newestFile = "") {
        MsgBox("Aborted, no backups found.", , "0x100 0x30")
        return
    }
    HasPressed := MsgBox("Newest file: " newestFile
        "`nMinutes old: " Format("{1:.2f}", timeDiff / 60)
        "`n Do you wish to restore?",
        "Restore backup file?", "0x1 0x100 0x10")
    if (HasPressed = "OK") {
        HasPressed2 := MsgBox("Are you certain, current save will be lost?",
            "Restore backup file?", "0x1 0x100 0x30")
    } else {
        MsgBox("Aborted save restore.", , "0x100 0x30")
        return
    }

    if (HasPressed2 = "OK") {
        DirCopy(BackupDir newestFile, ActiveSavePath, true)
    } else {
        MsgBox("Aborted save restore.", , "0x100 0x30")
        return
    }
}

RunGui() {
    MyGui := Gui(, "LBR SaveManager NobodyScript")
    ;MyGui.Opt("-SysMenu")
    MyGui.BackColor := "0c0018"

    MyGui.Add("Text", "ccfcfcf", "F1")
    MyBtn := MyGui.Add("Button", "Default w80", "Exit")
    MyBtn.OnEvent("Click", cExit)

    MyGui.Add("Text", "ccfcfcf", "F2")
    MyBtn := MyGui.Add("Button", "Default w80", "Reload/End")
    MyBtn.OnEvent("Click", cReload)

    MyGui.Add("Text", "ccfcfcf", "F3")
    MyBtn := MyGui.Add("Button", "Default w120", "Backup Save`n(Close Game First)")
    MyBtn.OnEvent("Click", cBackupSave)

    MyGui.Add("Text", "ccfcfcf", "F4")
    MyBtn := MyGui.Add("Button", "Default w120", "Open Save Dir")
    MyBtn.OnEvent("Click", cOpenSaveDir)

    MyGui.Add("Text", "ccfcfcf", "F5")
    MyBtn := MyGui.Add("Button", "Default w120", "Open Backup Dir")
    MyBtn.OnEvent("Click", cOpenBackupDir)

    MyGui.Add("Text", "cff0000", "F6 (WARNING DANGEROUS)")
    MyBtn := MyGui.Add("Button", "Default w120", "Restore`nNewest Backup")
    MyBtn.OnEvent("Click", cRestoreNewestBackup)

    MyGui.Add("Text", "ccfcfcf wp", "Settings")
    MyBtn := MyGui.Add("Button", "Default w120", "Settings")
    MyBtn.OnEvent("Click", cOpenSettings)

    MyGui.Show("w400")

    ;MyGui.OnEvent("Close", Button_Click_Exit)
}

cOpenSettings(*) {
    global UserBackupSaveDir

    settingsGUI := GUI(, "General Settings")
    settingsGUI.Opt("+Owner +MinSize +MinSize500x")
    settingsGUI.BackColor := "0c0018"

    settingsGUI.Add("Text", "ccfcfcf", "Backup Folder:")
    If (UserBackupSaveDir) {
        settingsGUI.AddEdit("vSaveDir", RemoveLongPath(UserBackupSaveDir))
    } else {
        settingsGUI.AddEdit("vSaveDir", RemoveLongPath(BackupSaveDir))
    }

    settingsGUI.Add("Button", "default", "Save").OnEvent("Click", SaveUserSettings)
    settingsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseUserGeneralSettings)

    settingsGUI.Show("w300")

    SaveUserSettings(*) {
        global UserBackupSaveDir
        values := settingsGUI.Submit()
        UserBackupSaveDir := values.SaveDir
        if (DirExist(UserBackupSaveDir) ) {
            SaveSettings()
        } else {
            MsgBox("Could not save new backup folder, no dir found.", , "0x10")
            return
        }
        settingsGUI.Hide()
    }

    CloseUserGeneralSettings(*) {
        settingsGUI.Hide()
    }
}
OpenSaveDir() {
    Run("Explorer.exe " GameSaveDir)
}

OpenBackupDir() {
    if (UserBackupSaveDir) {
        BackupDir := UserBackupSaveDir
    } else {
        BackupDir := BackupSaveDir
    }
    Run("Explorer.exe " BackupDir)
}

SaveSettings() {
    IniWrite(UserBackupSaveDir, "SaveManagerSettings.ini", "Default", "UserBackupSaveDir")
}

LoadSettings() {
    global UserBackupSaveDir := "\\?\" IniRead("SaveManagerSettings.ini", "Default", "UserBackupSaveDir", BackupSaveDir)
}

RemoveLongPath(var) {
    return StrReplace(var, "\\?\")
}