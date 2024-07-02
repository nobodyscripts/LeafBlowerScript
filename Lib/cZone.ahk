#Requires AutoHotkey v2.0

#Include Navigate.ahk
#Include SettingsCheck.ahk
#Include cColours.ahk

/**
 * Base zone travel object
 * @property {String} Name The name of the zone for display purposes
 * @property {String} AreaColour The colour of the sample pixel for the zone
 * @property {Bool} BossTimer Require boss timer (or not) to match for success
 */
Class Zone {
    ; The name of the zone for display purposes
    Name := ""
    ; The colour of the sample pixel for the zone
    ZoneColour := ""
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Go to the zone base function, uses other functions in class to modifiy
     * target zone (don't use base Zone class directly)
     * @returns {Bool} 
     */
    GoTo() {
        if (!IsWindowActive()) {
            Log("No window found while trying to travel.")
            return false
        }
        global DisableZoneChecks
        i := 0
        if (!DisableZoneChecks) {
            Log("Traveling to " this.Name)
            ; Advantage of this sample check is script doesn't travel if already
            ; there and can recheck if travels failed
            while (!this.IsZoneColour() &&
                this.BossTimer = !IsBossTimerActive() &&
                i <= 4) {
                if (!IsWindowActive()) {
                    Log("No window found while trying to travel.")
                    return false
                }
                this.AttemptTravel(NavigateTime)
                i++
            }
        }
        if (this.IsZoneColour()) {
            DebugLog("Travel success to " this.Name)
            return true
        } else {
            Log("Traveling to " this.Name ". Attempt to blind travel with"
                " slowed times.")
            this.AttemptTravel(NavigateTime, 50, 200)
            if (DisableZoneChecks) {
                ; Checks are disabled so blindly trust we reached zone
                return true
            }
            if (this.IsZoneColour()) {
                DebugLog("Blind travel success to " this.Name)
                return true
            } else {
                Log("Traveling to " this.Name " failed, colour found was "
                    this.GetZoneColour())
                return false
            }
        }
    }

    /**
     * Blank function contains the code in extend to attempt one pass at travel
     * @param delay 
     * @param {Integer} scrolldelay 
     * @param {Integer} extradelay 
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
    }

    /**
     * Used in AttemptTravel to handle the button checks and press with delays
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
    }

    /**
     * Checks if zone is currently set to the zone required based on 
     * this.AreaColour
     * @returns {Integer} 
     */
    IsZoneColour() {
        sampleColour := this.GetZoneColour()
        If (sampleColour = this.ZoneColour) {
            ; Found target colour
            return true
        }
        DebugLog("IsZoneColour: Not in target zone, colour: " sampleColour)
        return false
    }

    /**
     * Get current zone colour sample to know what zone player is currently in
     * @returns {String} 
     */
    GetZoneColour() {
        return Points.ZoneSample.GetColour()
    }

    /**
     * Gets the colour the game needs to return to confirm current zone
     * @param name Full name string of zone found in ZoneColours
     * @returns {String} Colour string for zone check
     */
    GetColourByName(name) {
        return Colours().GetColourByZone(name)
    }

    /**
     * Swap tabs to reset scroll state in areas panel
     * @param {Integer} delay Extra delay to apply to NavigateTime
     */
    ResetAreaScroll(delay := 0) {
        NavTime := NavigateTime + delay
        if (NavTime < 72) {
            NavTime := 72
        }
        ; Click Favourites
        Points.Areas.Favs.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
        ; Click Back to default page to reset the scroll
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
        ; Double click for redundancy
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
    }

    /**
     * Scroll downwards in a panel by ticks
     * @param {number} amount (optional): default 1, amount to scroll in ticks
     * of mousewheel
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    ScrollAmountDown(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelDown")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }

    /**
     * Scroll upwards in a panel by ticks
     * @param {number} amount (optional): default 1, amount to scroll in ticks
     * of mousewheel
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    ScrollAmountUp(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelUp")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }
}
