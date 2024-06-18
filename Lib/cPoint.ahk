#Requires AutoHotkey v2.0

#Include cColours.ahk
#Include SettingsCheck.ahk

global Debug := true

/**
 * Defines the resolution independant locations for pixel checks
 * @argument {Integer} x X value
 * @argument {Integer} y Y value
 * @argument {Integer} relative Set for % relative value, false for fixed
 */
Class cPoint {
    /**
     * If W has a value returns relative coord
     * otherwise returns raw value
     */
    x {
        get {
            global W
            if (this.relative && isset(W)) {
                return this._x / 2560 * W
            } else {
                if (!isset(W)) {
                    Log("ERR: W not set")
                }
                return this._x
            }
        }
        set {
            this._x := value
            return this._x
        }
    }

    /**
     * If H has a value returns relative coord
     * otherwise returns raw value
     */
    y {
        get {
            global H
            if (this.relative && isset(H)) {
                return this._y / 1369 * H
            } else {
                if (!isset(H)) {
                    Log("ERR: H not set")
                }
                return this._y
            }
        }
        set {
            this._y := value
            return this._y
        }
    }
    relative := true

    /**
     * Create new point instance using 2560*1440 resolution resolution
     * maximised client coords
     * @param x 
     * @param y 
     * @param relative Flag to set non relative xy, defaults off
     */
    __New(x := "", y := "", relative := true) {
        this.x := x
        this.y := y
        this.relative := relative
    }

    Set(x, y, relative := true) {
        this.x := x
        this.y := y
        this.relative := relative
        return this
    }

    /**
     * Is the colour of the point a button colour
     * @returns {Bool} 
     */
    IsButton() {
        targetColour := this.GetColour()
        If (Colours().IsButton(targetColour)) {
            return true
        }
        VerboseLog("cPoint.IsButton: " this.toString() " is now " targetColour)
        return false
    }

    /**
     * Is the colour of the point an active button colour
     * @returns {Bool} 
     */
    IsButtonActive() {
        targetColour := this.GetColour()
        If (Colours().IsButtonActive(targetColour)) {
            return true
        }
        VerboseLog("cPoint.IsButtonActive: " this.toString() " is now " targetColour)

        return false
    }

    /**
     * Is the colour of the point an inactive button
     * @returns {Bool} 
     */
    IsButtonInactive() {
        targetColour := this.GetColour()
        If (Colours().IsButtonInactive(targetColour)) {
            return true
        }
        VerboseLog("cPoint.IsButtonInactive: " this.toString() " is now " targetColour "`n")

        return false
    }

    /**
     * Is the colour of the point a background panel colour
     * @returns {Bool} 
     */
    IsBackground() {
        targetColour := this.GetColour()
        If (Colours().IsBackground(targetColour)) {
            return true
        }
        VerboseLog("cPoint.IsBackground: " this.toString() " is now " targetColour "`n")

        return false
    }

    /**
     * Is the colour of the point an active button, off panel colour
     * @returns {Bool} 
     */
    IsButtonOffPanel() {
        targetColour := this.GetColour()
        If (Colours().IsButtonOffPanel(targetColour)) {
            return true
        }
        VerboseLog("cPoint.IsButtonOffPanel: " this.toString() " is now " targetColour "`n")

        return false
    }

    /**
     * Mouse click at point with optional delay
     * @param {Integer} delay 
     */
    Click(delay := 34) {
        fCustomClick(this.x, this.y, delay)
    }

    /**
     * Mouseclick at point with optional xy offset and delay
     * @param {Integer} xOffset 
     * @param {Integer} yOffset 
     * @param {Integer} delay 
     */
    ClickOffset(xOffset := 1, yOffset := 1, delay := 34) {
        fCustomClick(this.x + xOffset, this.y + yOffset, delay)
    }

    /**
     * Point to loggable format
     * @returns {String} 
     */
    toString() {
        return "X: " this.x " Y: " this.y
    }

    /**
     * Point to loggable format
     * @returns {String} 
     */
    toStringWColour() {
        return this.toString() " is now " this.GetColour()
    }

    /**
     * Gets the colour at the point, protected by trycatch
     * @returns {String} 
     */
    GetColour() {
        try {
            fetchedColour := PixelGetColor(this.x, this.y)
        } catch as exc {
            Log("Error 36: GetColour check failed - " exc.Message)
            MsgBox("Could not GetColour due to the following error:`n"
                exc.Message)
        }
        return fetchedColour
    }

    /**
     * Compare colour at point to string
     * @param colour 
     * @returns {Integer} 
     */
    IsColour(colour) {
        fetchedColour := this.GetColour()
        if (colour = fetchedColour) {
            return true
        }
        return false
    }

    /**
     * Create blank tooltip at point with optional id
     * @param {Integer} id 
     */
    ToolTipAtCoord(id := 15) {
        ToolTip(" ", this.x, this.y, id)
    }

    /**
     * Clickoffset with loop that checks for specified colour, useful for 
     * clicking until something changes.
     * @param colour 
     * @param {Integer} maxLoops Max number of loops permitted before exit
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} 
     */
    ClickOffsetWhileColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1, delay := 54, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            if (i = 0) {
                return false
            }
        }
        VerboseLog("ClickOffsetWhileColour: " this.toString() " is now " this.GetColour() "`n")
        return true
    }

    /**
     * Clickoffset with loop that checks for NOT being the specified colour, 
     * useful for clicking until something changes.
     * @param colour 
     * @param {Integer} maxLoops Max number of loops permitted before exit
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} 
     */
    ClickOffsetUntilColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1, delay := 54, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && !this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            if (i = 0) {
                VerboseLog("ClickOffsetUntilColour: Hit max clicks " this.toString() " is now " this.GetColour() "`n")
                return false
            }
        }
        return true
    }

    /**
     * Loop until colour found or max loops reached
     * @param colour 
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour changed, false if not
     */
    WaitWhileColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() = colour) {
            Sleep(interval)
            i--
            if (i = 0) {
                break
            }
        }
        VerboseLog("WaitWhileColour: " this.toString() " is now " this.GetColour() "`n")
        if (this.GetColour() != colour) {
            return true
        } else {
            return false
        }
    }

    /**
     * Loop until not colour specified or max loops reached
     * @param colour 
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        while (IsWindowActive() && this.GetColour() != colour) {
            Sleep(interval)
            i--
            if (i = 0) {
                break
            }
        }
        VerboseLog("WaitUntilColour: " this.toString() " is now " this.GetColour() "`n")
        if (this.GetColour() = colour) {
            return true
        } else {
            return false
        }
    }

    /**
     * Click with decending amounts of modifiers used when button becomes
     * inactive, starting at 25000.
     * @param {Integer} delay 
     */
    GreedyModifierUsageClick(delay := 54) {
        AmountArr := ["25000", "2500", "1000", "250", "100", "25", "10", "1"]
        if (!IsWindowActive() || !IsPanelActive() ||
            !this.IsButtonActive()) {
            return
        }
        for Amount in AmountArr {
            AmountToModifier(Amount)
            Sleep(NavigateTime)
            while (IsWindowActive() && IsPanelActive() &&
                this.IsButtonActive()) {
                this.ClickOffset()
                Sleep(delay)
            }
        }
    }

    /**
     * Click with decending amounts of modifiers used when button becomes
     * inactive, starting at 25000 or startAt amount.
     * @param {Integer} startAt 
     * @param {Integer} delay 
     */
    GreedyCappedModifierUsageClick(startAt := 25000, delay := 54) {
        AmountArr := ["25000", "2500", "1000", "250", "100", "25", "10", "1"]
        if (!IsWindowActive() || !IsPanelActive() ||
            !this.IsButtonActive()) {
            return
        }
        for Amount in AmountArr {
            if (startAt <= Amount) {
                AmountToModifier(Amount)
                Sleep(NavigateTime)
                while (IsWindowActive() && IsPanelActive() &&
                    this.IsButtonActive()) {
                    this.ClickOffset()
                    Sleep(delay)
                }
            }
        }
    }
}