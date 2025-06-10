#Requires AutoHotkey v2.0

If (!IsSet(Out)) {
    /**
     * Out cLog class global
     * @type {cLog} */
    Global Out := cLog()
}

/**
 * Log class to handle file open buffer and logging
 * Recommend use as global var 'Out' for on exit logging
 * @module cLog
 * Constructor(FileName := "", Timestamp := true, DebugLevel := 0, UseBuffer := true)
 * @param {String} [FileName] Sets this.FileName, defaults to scriptname.Log
 * @param {Boolean} [Timestamp=true] Sets if timestamps should be used
 * @param {Integer} [DebugLevel=0] Int to select the debug output level for logging
 * 
 * -1 disabled (Msgboxs errors on failure)
 * 
 * 0 Important
 * 
 * 1 Important and Verbose
 * 
 * 2 Important, Debug and Verbose
 * 
 * 3 Important, Debug, Verbose and Stack tracing
 * 
 * @param {Boolean} [UseBuffer=false] Set if buffed periodic logging should be used
 * for reduced disk writes
 * 
 * @property FileName Filename to log to
 * @property DebugLevel See above
 * @property Timestamp Is timestamp included in logs
 * @property Enabled Is logging enabled, used to disable for a period
 * @method Disable Is used to disable logging
 * @method Enable Is used to enable logging
 * @method SetBuffer Set direct log/buffered logging mode
 * @method Error Log an error that has occured (string|error)
 * @method Important Log an important message (string)
 * @method I Log an important message (string)
 * @method Debug Log a debug only message (string)
 * @method D Log a debug only message (string)
 * @method Verbose Log a verbose/spammy message (string)
 * @method V Log a verbose/spammy message (string)
 * @method Stack Log a stack trace
 * @method S Log a stack trace
 * @example Global Out := cLog(A_ScriptDir "\Filename.log", true, 3, true)
 */
Class cLog {
    /** @type {File} Open file handle for logging object */
    _FileHandle := false
    /** @type {String} Desc */
    FileName := ""
    /** @type {Boolean} Desc */
    Timestamp := true
    /** @type {Boolean} Desc */
    Enabled := true
    /** @type {Integer} Int to select the debug output level for logging
     * -1 disabled (Msgboxs errors on failure)
     * 0 Important
     * 1 Important and Verbose
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
     * @param {Integer} [DebugLevel=0] Int to select the debug output level for 
     * logging
     * 
     * -1 disabled (Msgboxs errors on failure)
     * 
     * 0 Important
     * 
     * 1 Important and Verbose
     * 
     * 2 Important, Debug and Verbose
     * 
     * 3 Important, Debug, Verbose and Stack tracing
     * 
     * @param {Boolean} [UseBuffer=false] Set if buffed periodic logging should be 
     * used for reduced disk writes
     */
    __New(FileName := "", Timestamp := true, DebugLevel := 0, UseBuffer := false
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
            this._OpenHandle()
        }
    }

    _OpenHandle() {
        Static bufferedLogToggle := false
        Try {
            If (this.FileName = "") {
                OutputDebug("Filename was blank when opening")
                Throw Error("Could not open a file to log to as non provided")
            }
            this._FileHandle := FileOpen(this.FileName, "a-d")
            If (!FileExist(this.FileName)) {
                this._OutputDebug(this._FileHandle.Handle)
                Throw Error("File didn't exist after fileopen")
            }
            If (!bufferedLogToggle) {
                this.V(A_ScriptName " logging to " this.FileName)
                bufferedLogToggle := true
            }
        } Catch (Error) {
            MsgBox("Could not open " this.FileName " to write logs to.")
            this._OutputDebug("Could not open " this.FileName
                " to write logs to.")
        }
    }

    _CloseHandle() {
        If (!FileExist(this.FileName)) {
            this._FileHandle := false
            Return
        }
        If (FileGetSize(this.FileName, "B") = 0 && this._FileHandle.Pos != 0) {
            this._FileHandle.Close()
            FileDelete(this.FileName)
            this._FileHandle := false
            Return
        }
        If (Type(this._FileHandle) = "File") {
            this._FileHandle.Close()
        }
        this._FileHandle := false
    }

    ;@region _FlushFile()
    /**
     * Write file, close and reopen handle
     */
    _FlushFile() {
        Try {
            If (this._FileLock) {
                WaitTime := A_TickCount
                While (this._FileLock && (A_TickCount - WaitTime) < 200) {
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
        } Catch Error As err {
            this._OutputDebug(err.Message)
        }
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
        } Else {
            this._CloseHandle()
            Sleep(15)
        }
    }
    ;@endregion

    ;@region _OutputDebug()
    /**
     * Stack a newline on each output
     * @param text 
     */
    _OutputDebug(text) {
        If (this.Enabled) {
            OutputDebug(text "`r`n")
        }
    }
    ;@endregion

    ;@region _OutputLog()
    /**
     * Output message to log of whatever debug level requires output
     */
    _OutputLog(logmessage) {
        If (this.Enabled) {
            Try {
                If (this._Buffer) {
                    this._OutputLogBuffered(logmessage)
                } Else {
                    this._OutputLogWrite(logmessage)
                }
            } Catch Error As err {
                this._OutputDebug(err.Message)
            }
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
            LastFlush := 0
            this._FlushFile()
        }
        LastFlush++
        If (this.Timestamp) {
            time := FormatTime(, 'MM/dd/yyyy hh:mm:ss.' A_MSec)
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
            time := FormatTime(, 'MM/dd/yyyy hh:mm:ss.' A_MSec)
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

    ;@region Enable()
    /**
     * 
     */
    Enable() {
        this._OpenHandle()
        this.Enabled := true
    }
    ;@endregion

    ;@region Disable()
    /**
     * 
     */
    Disable() {
        this._CloseHandle()
        this.Enabled := false
    }
    ;@endregion

    ;@region Error()
    /**
     * Critical error logging messages
     * @param {string|error} out Output error message or error object
     */
    Error(out) {
        If (InStr(Type(out), "Error")) {
            ; Log the error, outputlog only posts outputdebug if logging is off
            ; if debuglevel is off msgbox it
            this._OutputLog("Error: " out.Message)
            this._OutputLog("ErrorExtra: " out.Extra)
            this._OutputLog("Stack: " out.Stack)
            ; If we are not logging msgbox it
            If (this.DebugLevel <= -1) {
                MsgBox("Error: " out.Message "`r`n ErrorExtra: " out.Extra "`r`nStack: " out
                    .Stack, , 0x10)
                If (IsSet(Window) && Window.Exist()) {
                    Window.Activate()
                }
            }
        } Else {
            ; Log the error, outputlog only posts outputdebug if logging is off
            this._OutputLog("Error: " out)
            ; If we are not logging msgbox it
            If (this.DebugLevel <= -1) {
                MsgBox("Error: " out, , 0x10)
                If (IsSet(Window) && Window.Exist()) {
                    Window.Activate()
                }
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
        If (this.DebugLevel > 1) {
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
        If (this.DebugLevel > 0) {
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

    ;@region LoopWrite()
    LoopWrite(msg) {
        written := false
        While (!written) {
            Sleep(1)
            Try {
                FileAppend(msg, this.FileName)
            } Catch Error As wrerr {
                this._OutputDebug("Logging failure " wrerr.Message " " wrerr.Extra)
                this._OutputDebug("Logging failure sending: " msg)
                written := false
            } Else {
                written := true
            }
        }
    }
    ;@endregion

    ;@region UpdateSettings()
    /**
     * Used in to update logging settings after load
     */
    UpdateSettings(EnableLogging, Verbose, Debug, DebugAll, LogBuffer, TimestampLogs) {
        ; If buffer setting has changed, remake class so that handle can be created
        this.SetBuffer(LogBuffer)
        this.Timestamp := TimestampLogs

        If (DebugAll) {
            this.DebugLevel := 3
            this.I("Set debug output to full.")
            Return
        }
        If (Debug) {
            this.DebugLevel := 2
            this.I("Set debug output to debug.")
            Return
        }
        If (Verbose) {
            this.DebugLevel := 1
            this.I("Set debug output to verbose.")
            Return
        }
        If (EnableLogging) {
            this.DebugLevel := 0
            this.I("Set debug output to important only.")
            Return
        }
        this.DebugLevel := -1
        this.I("Set debug output to none.")
        Return
    }
    ;@endregion

    ;@region Deprecated()
    /**
     * Log callstack for Deprecated functions that need removal to be located
     */
    Deprecated() {
        this.Error("Deprecated function called.")
        this.Stack()
    }
    ;@endregion
}

OnExit(ExitFunc)
ExitFunc(ExitReason, ExitCode) {
    Global Out
    If (IsSet(Out) && Type(Out) = "cLog") {
        Out.I("Script exiting. Due to " ExitReason ".")
    }
}
