#Requires AutoHotkey v2.0

#Include Navigate.ahk
#Include cColours.ahk
#Include cTravel.ahk

/**
 * Base zone travel object
 * @module Zone
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

    ;@region __Call() Handle to allow direct execution of the class
    __Call(Name, Params*) {
        this.GoTo()
    }
    ;@endregion

    ;@region GoTo()
    /**
     * Go to the zone base function, uses other functions in class to modifiy
     * target zone (don't use base Zone class directly)
     * @returns {Boolean} True if travel success, false if travel failed
     */
    GoTo(*) {
        NavigateTime := S.Get("NavigateTime")
        If (!Window.IsActive()) {
            Out.I("No window found while trying to travel.")
            Return false
        }
        i := 0
        If (!S.Get("DisableZoneChecks")) {
            Out.I("Traveling to " this.Name)
            ; Advantage of this sample check is script doesn't travel if already
            ; there and can recheck if travels failed
            While (!this.IsZoneColour() && this.BossTimer = !IsBossTimerActive() &&
            i <= 4) {
                If (!Window.IsActive()) {
                    Out.I("No window found while trying to travel.")
                    Return false
                }
                this.AttemptTravel(NavigateTime)
                i++
            }
        }
        If (this.IsZoneColour()) {
            Out.D("Travel success to " this.Name)
            Return true
        } Else {
            Out.I("Traveling to " this.Name ". Attempt to blind travel with"
                " slowed times.")
            this.AttemptTravel(NavigateTime, 50, 200)
            If (S.Get("DisableZoneChecks")) {
                ; Checks are disabled so blindly trust we reached zone
                Return true
            }
            If (this.IsZoneColour()) {
                Out.D("Blind travel success to " this.Name)
                Return true
            } Else {
                Out.I("Traveling to " this.Name " failed, " this.CurrentZoneString())
                Return false
            }
        }
    }
    ;@endregion

    ;@region _GoToArea()
    /**
     * Go to the zone base function, uses other functions to target travel
     * @param {Func(int, [int], [int])} Attempt Func(delay, [scrolldelay],
     * [extradelay]) To attempt travel
     * @example Attempt(delay, scrolldelay := 0, extradelay := 0) { }
     * @param {Func(String)} Check Func(Name) To confirm travel, true if success 
     * @example Check(Name) { this.IsZone(Name) }
     * @param Name Zone name or feature name for display purposes and colour
     * checks
     * @returns {Boolean} True if travel success, false if travel failed
     */
    _GoToArea(Attempt, Check, Name) {
        NavigateTime := S.Get("NavigateTime")
        If (!Window.IsActive()) {
            Out.I("No window found while trying to travel.")
            Return false
        }
        i := 0
        If (!S.Get("DisableZoneChecks")) {
            Out.I("Traveling to " Name)
            ; Advantage of this sample check is script doesn't travel if already
            ; there and can recheck if travels failed
            While (!Check(Name) && i <= 4) {
                If (!Window.IsActive()) {
                    Out.I("No window found while trying to travel.")
                    Return false
                }
                Attempt(NavigateTime)
                i++
            }
        }
        If (Check(Name)) {
            Out.D("Travel success to " Name)
            Return true
        } Else {
            Out.I("Traveling to " Name ". Attempt to blind travel with"
                " slowed times.")
            Attempt(NavigateTime, 50, 200)
            If (S.Get("DisableZoneChecks")) {
                ; Checks are disabled so blindly trust we reached zone
                Return true
            }
            If (Check(Name)) {
                Out.D("Blind travel success to " Name)
                Return true
            } Else {
                Out.I("Traveling to " Name " failed, " this.CurrentZoneString())
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
     * this.ZoneColour
     * @returns {Boolean} 
     */
    IsZoneColour() {
        sampleColour := this.GetZoneColour()
        If (sampleColour = this.ZoneColour) {
            ; Found target colour
            Return true
        }
        Out.D("IsZoneColour: Not in target zone, " this.CurrentZoneString())
        Return false
    }
    ;@endregion

    ;@region IsZone()
    /**
     * Checks if zone is currently set to the zone required based on 
     * name matched to colour lookup
     * @param Name Name of zone to check if currently in
     * @returns {Boolean}
     */
    IsZone(Name := "") {
        If (Name = "" && this.Name != "") {
            Name := this.Name
        }
        colour := this.GetZoneColour()
        curName := this.GetNameByColour(colour)
        If (curName = false) {
            Out.D("IsZone: No zone found for colour, " this.CurrentZoneString())
            Return false
        }
        For value IN curName {
            If (value = Name) {
                ; Found target zone
                Out.D("IsZone: Are in target zone, " this.CurrentZoneString())
                Return true
            }
        }
        Out.D("IsZone: Not in target zone, " this.CurrentZoneString())
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

    ;@region GetNameByColour()
    /**
     * Gets the zone with matching colour sample
     * @param colour Colour string for zone check
     * @returns {String} Full name string of zone found in ZoneColours
     */
    GetNameByColour(colour) {
        Return Colours().GetZoneByColour(colour)
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

    /**
     * Debug string of current zone
     * @returns {String} Name: <zone name> Colour: <zone colour>
     */
    CurrentZoneString() {
        colour := this.GetZoneColour()
        curName := this.GetNameByColour(colour)
        i := 0
        For (value IN curName) {
            if (i + 1 < curName.Length) {
                names .= value . ", "
            } else {
                names .= value
            }
            i++
        }
        Return "Name: " names " colour: " colour
    }
}
