#Requires AutoHotkey v2.0

#Include cTimer.ahk

/**
 * Game window class global
 * @type {cGameWindow} 
 */
Global Window

/**
 * Game Window management class resolution independant
 * @module cGameWindow
 * @property {String} Title Window title description string, as used to match 
 * windows in ahk
 * @property {Integer} W Width
 * @property {Integer} H Height
 * @property {Integer} X Horizontal position
 * @property {Integer} Y Vertical position
 * @method __New Constructor
 * @method RelW Convert from default client resolution to current resolution
 * @method RelH Convert from default client resolution to current resolution
 * @method Activate Activate window
 * @method IsActive Check if window active focus
 * @method Exist Check if window exists
 * @method ActiveOrReload Swap to window or reset script
 * @example cGameWindow("Notepad ahk_class Notepad ahk_exe Notepad.exe", 2560, 1369)
 */
Class cGameWindow {
    ;@region Properties
    /** @type {String} Window title description string, as used to match windows
     * in ahk
     */
    Title := ""
    /** @type {DateTime} Time since window check last failed and logged */
    LastLogged := 0
    /** @type {Integer} Window Width */
    W := 0
    /** @type {Integer} Window Height */
    H := 0
    /** @type {Integer} Window Horizontal Position X */
    X := 0
    /** @type {Integer} Window Vertical Position Y */
    Y := 0
    /** @type {Integer} Default client width by which scaling is set */
    DefW := 0
    /** @type {Integer} Default client height by which scaling is set */
    DefH := 0
    ;@endregion

    ;@region __New()
    /**
     * Create new GameWindow class to handle window size and checks
     * @constructor
     * @param {String} Title AHK formatted window selection string
     * @param {Integer} DefW Client area width that cPoints and cRect were sampled at
     * @param {Integer} DefH Client area height that cPoints and cRect were sampled at
     * @example cGameWindow("Notepad ahk_class Notepad ahk_exe Notepad.exe", 2560, 1369)
     */
    __New(Title := "", DefW := 0, DefH := 0) {
        If (Title != "") {
            this.Title := Title
        } Else {
            Out.E("No title provided to cGameWindow")
        }
        If (DefW != 0) {
            this.DefW := DefW
        } Else {
            Out.E("No default width provided to cGameWindow")
        }
        If (DefH != 0) {
            this.DefH := DefH
        } Else {
            Out.E("No default height provided to cGameWindow")
        }
        this.Exist()
    }
    ;@endregion

    ;@region Relative Coordinates
    ; Convert positions from default size client resolution to current
    ; resolution to allow higher accuracy
    RelW(PosW) {
        Return PosW / this.DefW * this.W
    }

    ; Convert positions from default size client resolution to current
    ; resolution to allow higher accuracy
    RelH(PosH) {
        Return PosH / this.DefH * this.H
    }
    ;@endregion

    ;@region Activate()
    /**
     * Activate window
     * (Updates GameWindow properties when used)
     * @returns {Boolean} Does window exist (and is therefore activated)
     */
    Activate() {
        If (!this.Exist()) {
            Out.E("Window doesn't exist.")
            Return false ; Don't check further
        }
        If (!WinActive(this.Title)) {
            WinActivate(this.Title)
        }
        Return true
    }
    ;@endregion

    ;@region IsActive()
    /**
     * Is Game Window active
     * (Updates GameWindow properties when used)
     * @returns {Boolean} False if !exist or !active
     */
    IsActive() {
        If (!this.Exist()) {
            If (this.LastLogged = 0) {
                this.LastLogged := A_Now
                Out.E("Window doesn't exist.")
                Return false
            }
            If (DateDiff(A_Now, this.LastLogged, "Seconds") >= 10) {
                Out.E("Window doesn't exist.")
                this.LastLogged := A_Now
            }
            Return false
        }
        If (!WinActive(this.Title)) {
            ; Because this can be spammed lets limit rate the error log
            If (this.LastLogged = 0) {
                this.LastLogged := A_Now
                Out.D("Window not active.")
                Return false
            }
            If (DateDiff(A_Now, this.LastLogged, "Seconds") >= 10) {
                Out.D("Window not active.")
                this.LastLogged := A_Now
            }
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region Exist()
    /**
     * Fill xywh values and return bool of existance of window
     * (Updates GameWindow properties when used)
     * @returns {Boolean} Does this.Title exist
     */
    Exist() {
        If (WinExist(this.Title)) {
            Try {
                WinGetClientPos(&valX, &valY, &valW, &valH, this.Title)
                this.X := valX
                this.Y := valY
                this.W := valW
                this.H := valH
            } Catch As err {
                Out.E("Window doesn't exist. Cannot get client position.")
                Out.E(err)
                Return false
            }
            Return true
        }
        this.X := this.Y := this.W := this.H := 0
        Return false
    }
    ;@endregion

    ;@region ActiveOrReload()
    /**
     * Check game is there or exit out a running process
     */
    ActiveOrReload() {
        If (!this.Activate()) {
            Reload()
        }
    }
    ;@endregion
}
