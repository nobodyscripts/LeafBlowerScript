#Requires AutoHotkey v2.0

/**
 * Log callstack for Deprecated functions that need removal to be located
 */
Deprecated() {
    Out.Error("Deprecated function called.")
    Out.Stack()
}

/*
DefProp := {}.DefineProp

DefProp(Error.Base, "toString", {get: ErrorToString })
DefProp(OSError.Base, "toString", {get: ErrorToString })

ErrorToString(err) {
    return err.Message " " err.Extra
} */

/**
 * Modify OutputDebug to add a newline by default
 */
/* OutputDebug.DefineProp("Call", {
    Call: _OutputDebug
})

_OutputDebug(this, text) {
    text := text "`r`n"
    (Func.Prototype.Call)(this, text)
} */

/**
 * Used in cSettings.initSettings after load of settings
 */
UpdateDebugLevel() {
    Global EnableLogging, Debug, Verbose, LogBuffer, Out
    ; If buffer setting has changed, remake class so that handle can be created
    Out.SetBuffer(LogBuffer)

    If (FileExist(A_ScriptDir "\IsNobody")) {
        Out.DebugLevel := 3
        Out.I("Set debug output to full.")
        Return
    }
    If (Verbose) {
        Out.DebugLevel := 2
        Out.I("Set debug output to verbose.")
        Return
    }
    If (Debug) {
        Out.DebugLevel := 1
        Out.I("Set debug output to debug.")
        Return
    }
    If (EnableLogging) {
        Out.DebugLevel := 0
        Out.I("Set debug output to important only.")
        Return
    } Else {
        Out.DebugLevel := -1
        Out.I("Set debug output to none.")
        Return
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
     * Overwrites to ..\Secondaries.log if IsSecondary
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
        If (IsSecondary) {
            this.FileName := A_ScriptDir "\..\Secondaries.log"
        }
        this.Timestamp := Timestamp
        this.DebugLevel := DebugLevel
        this._Buffer := UseBuffer
        If (this._Buffer) {
            this._OpenHandle()
        }
        ; Repeatedly flush the file every 5 seconds to avoid buffering for long
        ;SetTimer(this._FlushFile.Bind(this), 1000)
    }

    __Delete() {
        this._CloseHandle()
    }

    _OpenHandle() {
        Try {
            this._FileHandle := FileOpen(this.FileName, "a-d")
            this._OutputDebug("Logging to " this.FileName)
        } Catch (Error) {
            MsgBox("Could not open " this.FileName " to write logs to.")
            this._OutputDebug("Could not open " this.FileName
                " to write logs to.")
        }
    }

    _CloseHandle() {
        If (Type(this._FileHandle) = File) {
            this._FileHandle.Close()
        }
        this._FileHandle := false
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
        Sleep(3)
        this._CloseHandle()
        Sleep(10)
        this._OpenHandle()
        Sleep(3)
        this._FileLock := false
    }
    ;@endregion

    ;@region SetBuffer(LogBuffer)
    /**
     * Description
     */
    SetBuffer(LogBuffer) {
        this._Buffer := LogBuffer
        If (LogBuffer) {
            this._OpenHandle()
            this.I("Log set to buffer mode")
        } Else {
            this._CloseHandle()
            Sleep(15)
            this.I("Log set to instant mode")
        }
    }
    ;@endregion

    ;@region _OutputDebug()
    /**
     * Stack a newline on each output
     * @param text 
     */
    _OutputDebug(text) {
        OutputDebug(text "`r`n")
    }
    ;@endregion

    ;@region _OutputLog()
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
        this._OutputDebug(logmessage)
        If (this.DebugLevel < 0 || !this._FileHandle) {
            Return
        }
        Try {
            If (!this._FileLock) {
                this._FileLock := true
                this._FileHandle.WriteLine(logmessage)
                this._FileLock := false
            } Else {
                this._OutputDebug("Was trying to log but blocked on last message.")
            }
        } Catch As exc {
            If (this.Timestamp) {
                this._OutputDebug(time " LogError: Error writing to log - " 
                exc.Message)
                Sleep(1)
                this._FileHandle.WriteLine(logmessage)
                Sleep(1)
                this._FileHandle.WriteLine(time 
                    " LogError: Error writing to log - " exc.Message)
            } Else {
                this._OutputDebug("LogError: Error writing to log - " 
                exc.Message)
                Sleep(1)
                this._FileHandle.WriteLine(logmessage)
                Sleep(1)
                this._FileHandle.WriteLine("LogError: Error writing to log - " 
                exc.Message)
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
        this._OutputDebug(logmessage)
        If (this.DebugLevel < 0) {
            Return
        }
        Try {
            If (!this._FileLock) {
                this._FileLock := true
                this.LoopWrite(logmessage "`r`n")
                this._FileLock := false
            } Else {
                this._OutputDebug(
                    "Was trying to log but blocked on last message.")
            }
        } Catch As exc {
            If (this.Timestamp) {
                this._OutputDebug(time " LogError: Error writing to log - " exc
                    .Message)
                this.LoopWrite(logmessage "`r`n")
                this.LoopWrite(time " LogError: Error writing to log - " exc.Message
                    "`r`n")
            } Else {
                this._OutputDebug("LogError: Error writing to log - " exc.Message)
                this.LoopWrite(logmessage "`r`n")
                this.LoopWrite("LogError: Error writing to log - " exc.Message "`r`n")
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
    S() {
        this.Stack()
    }
    ;@endregion
    ;@endregion

    LoopWrite(msg) {
        written := false
        While (!written) {
            Sleep(1)
            Try {
                FileAppend(msg, this.FileName)
            } Catch Error As err {
                this._OutputDebug("Logging failure " err.Message " " err.Extra)
                this._OutputDebug("Logging failure sending: " msg)
                written := false
            } Else {
                written := true
            }
        }
    }
}
