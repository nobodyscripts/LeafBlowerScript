#Requires AutoHotkey v2.0

global ScriptsLogFile, EnableLogging

/**
 * Logger, user disable possible, debugout regardless of setting to vscode.
 * Far more usable than outputting to tooltips or debugging using normal means
 * due to focus changing and hotkeys overwriting
 * @param logmessage 
 * @param {string} logfile Defaults to A_ScriptDir "\LeafBlowerV3.log" but is 
 * overwritable
 */
Log(logmessage, logfile := "") {
    global EnableLogging, ScriptsLogFile
    if (!logfile) {
        logfile := ScriptsLogFile
    }
    if (!logfile && !ScriptsLogFile) {
        logfile := A_ScriptDir "\LeafBlowerV3.Log"
    }
    if (!IsSet(EnableLogging)) {
        EnableLogging := true
    }
    static isWritingToLog := false
    message := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - ' logmessage '`r`n'
    OutputDebug(message)
    if (!EnableLogging) {
        return
    }
    k := 0
    try {
        if (!isWritingToLog) {
            isWritingToLog := true
            Sleep(1)
            FileAppend(message, logfile)
            isWritingToLog := false

        }
    } catch as exc {
        OutputDebug("LogError: Error writing to log - " exc.Message "`r`n")
        ; MsgBox("Error writing to log:`n" exc.Message)
        Sleep(1)
        FileAppend(message, logfile)
        Sleep(1)
        FileAppend(FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - '
            "LogError: Error writing to log - " exc.Message '`r`n', logfile)
    }
}