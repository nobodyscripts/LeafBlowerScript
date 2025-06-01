#Requires AutoHotkey v2.0

#Include cGameWindow.ahk
#Include cLogging.ahk

/**
 * Client script controls scripts which run in the background or 
 * perform alt tasks as if multithreaded
 * @module cClientScript
 * @property PID Tracks PID of client script
 * @method Start Start client script
 * @method IsActive Is client script active
 * @method Stop Stop client script
 * 
 */
Class cClientScript {
    PID := 0
    /** @example A_ScriptDir "\Secondaries\Script.ahk" */
    ScriptPath := ""
    /** @example "Script.ahk" */
    ScriptName := ""

    ;@region Start()
    /**
     * Start normal boss spammer
     */
    Start() {
        If (Window.IsActive()) {
            Run('"' A_AhkPath '" /restart "' this.ScriptPath '"', , , &OutPid)
            this.PID := OutPid
        }
    }
    ;@endregion

    ;@region IsActive()
    /**
     * Is Normal boss spammer active
     * @returns {Boolean} 
     */
    IsActive() {
        If ((this.PID && ProcessExist(this.PID)) ||
        WinExist(this.ScriptPath " ahk_class AutoHotkey"
        )) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Stop()
    /**
     * Stop process of normal boss spammer
     */
    Stop() {
        If (!this.IsActive()) {
            Return
        }
        If (this.PID && ProcessExist(this.PID)) {
            ProcessClose(this.PID)
            Out.I("Closed " this.ScriptName " using pid.")
        } Else {
            If (WinExist(this.ScriptPath " ahk_class AutoHotkey")) {
                WinClose(this.ScriptPath " ahk_class AutoHotkey")
                Out.I("Closed " this.ScriptName " using filename.")
            }
        }
    }
    ;@endregion
}
