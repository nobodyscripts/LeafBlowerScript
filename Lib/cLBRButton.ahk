#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cButton.ahk
#Include Misc.ahk

/**
 * cLBRButton Class, extends cButton > cPoint with LBR specific button related colour checking
 * @module cLBRButton
 * @extends cButton
 * @property {String} Active Active button colour (excluding text)
 * @property {String} ActiveMouseOver Active button colour when mouse over
 * @property {String} Inactive Inactive button colour
 * @property {String} Background Background window main colour
 * @property {String} ActiveSelected
 * @property {String} InactiveSelected
 * @property {String} AfkActive
 * @property {String} AfkActiveMouseover
 * @property {String} BackgroundAFK
 * @property {String} DarkBgActive
 * @property {String} DarkBgActiveMouseover
 * @property {String} BackgroundSpotify
 * @property {String} BankTabSelectedActive
 * @property {String} BankTabSelectedActiveMouseover
 * @method IsButton 
 * @method IsButtonAFK
 * @method IsMouseOver
 * @method IsButtonActive
 * @method IsButtonInactive
 * @method IsButtonOffPanel
 * @method IsButtonDarkened
 * @method IsColourMatch Matches on any colour property
 * @method IsBackground
 * @method IsCoveredByNotification
 * @method ColourToUserString
 * @method ClickButtonActive
 * @method GreedyModifierClick
 * @method WaitUntilActiveButton
 * @method WaitUntilActiveButtonS
 * @method WaitUntilButton
 * @method WaitUntilButtonS
 * @method WaitUntilClick
 * @method WaitUntilClickTwice
 */
Class cLBRButton extends cButton {
    
    /** 0xFFF1D2
     * @type {String} */
    Active := c.Active
    /** 0xFDD28A
     *  @type {String} */
    ActiveMouseOver := c.ActiveMouseOver
    /** 0xC8BDA5
     * @type {String} */
    Inactive := c.Inactive
    /** 0x97714A
     * @type {String} */
    Background := c.Background
    /** 0xFFFFFF
     * @type {String} */
    ActiveSelected := c.ActiveSelected
    /** 0xFFFFFF
     * @type {String} */
    InactiveSelected := c.InactiveSelected

    /** 0xB3A993
     *  @type {String} */
    AfkActive := c.AfkActive
    /** 0xB29361
     * @type {String} */
    AfkActiveMouseover := c.AfkActiveMouseover
    /** 0x6A4F34
     * @type {String} */
    BackgroundAFK := c.BackgroundAFK
    /** 0x837C6C
     * @type {String} */
    DarkBgActive := c.DarkBgActive
    /** 0x826C47
     * @type {String} */
    DarkBgActiveMouseover := c.DarkBgActiveMouseover
    /** 0x97714B
     * @type {String} */
    BackgroundSpotify := c.BackgroundSpotify
    /** 0x78D063
     * @type {String} */
    BankTabSelectedActive := c.BankTabSelectedActive
    /** 0xA0EC84
     * @type {String} */
    BankTabSelectedActiveMouseover := c.BankTabSelectedActiveMouseover

    ;@region Funcname()
    /**
     * Click with decending amounts of modifiers used when button becomes
     * inactive, starting at 25000 or startAt amount.
     * @memberof cPoint
     * @param {Integer} sleeptime Time to sleep between clicks 
     * @param {Integer} delay Time to wait between mousedown and mouseup
     * @param {Integer} startAt Amount for keyboard modifier starting level
     */
    GreedyModifierClick(sleeptime := 54, delay := 54, startAt := 25000) {
        AmountArr := [
            "25000",
            "2500",
            "1000",
            "250",
            "100",
            "25",
            "10",
            "1"
        ]
        If (!Window.IsActive() || !Window.IsPanel() || !this.IsButtonActive()) {
            Return
        }
        For Amount in AmountArr {
            If (Amount <= startAt) {
                AmountToModifier(Amount)
                Out.D("GreedyModifierClick amount " Amount)
                Sleep(S.Get("NavigateTime"))
                ClickCount := 0
                While (Window.IsActive() && Window.IsPanel() && this.IsButtonActive()) {
                    this.ClickOffset(5, 5, delay)
                    Sleep(sleeptime)
                    If (Amount < startAt) {
                        If (ClickCount > 15) {
                            Break
                        }
                        ClickCount++
                    }
                }
            }
        }
        ResetModifierKeys()
    }
    ;@endregion

    ;@region Button methods
    ;@region IsButton()
    /**
     * Is the provided colour a LBR button
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButton() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsMouseOver()
    /**
     * Is the provided colour a LBR button in mouseover state
     * @returns {Integer} true/false
     */
    IsMouseOver() {
        colour := this.GetColour()
        If (colour = this.ActiveMouseOver || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonActive()
    /**
     * Is the provided colour a LBR button in active state
     * @returns {Integer} true/false
     */
    IsButtonActive() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonAFK()
    /**
     * Is the provided colour a LBR button in active state
     * @returns {Integer} true/false
     */
    IsButtonAFK() {
        colour := this.GetColour()
        If (colour = this.AfkActive || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonInactive()
    /**
     * Is the provided colour a LBR button in inactive state
     * @returns {Integer} true/false
     */
    IsButtonInactive() {
        colour := this.GetColour()
        If (colour = this.Inactive) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsCoveredByNotification()
    /**
     * Is the provided colour NOT an LBR button or background
     * @returns {Integer} true/false
     */
    IsCoveredByNotification() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive || colour = this.Background || colour = this.BackgroundSpotify
        ) {
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region IsButtonOffPanel()
    /**
     * Is the provided colour a LBR button off the panels
     * @returns {Integer} true/false
     */
    IsButtonOffPanel() {
        colour := this.GetColour()
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive || colour = this.DarkBgActive || colour = this.DarkBgActiveMouseover
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonDarkened()
    /**
     * Is the provided colour an LBR button off the panels thats darkened
     * @returns {Integer} true/false
     */
    IsButtonDarkened() {
        colour := this.GetColour()
        If (colour = this.DarkBgActive || colour = this.DarkBgActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion
    ;@endregion

    ;@region IsBackground()
    /**
     * Is the provided colour the LBR background panel colour
     * @returns {Integer} true/false
     */
    IsBackground() {
        colour := this.GetColour()
        If (colour = this.Background || colour = this.BackgroundSpotify) {
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
        Case this.AfkActive:
            Return "Active, selected button, afk on"
        Case this.AfkActiveMouseover:
            Return "Active, selected button, afk on, mouse over button"
        Case this.BackgroundAFK:
            Return "Panel background, afk on"
        Case this.DarkBgActive:
            Return "Panel background, dark mode on"
        Case this.DarkBgActiveMouseover:
            Return "Active, mouse over button, dark mode on"
        Case this.BackgroundSpotify:
            Return "Panel background, spotify bug"
        Case this.BankTabSelectedActive:
            Return "Active button, bank tab selected"
        Case this.BankTabSelectedActiveMouseover:
            Return "Active button, bank tab selected, mouse over button"
        default: Return "Unknown colour: " col
        }
    }
    ;@endregion
}
