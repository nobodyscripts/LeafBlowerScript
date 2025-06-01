#Requires AutoHotkey v2.0

#Include cGameWindow.ahk
#Include cGameStage.ahk

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
    _cooldownTimer := 0

    ; Period to run for (-1 to disable)
    RunFor := -1
    ; Cooldown after stopping before task can run again (-1 if no cooldown)
    Cooldown := -1
    ; What loadout the task needs (-1 if no loadout)
    Loadout := -1
    ; What Zone is needed for task
    Zone := ""
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
        Throw Error("No Task() set")
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
        Throw Error("No StopWhen() set")
    }
    ;@endregion

    ;@region Run()
    /**
     * Execute pretask, task and posttask once
     * @returns {Boolean} Has run
     */
    Run() {
        If (!Window.IsActive() || this.IsOnCooldown()) {
            Return false
        }
        this._isRunning := true
        this.PreTask()
        this.Task()
        this.PostTask()
        this._startCooldown()
        this._isRunning := false
        Return true
    }
    ;@endregion

    ;@region RunIn()
    /**
     * Run task in ms time (Avoid using as breaks thread)
     * @param secs Delay period
     */
    RunIn(secs) {
        SetTimer(this.Run.Bind(this), -(secs * 1000))
    }
    ;@endregion

    ;@region LoopIn()
    /**
     * Run task loop in ms time (Avoid using as breaks thread)
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
        If (!Window.IsActive() || this.IsOnCooldown()) {
            Return false
        }
        this._isRunning := this._isLooping := true
        this._startTime := A_Now
        this.PreTask()
        ; Break if provided check, timer or manual stop change
        While (this.StopWhen() && this._isLooping && this.WithinRunFor() &&
        Window.IsActive()) {
            If (!this.Task()) {
                Break
            }
        }
        If (Window.IsActive()) {
            this.PostTask()
        }
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
        Return this._isRunning
    }

    /**
     * Get looping state
     */
    IsLooping() {
        Return this._isLooping
    }

    /**
     * Returns Cooldown state (period after use that Run should be blocked)
     * @returns {Boolean} State
     */
    IsOnCooldown() {
        If (this.Cooldown = -1 || this._cooldownTimer = 0) {
            Return false
        }
        Return DateDiff(A_Now, this._cooldownTimer, "Seconds") <= this._cooldownTimer
    }
    ;@endregion

    ;@region WithinRunFor()
    /**
     * Check if within runfor period or if -1
     * @returns {Boolean} True if within runfor period, false if not
     */
    WithinRunFor() {
        If (this.RunFor = -1) {
            Return true
        }
        If (DateDiff(A_Now, this._startTime, "Seconds") <= this.RunFor) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Private Methods
    _startCooldown() {
        this._cooldownTimer := A_Now
    }
    ;@endregion
    ;@endregion
}
