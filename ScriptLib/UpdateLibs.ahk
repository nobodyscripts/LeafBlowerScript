#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 8
#SingleInstance Force

/** @type {cLog} */
Out := cLog(A_ScriptDir "\Secondaries.log", true, 3, false)

#Include cLogging.ahk
#Include cSettings.ahk

S.initSettings()

UpdateLibs()

;@region UpdateLibs()
UpdateLibs(*) {
    Try {
        UpdateFolders := ["..\LeafBlowerScript\ScriptLib",
            "..\LBRSaveManager\ScriptLib",
            "..\wizardswheel2script\ScriptLib",
            "..\WW2SaveManager\ScriptLib",
            "..\MacroCreator\ScriptLib"]
        msg := ""
        For (folder in UpdateFolders) {
            targetDir := A_ScriptDir "\" folder
            If (DirExist(targetDir)) {
                msg .= "Copying base lib files to " targetDir "`r`n"
                msg .= "Copying ext lib files to " targetDir "\ExtLibs`r`n"
            }
        }
        HasPressed := MsgBox("Update all scriptlib folders?`r`n" msg,
            "Update folders?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            For (folder in UpdateFolders) {
                targetDir := A_ScriptDir "\" folder
                If (DirExist(targetDir)) {
                    ; Wipe any file first
                    Out.I("Deleting " targetDir)
                    DirDelete(targetDir, 1)
                    DirCreate(targetDir)

                    Out.I("Copying base lib files to " targetDir)
                    FileCopy(A_ScriptDir "\*.ahk", targetDir, 1)
                    FileCopy(A_ScriptDir "\*.md", targetDir, 1)
                    FileCopy(A_ScriptDir "\*.json", targetDir, 1)

                    Out.I("Copying ext lib files to " targetDir "\ExtLibs")
                    DirCopy(A_ScriptDir "\ExtLibs", targetDir "\ExtLibs", 1)
                }
            }
        }
    } Catch Error As OutputVar {
        Out.E(OutputVar)
    }
}
;@endregion
