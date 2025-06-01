#Requires AutoHotkey v2.0

#Include cPoint.ahk
#Include cGameWindow.ahk
#Include cLogging.ahk

/**
 * cButton Class, extends cPoint with button related colour checking
 * @module cButton
 * @property {String} Active Active button colour (excluding text)
 * @property {String} ActiveMouseOver Active button colour when mouse over
 * @property {String} Inactive Inactive button colour
 * @property {String} Background Background window main colour
 * @method IsButton 
 * @method IsMouseOver
 * @method IsButtonActive
 * @method IsButtonInactive
 * @method IsColourMatch Matches on any colour property
 * @method IsBackground
 * @method ColourToUserString
 * @method ClickButtonActive
 * @method WaitUntilActiveButton
 * @method WaitUntilActiveButtonS
 * @method WaitUntilButton
 * @method WaitUntilButtonS
 */
Class cButton extends cPoint {
    /** 0xFFFFFF
     * @type {String} */
    Active := ""
    /** 0xFFFFFF
     *  @type {String} */
    ActiveMouseOver := ""
    /** 0xFFFFFF
     * @type {String} */
    Inactive := ""
    /** 0xFFFFFF
     * @type {String} */
    Background := ""
    /** 0xFFFFFF
     * @type {String} */
    ActiveSelected := ""
    /** 0xFFFFFF
     * @type {String} */
    InactiveSelected := ""

    ;@region Button methods
    ;@region IsButton()
    /**
     * Is the provided colour a LBR button
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButton() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver ||
            colour = this.ActiveSelected || colour = this.Inactive ||
            colour = this.InactiveSelected) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsMouseOver()
    /**
     * Is the provided colour a button in mouseover state
     * @returns {Integer} true/false
     */
    IsMouseOver() {
        colour := this.GetColour()
        If (colour = this.ActiveMouseOver) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonActive()
    /**
     * Is the provided colour a button in active state
     * @returns {Integer} true/false
     */
    IsButtonActive() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.ActiveSelected) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonInactive()
    /**
     * Is the provided colour a button in inactive state
     * @returns {Integer} true/false
     */
    IsButtonInactive() {
        colour := this.GetColour()
        If (colour = this.Inactive || colour = this.InactiveSelected) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsColourNotMatch()
    /**
     * Is the provided colour a button or background
     * @returns {Integer} true/false
     */
    IsColourMatch() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour = this
            .Inactive || colour = this.Background || colour = this.ActiveSelected || colour = this.InactiveSelected
        ) {
            Return false
        }
        Return true
    }
    ;@endregion
    ;@endregion

    ;@region IsBackground()
    /**
     * Is the provided colour the background panel colour
     * @returns {Integer} true/false
     */
    IsBackground() {
        If (this.GetColour() = this.Background) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region ColourToUserString()
    /**
     * Returns a user interface formatted string of the matching colour
     */
    ColourToUserString() {
        col := this.GetColour()
        Switch (col) {
        Case this.Active:
            Return "Active button"
        Case this.ActiveMouseOver:
            Return "Active, mouse over button"
        Case this.Inactive:
            Return "Inactive button"
        Case this.Background:
            Return "Panel background"
        Case this.ActiveSelected:
            Return "Active, selected button"
        Case this.InactiveSelected:
            Return "Inactive, selected button"

        default: Return "Unknown colour: " col
        }
    }
    ;@endregion

    ;@region ClickButtonActive()
    /**
     * Check if point is active button background then click with 1*1 offset
     * @param {Integer} [xOffset] Amount to offset X when clicking to avoid 
     * covering point
     * @param {Integer} [yOffset] Amount to offset Y when clicking to avoid 
     * covering point
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     * @param {Integer} [sleepafter=Navigatetime] Period to sleep after clicking
     * @returns {Boolean} Was button active and clicked
     */
    ClickButtonActive(xOffset := 1, yOffset := 1, clickdelay := 34,
        sleepafter := 17) {
        If (this.IsButtonActive()) {
            this.ClickOffset(xOffset, yOffset, clickdelay)
            Sleep(sleepafter)
            Return true
        }
        Return false
    }
    ;@endregion

    /**
     * Loop until active button found or max loops reached
     * @memberof cPoint
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilActiveButton(maxLoops := 20, interval := 50) {
        debugtemp := ""
        i := maxLoops
        While (Window.IsActive() && !this.IsButtonActive()) {
            Sleep(interval)
            i--
            If (this.toStringWColour() != debugtemp) {
                debugtemp := this.toStringWColour()
                ; Out.D(this.toStringWColour() " " this.IsButtonActive())
            }
            If (i <= 0) {
                Break
            }
        }
        ;Out.D("WaitUntilActiveButton: " this.toStringWColour())
        Return this.IsButtonActive()
    }

    /**
     * Loop until active button found or max loops reached
     * @memberof cPoint
     * @param {Integer} seconds Time period for loop
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilActiveButtonS(seconds := 10) {
        Return this.WaitUntilActiveButton(seconds * 1000 / 20, 20)
    }

    /**
     * Loop until button found or max loops reached
     * @memberof cPoint
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilButton(maxLoops := 20, interval := 50) {
        debugtemp := ""
        i := maxLoops
        While (Window.IsActive() && !this.IsButton()) {
            Sleep(interval)
            i--
            If (this.toStringWColour() != debugtemp) {
                debugtemp := this.toStringWColour()
                Out.D(this.toStringWColour() " " this.IsButton())
            }
            If (i <= 0) {
                Break
            }
        }
        Out.D("WaitUntilButton: " this.toStringWColour())
        Return this.IsButton()
    }

    /**
     * Loop until button found or max loops reached
     * @memberof cPoint
     * @param {Integer} seconds Time period for loop
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilButtonS(seconds := 10) {
        Return this.WaitUntilButton(seconds * 1000 / 20, 20)
    }
}
