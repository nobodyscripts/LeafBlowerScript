#Requires AutoHotkey v2.0

#Include Navigate.ahk

/**
 * Game Window management class
 * @module cGameWindow
 * @property {Type} property Desc
 * @method Name Desc
 */
Class cGameWindow {
    /** @type {String} Window title description string, as used to match windows
     * in ahk
     */
    Title := "Leaf Blower Revolution ahk_class YYGameMakerYY ahk_exe game.exe"
    /** @type {DateTime} Time since window check last failed and logged */
    LastLogged := 0
    /** @type {Integer} Window Width */
    W := 0
    /** @type {Integer} Window Height */
    H := 0
    /** @type {Integer} Window Position X */
    X := 0
    /** @type {Integer} Window Position Y */
    Y := 0

    ;@region __New()
    __New(Title := "") {
        If (Title != "") {
            this.Title := Title
        }
        this.Exist()
    }
    ;@endregion

    ; Convert positions from 2560*1369 client resolution to current resolution to
    ; allow higher accuracy
    RelW(PosW) {
        Return PosW / 2560 * this.W
    }

    ; Convert positions from 2560*1369 client resolution to current resolution to
    ; allow higher accuracy
    RelH(PosH) {
        Return PosH / 1369 * this.H
    }

    ;@region Activate()
    Activate() {
        If (!this.Exist()) {
            Log("Error: Window doesn't exist.")
            Return false ; Don't check further
        }
        If (!WinActive(this.Title)) {
            WinActivate(this.Title)
        }
        Return true
    }
    ;@endregion

    IsActive() {
        If (!this.Exist()) {
            If (this.LastLogged = 0) {
                this.LastLogged := A_Now
                Log("Error: Window doesn't exist.")
                Return false
            }
            If (DateDiff(A_Now, this.LastLogged, "Seconds") >= 10) {
                Log("Error: Window doesn't exist.")
                this.LastLogged := A_Now
            }
            Return false
        }
        If (!WinActive(this.Title)) {
            ; Because this can be spammed lets limit rate the error log
            If (this.LastLogged = 0) {
                this.LastLogged := A_Now
                DebugLog("Window not active.")
                Return false
            }
            If (DateDiff(A_Now, this.LastLogged, "Seconds") >= 10) {
                DebugLog("Window not active.")
                this.LastLogged := A_Now
            }
            Return false
        }
        Return true
    }

    /**
     * Fill xywh values and return bool of existance of lbr window
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
                Log(
                    "Error: Window doesn't exist. Error getting client position."
                )
                ErrorLog(err)
                Return false
            }
            Return true
        }
        this.X := this.Y := this.W := this.H := 0
        Return false
    }

    AreGameSettingsCorrect() {
        Global DisableSettingsChecks
        If (DisableSettingsChecks) {
            Return true
        }
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        ; Check for afk, if it is on, click the corner of the screen
        this.AFKFix()
        Travel.OpenAreas()
        ; Cannot check font here as it might not be correct res
        ; Changing res every activation would be annoying
        If (!this.IsAspectRatioCorrectCheck()) {
            Log("Error 15: Failed settings check at rendering mode.")
            Return false
        }
        If (!this.IsPanelTransparentCorrectCheck()) {
            Log("Error 16: Failed settings check at transparency.")
            Return false
        }
        If (!this.IsPanelSmoothedCheck()) {
            Log("Error 17: Failed settings check at smooth graphics.")
            Return false
        }
        If (!this.IsDarkBackgroundCheck()) {
            Log("Error 18: Failed settings check at dark dialog background.")
            Return false
        }
        Return true
    }


    /**
     * Check for panel being open
     * @returns {number} True/False, True if a main panel is active
     */
    IsPanel() {
        Return !this.IsPanelTransparent()
    }


    /**
     * Check for panel being non standard background colour
     * @returns {number} True/False, True if a main panel is transparent
     */
    IsPanelTransparent() {
        Try {
            targetColour := Points.Misc.PanelBG.GetColour()
            ; If its afk mode return as well, let afk check handle
            If (targetColour = Colours().Background || targetColour = Colours()
                .BackgroundAFK) {
                ; Found panel background colour
                Return false
            }
            If (targetColour = Colours().BackgroundSpotify) {
                Log(
                    "Spotify colour warp detected, please avoid using spotify desktop."
                )
                Return false
            }
        } Catch As exc {
            Log("Error 19: Panel transparency check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return true
    }

    IsPanelTransparentCorrectCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (this.IsPanelTransparent()) {
            MsgBox("Error: It appears you may be using menu transparency,"
                " please set to 100% then F2 to reload().`nSee Readme.md"
                " for other required settings.")
            Return false
        } Else {
            Return true
        }
    }

    IsAspectRatioCorrect() {
        ;54 1328 (lower left of lower left hide button)
        ;2425 51 (top right of top right hide button)
        Try {
            sampleColour := Points.Misc.AspectRatio1.GetColour()
            sampleColour2 := Points.Misc.AspectRatio2.GetColour()
            If (Colours().IsButtonOffPanel(sampleColour) || Colours().IsButtonOffPanel(
                sampleColour2) && sampleColour = sampleColour2) {
                Return true
            }
        } Catch As exc {
            Log("Error 20: Render Mode check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        DebugLog("Aspect ratio check found unknown colour " sampleColour)
        Return false
    }

    IsAspectRatioCorrectCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsAspectRatioCorrect()) {
            Log("Error 21: Alternative rendering check failed.")
            MsgBox("Error: It appears you may be using normal render mode,"
                " please set Alternative on then F2 to reload() at the bottom of"
                " settings.`nSee Readme.md for other required settings.")
            WinActivate(this.Title)
            Travel.OpenSettings() ; Settings
            ; Not trying to click tab and scroll because window is known misaligned
            Return false
        } Else {
            Return true
        }
    }

    IsPanelSmoothed() {
        Try {
            sampleColour := Points.Misc.PanelBG2.GetColour()
            sampleColour2 := Points.Misc.PanelBG3.GetColour()
            If (sampleColour != sampleColour2) {
                DebugLog("Smoothed graphics check found " sampleColour " " sampleColour2
                )
                ; Found smoothing
                Return true
            }
        } Catch As exc {
            Log("Error 25: Panel smoothing check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }

    IsPanelSmoothedCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsPanelSmoothed()) {
            Return true
        }
        Log("Error 26: Smooth graphics check failed.")
        MsgBox("Error: It appears you are using Smooth Graphics, please set"
            " to off then F2 to reload().`nSee Readme.md for other required"
            " settings.")
        Return false
    }

    IsDarkBackgroundOn() {
        Try {
            sampleColour := Points.Misc.AspectRatio1.GetColour()
            sampleColour2 := Points.Misc.AspectRatio2.GetColour()
            If (Colours().IsButtonDarkened(sampleColour) || Colours().IsButtonDarkened(
                sampleColour2)) {
                DebugLog("Corner buttons found with Dark Dialog Background on."
                )
                ; Found dark mode
                Return true
            }
        } Catch As exc {
            Log("Error 6: Dark Dialog Background check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }

    IsDarkBackgroundCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsDarkBackgroundOn()) {
            Return true
        }
        Log("Error 27: Dark Dialog Background check failed.")
        MsgBox("Error: It appears you are using Dark Dialog Background, please"
            " set to off then F2 to reload().`nSee Readme.md for other"
            " required settings.")

        Return false
    }

    IsTreesSetCheck() {
        Travel.OpenAreas(true, 300)
        Points.Areas.LeafG.HomeGarden.Click(NavigateTime + 300)
        Sleep(NavigateTime + 300)
        If (Travel.HomeGarden.IsActive()) {
            Return true
        } Else {
            Log("Error 28: Trees check failed. " GetAreaSampleColour())
            MsgBox("Error: It appears you are using Trees, please set to"
                " off then F2 to reload().`nSee Readme.md for other"
                " required settings.")
            Return false
        }

    }

    IsAFKOn() {
        Try {
            sampleColour := Points.Misc.AspectRatio1.GetColour()
            sampleColour2 := Points.Misc.AspectRatio2.GetColour()
            If (Colours().IsButtonAFK(sampleColour) || Colours().IsButtonAFK(
                sampleColour2)) {
                DebugLog("IsAFKOn: Corner buttons found with AFK on.")
                ; Found dark mode
                Return true
            }
        } Catch As exc {
            Log("Error 34: AFK check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }

    ;@region AFKFix()
    AFKFix() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsAFKOn()) {
            Return true
        }
        Log("Warning 1: AFK found enabled.")
        Points.Misc.BlankBG.Click()
        Return false
    }
    ;@endregion
}