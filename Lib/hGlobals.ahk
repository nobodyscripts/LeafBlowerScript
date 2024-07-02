#Requires AutoHotkey v2.0

/**
 * File contains globals reused between scripts
 */

global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
global ActiveSavePath := GameSaveDir "save.dat"
global ActiveGameSettingsPath := GameSaveDir "options.dat"

global LBRWindowTitle := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
global X := Y := W := H := 0

if (WinExist(LBRWindowTitle)) {
    WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
}