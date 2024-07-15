#Requires AutoHotkey v2.0

/**
 * File contains globals reused between scripts
 */

Global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
Global ActiveSavePath := GameSaveDir "save.dat"
Global ActiveGameSettingsPath := GameSaveDir "options.dat"

Global LBRWindowTitle :=
    "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
Global X := Y := W := H := 0

If (WinExist(LBRWindowTitle)) {
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
}

If (!IsSet(IsSecondary)) {
    ; If not set, assume temp testing script
    IsSecondary := false
}

InitSettingsCheck()