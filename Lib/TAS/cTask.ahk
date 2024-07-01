#Requires AutoHotkey v2.0

#Include cProgress.ahk
#Include ..\cZone.ahk
#Include ..\cTimer.ahk

Class cTask {
    ; Is task looping (using a Loop not Run)
    _isLooping := false
    ; Is task running
    _isRunning := false
    ; Period to run for (-1 if no time limit)
    RunFor := -1
    ; Cooldown after stopping before task can run again (-1 if no cooldown)
    Cooldown := -1
    ; Contains state of cooldown period
    _cooldownState := false
    ; What loadout the task needs (-1 if no loadout)
    Loadout := -1
    ; What Zone is needed for task
    Zone := Zone().Any()
    ; Progress stage to run task at
    ProgressStage := Progress().Any()
    ; Starting time of loop for timer calculations
    StartTime := 0

    ; To complete for uses of the class
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

    ; To complete for uses of the class
    PostTask() {
    }

    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
        throw Error("No StopWhen() set")
    }

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

    /**
     * Run task in ms time
     * @param secs Delay period
     */
    RunIn(secs) {
        SetTimer(this.Run.Bind(this), -(secs * 1000))
    }

    /**
     * Run task loop in ms time
     * @param seconds Delay period
     */
    LoopIn(seconds) {
        SetTimer(this.Loop.Bind(this), -(seconds * 1000))
    }

    /**
     * Executes the task as a loop stopping when this.StopWhen() is true
     * if this._isLooping is false due to this.Stop() or if (this.RunFor) runs
     * out
     */
    Loop() {
        this._isRunning := this._isLooping := true
        this.StartTime := A_now
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

    /**
     * Stop running loop of task
     */
    Stop() {
        this._isLooping := false
    }

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

    /**
     * Check if within runfor period or if -1
     * @returns {Boolean} True if within runfor period, false if not
     */
    WithinRunFor() {
        if (this.RunFor = -1) {
            return true
        }
        if (DateDiff(A_Now, this.StartTime, "Seconds") <= this.RunFor) {
            return true
        }
        return false
    }

    _startCooldown() {
        Timer().CoolDownS(this.Cooldown, &this._cooldownState)
    }
}