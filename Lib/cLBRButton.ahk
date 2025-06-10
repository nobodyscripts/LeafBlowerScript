#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cButton.ahk
#Include Misc.ahk

/**
 * cLBRButton
 * @module cLBRButton
 * @method GreedyModifierClick Desc
 */
Class cLBRButton extends cButton {
    /** 0xFFF1D2
     * @type {String} */
    Active := "0xFFF1D2"
    /** 0xFDD28A
     *  @type {String} */
    ActiveMouseOver := "0xFDD28A"
    /** 0xC8BDA5
     * @type {String} */
    Inactive := "0xC8BDA5"
    /** 0x97714A
     * @type {String} */
    Background := "0x97714A"
    /** 0xFFFFFF
     * @type {String} */
    ActiveSelected := ""
    /** 0xFFFFFF
     * @type {String} */
    InactiveSelected := ""

    /** 0xB3A993
     *  @type {String} */
    AfkActive := "0xB3A993"
    /** 0xB29361
     * @type {String} */
    AfkActiveMouseover := "0xB29361"
    /** 0x6A4F34
     * @type {String} */
    BackgroundAFK := "0x6A4F34"
    /** 0x837C6C
     * @type {String} */
    DarkBgActive := "0x837C6C"
    /** 0x826C47
     * @type {String} */
    DarkBgActiveMouseover := "0x826C47"
    /** 0x97714B
     * @type {String} */
    BackgroundSpotify := "0x97714B"
    /** 0x78D063
     * @type {String} */
    BankTabSelectedActive := "0x78D063"
    /** 0xA0EC84
     * @type {String} */
    BankTabSelectedActiveMouseover := "0xA0EC84"

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
