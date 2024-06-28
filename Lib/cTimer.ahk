#Requires AutoHotkey v2.0

/**
 * Timer class
 */
Class Timer {
    /** @type {Boolean} Timer active state */
    Running := false
    /** @type {Integer} Timer running start time */
    StartedAt := 0

    /**
     * Wait period, then change this.isOnCD to false
     * @param Time (ms) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDown(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle, -Time)

        toggle() {
            bool := false
            this.Running := false
        }
    }

    /**
     * Wait period, then change this.isOnCD to false
     * @param Time (sec) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDownS(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle, -(Time * 1000))

        toggle() {
            bool := false
            this.Running := false
        }
    }

    /**
     * Wait period, then change this.isOnCD to false
     * @param Time (mins) Time to cool down for
     * @param bool ByRef boolean of state
     */
    CoolDownM(Time, &bool) {
        bool := true
        this.Running := true
        this.StartedAt := A_Now
        SetTimer(toggle, -(Time * 60 * 1000))

        toggle() {
            bool := false
            this.Running := false
        }
    }
}