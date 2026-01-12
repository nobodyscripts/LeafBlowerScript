#Requires AutoHotkey v2.0

#Include Navigate.ahk
#Include ..\ScriptLib\cGameWindow.ahk

S.AddSetting("Default", "DisableSettingsChecks", false, "Bool")

/**
 * Game Window management class 2560*1369
 * @module cLBRWindow
 * @extends cGameWindow
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
 * @method IsPanel Check if game has panel open
 * @method AreGameSettingsCorrect Runtime settings checks
 * @method IsPanelTransparent
 * @method IsPanelTransparentCorrectCheck
 * @method IsAspectRatioCorrect
 * @method IsAspectRatioCorrectCheck
 * @method IsPanelSmoothed
 * @method IsPanelSmoothedCheck
 * @method IsDarkBackgroundOn
 * @method IsDarkBackgroundCheck
 * @method IsTreesSetCheck
 * @method IsAFKOn
 * @method AFKFix
 * @method AwaitPanel Wait for panel to be true or x seconds
 * @method AwaitPanelClose Wait for panel closed to be true or x seconds
 */
Class cLBRWindow extends cGameWindow {
    ;@region AreGameSettingsCorrect()
    /**
     * Check if essential game settings are correct during runtime
     * @returns {Boolean} true/false
     */
    AreGameSettingsCorrect() {
        If (S.Get("DisableSettingsChecks")) {
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
            Out.I("Error 15: Failed settings check at rendering mode.")
            Return false
        }
        If (!this.IsPanelTransparentCorrectCheck()) {
            Out.I("Error 16: Failed settings check at transparency.")
            Return false
        }
        If (!this.IsPanelSmoothedCheck()) {
            Out.I("Error 17: Failed settings check at smooth graphics.")
            Return false
        }
        If (!this.IsDarkBackgroundCheck()) {
            Out.I("Error 18: Failed settings check at dark dialog background.")
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region IsPanel()
    /**
     * Check for panel being open
     * @returns {Boolean} True/False, True if a main panel is active
     */
    IsPanel() {
        Try {
            /** @type {cLBRButton} */
            point := Points.Misc.PanelBG
            targetColour := point.GetColour()
            ; If its afk mode return as well, let afk check handle
            If (targetColour = point.Background ||
                targetColour = point.BackgroundAFK) {
                ; Found panel background colour
                Return true
            }
            If (targetColour = point.BackgroundSpotify) {
                Out.I(
                    "Spotify colour warp detected, please avoid using spotify desktop."
                )
                Return true
            }
        } Catch As exc {
            Out.I("Error 19: Panel transparency check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }
    ;@endregion

    ;@region IsPanelTransparentCorrectCheck()
    /**
     * Check if panel is transparent and generate user errors based on setting
     * @returns {Boolean} 
     */
    IsPanelTransparentCorrectCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsPanel()) {
            MsgBox("Error: It appears you may be using menu transparency,"
                " please set to 100% then F2 to reload().`nSee Readme.md"
                " for other required settings.")
            Return false
        } Else {
            Return true
        }
    }
    ;@endregion

    ;@region IsAspectRatioCorrect()
    /**
     * Is game set to the right render mode and thus resizable
     * @returns {Boolean} 
     */
    IsAspectRatioCorrect() {
        ;54 1328 (lower left of lower left hide button)
        ;2425 51 (top right of top right hide button)
        Try {
            /** @type {cLBRButton} */
            point := Points.Misc.AspectRatio1
            /** @type {cLBRButton} */
            point2 := Points.Misc.AspectRatio2
            sampleColour := point.GetColour()
            sampleColour2 := point2.GetColour()
            If (point.IsButtonOffPanel() ||
            point2.IsButtonOffPanel() && sampleColour = sampleColour2) {
                Return true
            }
        } Catch As exc {
            Out.I("Error 20: Render Mode check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Out.D("Aspect ratio check found unknown colour " sampleColour)
        Return false
    }
    ;@endregion

    ;@region IsAspectRatioCorrectCheck()
    /**
     * Tests render mode and presents user errors based on setting
     * @returns {Boolean} 
     */
    IsAspectRatioCorrectCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsAspectRatioCorrect()) {
            Out.I("Error 21: Alternative rendering check failed.")
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
    ;@endregion

    ;@region IsPanelSmoothed()
    /**
     * Is game set to the right smoothing mode and not blurry
     * @returns {Boolean} 
     */
    IsPanelSmoothed() {
        Try {
            sampleColour := Points.Misc.PanelBG2.GetColour()
            sampleColour2 := Points.Misc.PanelBG3.GetColour()
            If (sampleColour != sampleColour2) {
                Out.D("Smoothed graphics check found " sampleColour " " sampleColour2
                )
                ; Found smoothing
                Return true
            }
        } Catch As exc {
            Out.I("Error 25: Panel smoothing check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }
    ;@endregion

    ;@region IsPanelSmoothedCheck()
    /**
     * Tests smoothing mode and presents user errors based on setting
     * @returns {Boolean} 
     */
    IsPanelSmoothedCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsPanelSmoothed()) {
            Return true
        }
        Out.I("Error 26: Smooth graphics check failed.")
        MsgBox("Error: It appears you are using Smooth Graphics, please set"
            " to off then F2 to reload().`nSee Readme.md for other required"
            " settings.")
        Return false
    }
    ;@endregion

    ;@region IsDarkBackgroundOn()
    /**
     * Is game set to the right dark background mode and not shaded
     * @returns {Boolean} 
     */
    IsDarkBackgroundOn() {
        Try {
            /** @type {cLBRButton} */
            point := Points.Misc.AspectRatio1
            /** @type {cLBRButton} */
            point2 := Points.Misc.AspectRatio2
            sampleColour := point.GetColour()
            sampleColour2 := point2.GetColour()
            If (point.IsButtonDarkened() || point2.IsButtonDarkened()) {
                Out.D("Corner buttons found with Dark Dialog Background on.")
                ; Found dark mode
                Return true
            }
        } Catch As exc {
            Out.I("Error 6: Dark Dialog Background check failed - " exc.Message
            )
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }
    ;@endregion

    ;@region IsDarkBackgroundCheck()
    /**
     * Tests dark background mode and presents user errors based on setting
     * @returns {Boolean} 
     */
    IsDarkBackgroundCheck() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsDarkBackgroundOn()) {
            Return true
        }
        Out.I("Error 27: Dark Dialog Background check failed.")
        MsgBox("Error: It appears you are using Dark Dialog Background, please"
            " set to off then F2 to reload().`nSee Readme.md for other"
            " required settings.")

        Return false
    }
    ;@endregion

    ;@region IsTreesSetCheck()
    /**
     * Tests if trees are visible and presents user errors based on setting
     * @returns {Boolean} 
     */
    IsTreesSetCheck() {
        NavigateTime := S.Get("NavigateTime")
        Travel.OpenAreas(true, 300)
        Points.Areas.LeafGalaxy.HomeGarden.Click(NavigateTime + 300)
        Sleep(NavigateTime + 300)
        If (Travel.HomeGarden.IsActive()) {
            Return true
        } Else {
            Out.I("Error 28: Trees check failed. " GetAreaSampleColour())
            MsgBox("Error: It appears you are using Trees, please set to"
                " off then F2 to reload().`nSee Readme.md for other"
                " required settings.")
            Return false
        }
    }
    ;@endregion

    ;@region IsAFKOn()
    /**
     * Tests auto afk and presents user errors based on setting
     * @returns {Boolean} 
     */
    IsAFKOn() {
        Try {
            /** @type {cLBRButton} */
            point := Points.Misc.AspectRatio1
            /** @type {cLBRButton} */
            point2 := Points.Misc.AspectRatio2
            If (point.IsButtonAFK() || point2.IsButtonAFK()) {
                Out.D("IsAFKOn: Corner buttons found with AFK on.")
                ; Found dark mode
                Return true
            }
        } Catch As exc {
            Out.I("Error 34: AFK check failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n" exc
                .Message)
        }
        Return false
    }
    ;@endregion

    ;@region AFKFix()
    /**
     * Click in the corner of the screen if afk is detected, prevents issues
     * when game is out of focus and refocused but afk stays on
     * @returns {Boolean} 
     */
    AFKFix() {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        If (!this.IsAFKOn()) {
            Return true
        }
        Out.I("Warning 1: AFK found enabled.")
        Points.Misc.BlankBG.Click()
        Return false
    }
    ;@endregion

    ;@region AwaitPanel()
    /**
     * Await the panel appearing after being triggered
     * @returns {Boolean} 
     */
    AwaitPanel(maxS := 5) {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        /** @type {Timer} */
        lTimer := Timer()
        lTimer.CoolDownS(maxS, &Waiting)
        While (!this.IsPanel() && Waiting) {
            Sleep(17)
        }
        Return this.IsPanel()
    }
    ;@endregion

    ;@region AwaitPanelClose()
    /**
     * Await the panel closing after being triggered
     * @returns {Boolean} 
     */
    AwaitPanelClose(maxS := 5) {
        If (!this.IsActive()) {
            Return false ; Kill if no game
        }
        /** @type {Timer} */
        lTimer := Timer()
        lTimer.CoolDownS(maxS, &Waiting)
        While (this.IsPanel() && Waiting) {
            Sleep(17)
        }
        Return !this.IsPanel()
    }
    ;@endregion
}
