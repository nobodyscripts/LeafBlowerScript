#Requires AutoHotkey v2.0

/**
 * Timer class
 * @property Running Timer active state
 * @property StartedAt Timer running start Time
 * @method CoolDown(Time, Bool) Wait for time (ms), then set bool false
 * @method CoolDownS(Time, Bool) Wait for time (s), then set bool false
 * @method CoolDownM(Time, Bool) Wait for time (m), then set bool false
 */
Class Timer {
    /** @type {Boolean} Timer active state */
    Running := false
    /** @type {Integer} Timer running start time */
    StartedAt := 0

    /**
     * Wait period, then change &bool to false
     * @param Time (ms) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDown(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle.Bind(this), -Time)

        toggle(*) {
            bool := false
            this.Running := false
        }
    }

    /**
     * Wait period, then change &bool to false
     * @param Time (sec) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDownS(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle.Bind(this), -(Time * 1000))

        toggle(*) {
            bool := false
            this.Running := false
        }
    }

    /**
     * Wait period, then change &bool to false
     * @param Time (mins) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDownM(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle.Bind(this), -(Time * 60 * 1000))

        toggle(*) {
            bool := false
            this.Running := false
        }
    }
}
