#Requires AutoHotkey v2.0

Global ScriptsLogFile, EnableLogging
Global Verbose := (FileExist(A_ScriptDir "\IsNobody"))
Global TimestampLogs := true

; TODO Convert logging to class and use a file handle to keep file open

/**
 * Logger, user disable possible, debugout regardless of setting to vscode.
 * Far more usable than outputting to tooltips or debugging using normal means
 * due to focus changing and hotkeys overwriting
 * @param logmessage 
 * @param {string} logfile Defaults to A_ScriptDir "\LeafBlowerV3.log" but is 
 * overwritable
 */
Log(logmessage, logfile := "") {
    Global EnableLogging, ScriptsLogFile
    time := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec)
    If (!logfile && IsSet(ScriptsLogFile)) {
        logfile := ScriptsLogFile
    } Else If (!logfile) {
        logfile := A_ScriptDir "\LeafBlowerV3.Log"
    }
    If (!IsSet(EnableLogging)) {
        EnableLogging := true
    }
    Static isWritingToLog := false
    If (TimestampLogs) {
        logmessage := time ' ' logmessage '`r`n'
    } Else {
        logmessage := logmessage '`r`n'
    }
    OutputDebug(logmessage)
    If (!EnableLogging) {
        Return
    }
    k := 0
    Try {
        If (!isWritingToLog) {
            isWritingToLog := true
            Sleep(1)
            FileAppend(logmessage, logfile)
            isWritingToLog := false

        }
    } Catch As exc {
        If (TimestampLogs) {
            OutputDebug(time " LogError: Error writing to log - " exc.Message "`r`n"
            )
            ; MsgBox("Error writing to log:`n" exc.Message)
            Sleep(1)
            FileAppend(logmessage, logfile)
            Sleep(1)
            FileAppend(time " LogError: Error writing to log - " exc.Message '`r`n',
                logfile)
        } Else {
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
    If (!Debug) {
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
    If (!Verbose) {
        Return
    }
    Log(logmessage)
}

/**
 * Log callstack for Deprecated functions that need removal to be located
 */
StackLog() {
    If (!Debug) {
        Return
    }
    VerboseLog("Stack:" Error().Stack)
}

/**
 * Log error information and stack
 * @param {Error} error 
 */
ErrorLog(error) {
    DebugLog("Error:" error.Message "`n ErrorExtra: " error.Extra "`nStack: " error()
        .Stack)
}

/**
 * Log callstack for Deprecated functions that need removal to be located
 */
Deprecated() {
    If (!Debug) {
        Return
    }
    VerboseLog("Deprecated:" Error().Stack)
}