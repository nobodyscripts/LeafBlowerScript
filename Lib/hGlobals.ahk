#Requires AutoHotkey v2.0

/**
 * File contains globals reused between scripts
 */

Global GameSaveDir := A_AppData "\..\Local\blow_the_leaves_away\"
Global ActiveSavePath := GameSaveDir "save.dat"
Global ActiveGameSettingsPath := GameSaveDir "options.dat"
Global DisableSettingsChecks := false
Global TimestampLogs := true

If (!IsSet(EnableLogging)) {
    Global EnableLogging := true
}

If (!IsSet(Debug)) {
    Global Debug := true
}

If (!IsSet(Verbose)) {
    Global Verbose := true
}

If (!IsSet(LogBuffer)) {
    Global LogBuffer := true
}

If (!IsSet(IsSecondary)) {
    ; If not set, assume temp testing script
    Global IsSecondary := false
}

/** @type {cLog} Global cLog object
 * Using Out instead of Log as thats taken by a func
 */
Global Out := cLog(ScriptsLogFile, TimestampLogs, 3, LogBuffer)

/**
 * @type {cGameWindow} Game window class global
 */
Global Window := cGameWindow(
    "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe")