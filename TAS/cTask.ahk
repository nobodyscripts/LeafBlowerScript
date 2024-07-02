#Requires AutoHotkey v2.0

#Include cGameStage.ahk
#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTimer.ahk

/**
 * Class to encapsulate tasks, allowing generic activation and control
 * @property {Integer} RunFor Period to run for (-1 to disable)
 * @property {Integer} Cooldown Cooldown after stopping before task can run 
 * again (-1 if no cooldown)
 * @property {Integer} Loadout What loadout the task needs (-1 if no loadout)
 * @property {Zone} Zone What Zone is needed for task
 * @property {cGameStage} Stage Progress stage to run task at
 */
Class cTask {
    ;@region Properties
    ; @private Starting time of loop for timer calculations
    _startTime := 0
    ; @private Is task looping (using a Loop not Run)
    _isLooping := false
    ; @private Is task running
    _isRunning := false
    ; @private Contains state of cooldown period
    _cooldownState := false

    ; Period to run for (-1 to disable)
    RunFor := -1
    ; Cooldown after stopping before task can run again (-1 if no cooldown)
    Cooldown := -1
    ; What loadout the task needs (-1 if no loadout)
    Loadout := -1
    ; What Zone is needed for task
    Zone := Zone().Any()
    ; Progress stage to run task at
    Stage := cGameStage().Any()
    ;@endregion

    ;@region Placeholders
    /**
     * To complete for uses of the class 
     */
    PreTask() {
    }

    /**
     * To complete for uses of the class. 
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        throw Error("No Task() set")
        return false
    }

    /**
     * To complete for uses of the class 
     */
    PostTask() {
    }
    ;@endregion

    ;@region Methods
    ;@region StopWhen()
    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
        throw Error("No StopWhen() set")
    }
    ;@endregion

    ;@region Run()
    /**
     * Execute pretask, task and posttask once
     */
    Run() {
        this._isRunning := true
        this.PreTask()
        this.Task()
        this.PostTask()
        this._startCooldown()
        this._isRunning := false
    }
    ;@endregion

    ;@region RunIn()
    /**
     * Run task in ms time
     * @param secs Delay period
     */
    RunIn(secs) {
        SetTimer(this.Run.Bind(this), -(secs * 1000))
    }
    ;@endregion

    ;@region LoopIn()
    /**
     * Run task loop in ms time
     * @param seconds Delay period
     */
    LoopIn(seconds) {
        SetTimer(this.Loop.Bind(this), -(seconds * 1000))
    }
    ;@endregion

    ;@region Loop()
    /**
     * Executes the task as a loop stopping when this.StopWhen() is true
     * if this._isLooping is false due to this.Stop() or if (this.RunFor) runs
     * out
     */
    Loop() {
        this._isRunning := this._isLooping := true
        this._startTime := A_now
        this.PreTask()
        ; Break if provided check, timer or manual stop change
        while (this.StopWhen() && this._isLooping && this.WithinRunFor()) {
            if (!this.Task()) {
                break
            }
        }
        this.PostTask()
        this._startCooldown()
        this._isLooping := this._isRunning := false
    }
    ;@endregion

    ;@region Stop()
    /**
     * Stop running loop of task
     */
    Stop() {
        this._isLooping := false
    }
    ;@endregion

    ;@region Is functions
    /**
     * Get running state
     */
    IsRunning() {
        return this._isRunning
    }

    /**
     * Get looping state
     */
    IsLooping() {
        return this._isLooping
    }

    /**
     * Returns Cooldown state (period after use that Run should be blocked)
     * @returns {Boolean} State
     */
    IsOnCooldown() {
        if (this.Cooldown = -1) {
            return false
        }
        return this._cooldownState
    }
    ;@endregion

    ;@region WithinRunFor()
    /**
     * Check if within runfor period or if -1
     * @returns {Boolean} True if within runfor period, false if not
     */
    WithinRunFor() {
        if (this.RunFor = -1) {
            return true
        }
        if (DateDiff(A_Now, this._startTime, "Seconds") <= this.RunFor) {
            return true
        }
        return false
    }
    ;@endregion

    ;@region Private Methods
    _startCooldown() {
        Timer().CoolDownS(this.Cooldown, &this._cooldownState)
    }
    ;@endregion
    ;@endregion
}
