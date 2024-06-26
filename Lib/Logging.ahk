#Requires AutoHotkey v2.0

global ScriptsLogFile, EnableLogging
global Verbose := (FileExist(A_ScriptDir "\IsNobody"))

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
    if (!logfile && IsSet(ScriptsLogFile)) {
        logfile := ScriptsLogFile
    } else if (!logfile) {
        logfile := A_ScriptDir "\LeafBlowerV3.Log"
    }
    if (!IsSet(EnableLogging)) {
        EnableLogging := true
    }
    static isWritingToLog := false
    logmessage := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' ' logmessage '`r`n'
    OutputDebug(logmessage)
    if (!EnableLogging) {
        return
    }
    k := 0
    try {
        if (!isWritingToLog) {
            isWritingToLog := true
            Sleep(1)
            FileAppend(logmessage, logfile)
            isWritingToLog := false

        }
    } catch as exc {
        OutputDebug("LogError: Error writing to log - " exc.Message "`r`n")
        ; MsgBox("Error writing to log:`n" exc.Message)
        Sleep(1)
        FileAppend(logmessage, logfile)
        Sleep(1)
        FileAppend(FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) ' - '
            "LogError: Error writing to log - " exc.Message '`r`n', logfile)
    }
}

/**
 * Logging locked behind debug flag
 * @param logmessage 
 */
DebugLog(logmessage) {
    if (!Debug) {
        Return
    }
    Log("Debug: " logmessage)
}

/**
 * Logging for very frequent log entries, does not write to file only 
 * Locked behind verbose set in logging.ahk
 * OutputDebug
 * @param logmessage 
 */
VerboseLog(logmessage) {
    if (!Verbose) {
        Return
    }
    logmessage := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) " Verbose: " logmessage '`r`n'
    OutputDebug( logmessage)
}