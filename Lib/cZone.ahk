#Requires AutoHotkey v2.0

#Include Navigate.ahk
#Include cGameWindow.ahk
#Include cColours.ahk
#Include cTravel.ahk

/**
 * Base zone travel object
 * @property {String} Name The name of the zone for display purposes
 * @property {String} AreaColour The colour of the sample pixel for the zone
 * @property {Boolean} BossTimer Require boss timer (or not) to match for success
 * @function GoTo Go to the zone defined in the extended version of this class
 */
Class Zone {
    ;@region Properties
    /**
     * The name of the zone for display purposes
     * @type {String} 
     */
    Name := ""
    /**
     * The colour of the sample pixel for the zone
     * @type {String} 
     */
    ZoneColour := ""
    /**
     * Require boss timer (or not) to match for success
     * @type {Boolean} 
     */
    BossTimer := false
    ;@endregion

    ;@region GoTo()
    /**
     * Go to the zone base function, uses other functions in class to modifiy
     * target zone (don't use base Zone class directly)
     * @returns {Boolean} True if travel success, false if travel failed
     */
    GoTo() {
        If (!Window.IsActive()) {
            Log("No window found while trying to travel.")
            Return false
        }
        Global DisableZoneChecks
        i := 0
        If (!DisableZoneChecks) {
            Log("Traveling to " this.Name)
            ; Advantage of this sample check is script doesn't travel if already
            ; there and can recheck if travels failed
            While (!this.IsZoneColour() && this.BossTimer = !IsBossTimerActive() &&
                i <= 4) {
                If (!Window.IsActive()) {
                    Log("No window found while trying to travel.")
                    Return false
                }
                this.AttemptTravel(NavigateTime)
                i++
            }
        }
        If (this.IsZoneColour()) {
            DebugLog("Travel success to " this.Name)
            Return true
        } Else {
            Log("Traveling to " this.Name ". Attempt to blind travel with"
                " slowed times.")
            this.AttemptTravel(NavigateTime, 50, 200)
            If (DisableZoneChecks) {
                ; Checks are disabled so blindly trust we reached zone
                Return true
            }
            If (this.IsZoneColour()) {
                DebugLog("Blind travel success to " this.Name)
                Return true
            } Else {
                Log("Traveling to " this.Name " failed, colour found was " this
                    .GetZoneColour())
                Return false
            }
        }
    }
    ;@endregion

    ;@region Placeholders
    /**
     * Blank function contains the code in extend to attempt one pass at travel
     * @param delay 
     * @param {Integer} [scrolldelay=0] 
     * @param {Integer} [extradelay=0] 
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
    ;@endregion

    ;@region IsZoneColour()
    /**
     * Checks if zone is currently set to the zone required based on 
     * this.AreaColour
     * @returns {Boolean} 
     */
    IsZoneColour() {
        sampleColour := this.GetZoneColour()
        If (sampleColour = this.ZoneColour) {
            ; Found target colour
            Return true
        }
        DebugLog("IsZoneColour: Not in target zone, colour: " sampleColour)
        Return false
    }
    ;@endregion

    ;@region GetZoneColour()
    /**
     * Get current zone colour sample to know what zone player is currently in
     * @returns {String} 
     */
    GetZoneColour() {
        Return Points.ZoneSample.GetColour()
    }
    ;@endregion

    ;@region GetColourByName()
    /**
     * Gets the colour the game needs to return to confirm current zone
     * @param name Full name string of zone found in ZoneColours
     * @returns {String} Colour string for zone check
     */
    GetColourByName(name) {
        Return Colours().GetColourByZone(name)
    }
    ;@endregion

    ;@region ResetAreaScroll()
    /**
     * Swap tabs to reset scroll state in areas panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetAreaScroll(delay := 0) {
        Travel.ResetAreaScroll(delay)
    }
    ;@endregion

    ;@region ScrollAmountDown()
    /**
     * Scroll downwards in a panel by ticks
     * @param {number} [amount=1] Amount to scroll in ticks of mousewheel
     * @param {number} [extraDelay=0] Add ms to the sleep timers
     */
    ScrollAmountDown(amount := 1, extraDelay := 0) {
        Travel.ScrollAmountDown(amount, extraDelay)
    }
    ;@endregion

    ;@region ScrollAmountUp()
    /**
     * Scroll upwards in a panel by ticks
     * @param {number} [amount=1] Amount to scroll in ticks of mousewheel
     * @param {number} [extraDelay=0] Add ms to the sleep timers
     */
    ScrollAmountUp(amount := 1, extraDelay := 0) {
        Travel.ScrollAmountUp(amount, extraDelay)
    }
    ;@endregion
}