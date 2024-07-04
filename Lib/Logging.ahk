#Requires AutoHotkey v2.0

global ScriptsLogFile, EnableLogging
global Verbose := (FileExist(A_ScriptDir "\IsNobody"))
global TimestampLogs := true

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
    time := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec)
    if (!logfile && IsSet(ScriptsLogFile)) {
        logfile := ScriptsLogFile
    } else if (!logfile) {
        logfile := A_ScriptDir "\LeafBlowerV3.Log"
    }
    if (!IsSet(EnableLogging)) {
        EnableLogging := true
    }
    static isWritingToLog := false
    if (TimestampLogs) {
        logmessage := time ' ' logmessage '`r`n'
    } else {
        logmessage := logmessage '`r`n'
    }
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
        if (TimestampLogs) {
            OutputDebug(time " LogError: Error writing to log - " exc.Message "`r`n"
            )
            ; MsgBox("Error writing to log:`n" exc.Message)
            Sleep(1)
            FileAppend(logmessage, logfile)
            Sleep(1)
            FileAppend(time " LogError: Error writing to log - " exc.Message '`r`n',
                logfile)
        } else {
            OutputDebug("LogError: Error writing to log - " exc.Message "`r`n")
            ; MsgBox("Error writing to log:`n" exc.Message)
            Sleep(1)
            FileAppend(logmessage, logfile)
            Sleep(1)
            FileAppend("LogError: Error writing to log - " exc.Message '`r`n',
                logfile)
        }
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
    if (TimestampLogs) {
        logmessage := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec) " Verbose: " logmessage '`r`n'
    } else {
        logmessage := "Verbose: " logmessage '`r`n'
    }
    OutputDebug(logmessage)
}

/**
 * Log error information and stack
 * @param {Error} error 
 */
ErrorLog(error) {
    DebugLog("Error:" error.Message "`n ErrorExtra: " error.Extra "`nStack: " Error()
        .Stack)
}

/**
 * Log callstack for Deprecated functions that need removal to be located
 */
Deprecated() {
    if (!Debug) {
        Return
    }
    DebugLog("Deprecated:" Error().Stack)
}