#Requires AutoHotkey v2.0

/**
 * File contains globals reused between scripts
 */

Global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
Global ActiveSavePath := GameSaveDir "save.dat"
Global ActiveGameSettingsPath := GameSaveDir "options.dat"
Global DisableSettingsChecks := false
Global TimestampLogs := true

If (!IsSet(Debug)) {
    Global Debug := true
}

If (!IsSet(Verbose)) {
    Global Verbose := true
}

If (!IsSet(IsSecondary)) {
    ; If not set, assume temp testing script
    Global IsSecondary := false
}

/**
 * @type {cGameWindow} Game window class global
 */
Global Window := cGameWindow(
    "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe")