#Requires AutoHotkey v2.0

/**
 * Log callstack for Deprecated functions that need removal to be located
 */
Deprecated() {
    Out.Error("Deprecated function called.")
    Out.Stack()
}

/**
 * Used in cSettings.initSettings after load of settings
 */
UpdateDebugLevel() {
    Global EnableLogging, Debug, Verbose
    if (FileExist(A_ScriptDir "\IsNobody")) {
        Out.DebugLevel := 3
        Out.I("Set debug output to full.")
        return
    }
    if (Verbose) {
        Out.DebugLevel := 2
        Out.I("Set debug output to verbose.")
        return
    }
    if (Debug) {
        Out.DebugLevel := 1
        Out.I("Set debug output to debug.")
        return
    }
    if (EnableLogging) {
        Out.DebugLevel := 0
        Out.I("Set debug output to important only.")
        return
    } else {
        Out.DebugLevel := -1
        Out.I("Set debug output to none.")
        return
    }
}

/**
 * Log class to handle file open buffer and logging
 * @module cLog
 * @property {Type} property Desc
 * @method Name Desc
 */
Class cLog {
    /** @type {File} Open file handle for logging object */
    _FileHandle := false
    /** @type {String} Desc */
    FileName := ""
    /** @type {Boolean} Desc */
    Timestamp := true
    /** @type {Integer} Int to select the debug output level for logging
     * -1 disabled (Msgboxs errors on failure)
     * 0 Important
     * 1 Important and Debug
     * 2 Important, Debug and Verbose
     * 3 Important, Debug, Verbose and Stack tracing
     */
    DebugLevel := -1
    /** @type {Boolean} Lock to avoid overlapping file commands */
    _FileLock := false
    /** @type {Boolean} Use an open file handle or directly write logs */
    _Buffer := true

    /**
     * Constructor for logging object, opens file handle when created
     * @param {String} [FileName] Sets this.FileName, defaults to scriptname.Log
     * @param {Integer} [Timestamp=true] Sets if timestamps should be used
     * @param {Integer} [DebugLevel=0] Int to select the debug output level for logging
     * -1 disabled (Msgboxs errors on failure)
     * 0 Important
     * 1 Important and Debug
     * 2 Important, Debug and Verbose
     * 3 Important, Debug, Verbose and Stack tracing
     */
    __New(FileName := "", Timestamp := true, DebugLevel := 0, UseBuffer := true
    ) {
        If (FileName = "") {
            this.FileName := A_ScriptDir "\" StrReplace(A_ScriptName, ".ahk",
                "") ".log"
        } Else {
            this.FileName := FileName
        }
        this.Timestamp := Timestamp
        this.DebugLevel := DebugLevel
        this._Buffer := UseBuffer
        If (this._Buffer) {
            Try {
                this._FileHandle := FileOpen(this.FileName, "a-d")
            } Catch (Error) {
                MsgBox("Could not open " this.FileName " to write logs to.`r`n"
                )
                OutputDebug("Could not open " this.FileName " to write logs to.`r`n"
                )
            }
        }
        ; Repeatedly flush the file every 5 seconds to avoid buffering for long
        ;SetTimer(this._FlushFile.Bind(this), 1000)
    }

    __Delete() {
        If (Type(this._FileHandle) = File) {
            this._FileHandle.Close()
        }
    }

    ;@region _FlushFile()
    /**
     * Write file, close and reopen handle
     */
    _FlushFile() {
        If (this._FileLock) {
            While (this._FileLock) {
                Sleep(1)
            }
        }
        this._FileLock := true
        If (Type(this._FileHandle) = File) {
            Try {
                Sleep(3)
                this._FileHandle.Close()
                this._FileHandle := FileOpen(this.FileName, "a-d")
                Sleep(3)
            } Catch (Error) {
                MsgBox("Could not reopen " this.FileName " to write logs to.`r`n"
                )
                OutputDebug("Could not reopen " this.FileName " to write logs to.`r`n"
                )
            }
        }
        this._FileLock := false
    }
    ;@endregion

    ;@region _OutputOut.I()
    /**
     * Output message to log of whatever debug level requires output
     */
    _OutputLog(logmessage) {
        If (this._Buffer) {
            this._OutputLogBuffered(logmessage)
        } Else {
            this._OutputLogWrite(logmessage)
        }
    }
    ;@endregion

    ;@region _OutputLogBuffered()
    /**
     * Output using file buffer handle
     */
    _OutputLogBuffered(logmessage) {
        Static LastFlush := 0
        If (LastFlush > 4) {
            this._FlushFile()
            LastFlush := 0
        }
        LastFlush++
        If (this.Timestamp) {
            time := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec)
            logmessage := time ' ' logmessage
        }
        OutputDebug(logmessage "`r`n")
        If (this.DebugLevel < 0 || !this._FileHandle) {
            Return
        }
        Try {
            If (!this._FileLock) {
                this._FileLock := true
                this._FileHandle.WriteLine(logmessage)
                this._FileLock := false
            } Else {
                OutputDebug(
                    "Was trying to log but blocked on last message.`r`n")
            }
        } Catch As exc {
            If (this.Timestamp) {
                OutputDebug(time " LogError: Error writing to log - " exc.Message "`r`n"
                )
                Sleep(1)
                this._FileHandle.WriteLine(logmessage)
                Sleep(1)
                this._FileHandle.WriteLine(time " LogError: Error writing to log - " exc
                    .Message)
            } Else {
                OutputDebug("LogError: Error writing to log - " exc.Message "`r`n"
                )
                Sleep(1)
                this._FileHandle.WriteLine(logmessage)
                Sleep(1)
                this._FileHandle.WriteLine("LogError: Error writing to log - " exc
                    .Message)
            }
        }
    }
    ;@endregion

    ;@region _OutputLogWrite()
    /**
     * Direct write log without file handle (more intense file usage)
     */
    _OutputLogWrite(logmessage) {
        If (this.Timestamp) {
            time := FormatTime(, 'MM/dd/yyyy hh:mm:ss:' A_MSec)
            logmessage := time ' ' logmessage
        }
        OutputDebug(logmessage "`r`n")
        If (this.DebugLevel < 0) {
            Return
        }
        Try {
            If (!this._FileLock) {
                this._FileLock := true
                FileAppend(logmessage, this.FileName)
                this._FileLock := false
            } Else {
                OutputDebug(
                    "Was trying to log but blocked on last message.`r`n")
            }
        } Catch As exc {
            If (this.Timestamp) {
                OutputDebug(time " LogError: Error writing to log - " exc.Message "`r`n"
                )
                Sleep(1)
                FileAppend(logmessage, this.FileName)
                Sleep(1)
                FileAppend(time " LogError: Error writing to log - " exc.Message,
                    this.FileName)
            } Else {
                OutputDebug("LogError: Error writing to log - " exc.Message "`r`n"
                )
                Sleep(1)
                FileAppend(logmessage, this.FileName)
                Sleep(1)
                FileAppend("LogError: Error writing to log - " exc.Message,
                    this.FileName)
            }
        }
    }
    ;@endregion

    ;@region Error()
    /**
     * Critical error logging messages
     * @param {string|error} out Output error message or error object
     */
    Error(out) {
        If (Type(out) = Error) {
            ; Log the error, outputlog only posts outputdebug if logging is off
            ; if debuglevel is off msgbox it
            this._OutputLog("Error: " out.Message)
            this._OutputLog("ErrorExtra: " out.Extra)
            this._OutputLog("Stack: " out.Stack)
            ; If we are not logging msgbox it
            If (this.DebugLevel <= -1) {
                MsgBox("Error: " out.Message "`r`n ErrorExtra: " out.Extra "`r`nStack: " out
                    .Stack)
                Window.Activate()
            }
        } Else {
            ; Log the error, outputlog only posts outputdebug if logging is off
            this._OutputLog("Error: " out)
            ; If we are not logging msgbox it
            If (this.DebugLevel <= -1) {
                MsgBox("Error: " out)
                Window.Activate()
            }
        }
    }
    ;@region E()
    /**
     * Critical error logging messages
     * @param {string|error} out Output error message or error object
     */
    E(out) {
        this.Error(out)
    }
    ;@endregion
    ;@endregion


    ;@region Important()
    /**
     * Important logging messages
     * @param {string} msg Output error message or error object
     */
    Important(msg) {
        If (this.DebugLevel > -1) {
            this._OutputLog("Important: " msg)
        }
    }
    ;@region I()
    /**
     * Important logging messages
     * @param {string} msg Output error message or error object
     */
    I(msg) {
        this.Important(msg)
    }
    ;@endregion
    ;@endregion

    ;@region Debug()
    /**
     * Debug logging messages
     * @param {string} msg Output error message or error object
     */
    Debug(msg) {
        If (this.DebugLevel > 0) {
            this._OutputLog("Debug: " msg)
        }

    }
    ;@region D()
    /**
     * Debug logging messages
     * @param {string} msg Output error message or error object
     */
    D(msg) {
        this.Debug(msg)
    }
    ;@endregion
    ;@endregion

    ;@region Verbose()
    /**
     * Verbose Logging for very frequent log entries
     * @param {string} msg Output error message or error object
     */
    Verbose(msg) {
        If (this.DebugLevel > 1) {
            this._OutputLog("Verbose: " msg)
        }

    }
    ;@region V()
    /**
     * Verbose Logging for very frequent log entries
     * @param {string} msg Output error message or error object
     */
    V(msg) {
        this.Verbose(msg)
    }
    ;@endregion
    ;@endregion

    ;@region Stack()
    /**
     * Stack logging
     */
    Stack() {
        If (this.DebugLevel > 2) {
            this._OutputLog("Stack:`r`n" Error().Stack)
        }
    }
    ;@region S()
    /**
     * Stack logging
     */
    S(msg) {
        this.Stack()
    }
    ;@endregion
    ;@endregion
}