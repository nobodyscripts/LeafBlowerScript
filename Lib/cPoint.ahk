#Requires AutoHotkey v2.0

#Include cColours.ahk
#Include SettingsCheck.ahk

/**
 * Debug flag for DebugLog
 * @type {Bool}
 */
Global Debug := false

/**
 * Defines the resolution independant locations for pixel checks.  
 * Convert positions from 2560*1369 client resolution to current resolution.
 * Create with relative coords and relative on, or use fixed coords with it off
 * to handle scaling manually (for dynamic situations).  
 * cPoint(x, y, relative) to construct.
 * @example
 * cPoint(1, 10) ; Returns cPoint class
 * @example
 * cPoint(1, 10, false) ; Returns cPoint class with non relative coords
 * @class
 * @public
 * @argument {Integer} x X value (output depends on .relative)
 * @argument {Integer} y Y value (output depends on .relative)
 * @argument {Boolean} relative Set true for relative coords on get, false for
 * original values
 * @property {Integer} x X value (output depends on .relative)
 * @property {Integer} y Y value (output depends on .relative)
 * @property {Boolean} relative Set true for relative coords on get, false for
 * original values
 * @function Set Set new values after construction
 * @function IsBackground Is point a background colour
 * @function IsButton Is point a button colour
 * @function IsButtonActive Is point an active button colour
 * @function IsButtonInactive Is point an inactive button colour
 * @function IsButtonOffPanel Is point an off panel button colour 
 * @function Click Click left mouse button at point
 * @function ClickOffset Click left mouse button at point with an offset
 * @function MouseMove Move mouse to point
 * @function toString Convert x y to readable string
 * @function toStringWColour toSting with colour
 * @function toStringDisplay toString to 2 decimal places
 * @function GetColour Get pixel colour at point
 * @function IsColour Check if pixel colour at point is equal
 * @function ToolTipAtCoord Create a blank tooltip with top left at point
 * @function ClickOffsetUntilColour Click offset while colour doesn't match
 * @function ClickOffsetWhileColour Click offset while colour matches
 * @function WaitUntilColour Loop while colour doesn't match
 * @function WaitWhileColour Loop while colour matches
 * @function GreedyModifierClick Use decending value modifiers to click while
 * looping on an active button, start at cap amount
 * @function ClientToScreen Convert point xy to screenspace xy and return as
 * Array
 * @function ClientToScreencPoint Convert point xy to screenspace xy and return
 * new cPoint
 */
Class cPoint {
    /**
     * If W has a value returns relative coord
     * otherwise returns raw value
     * @type {Integer}
     * @public
     */
    x {
        get {
            Global W
            If (this.relative && IsSet(W)) {
                Return this._x / 2560 * W
            } Else {
                If (!IsSet(W)) {
                    Log("ERR: W not set")
                }
                Return this._x
            }
        }
        set {
            this._x := Value
            Return this._x
        }
    }

    /**
     * If H has a value returns relative coord
     * otherwise returns raw value
     * @type {Integer}
     * @public
     */
    y {
        get {
            Global H
            If (this.relative && IsSet(H)) {
                Return this._y / 1369 * H
            } Else {
                If (!IsSet(H)) {
                    Log("ERR: H not set")
                }
                Return this._y
            }
        }
        set {
            this._y := Value
            Return this._y
        }
    }
    /**
     * Set true for relative coords on get, false for original values
     * @type {Boolean}
     * @public
     */
    relative := true

    /**
     * Create new point instance using 2560*1440 resolution resolution
     * maximised client coords
     * @constructor
     * @param x 
     * @param y 
     * @param relative Set true for relative coords on get, false for original values
     */
    __New(x := "", y := "", relative := true) {
        this.x := x
        this.y := y
        this.relative := relative
    }

    /**
     * Set values on precreated cPoint
     * @param x 
     * @param y 
     * @param {Integer=} relative Set true for relative coords on get, false for original values
     * @returns {cPoint}
     * @function
     */
    Set(x, y, relative := true) {
        this.x := x
        this.y := y
        this.relative := relative
        Return this
    }

    /**
     * Is the colour of the point a button colour
     * @returns {Bool} 
     */
    IsButton() {
        targetColour := this.GetColour()
        If (Colours().IsButton(targetColour)) {
            Return true
        }
        VerboseLog("cPoint.IsButton: " this.toStringDisplay() " is now " targetColour
        )
        Return false
    }

    /**
     * Is the colour of the point an active button colour
     * @returns {Bool} 
     */
    IsButtonActive() {
        targetColour := this.GetColour()
        If (Colours().IsButtonActive(targetColour)) {
            Return true
        }
        VerboseLog("cPoint.IsButtonActive: " this.toStringDisplay() " is now " targetColour
        )

        Return false
    }

    /**
     * Is the colour of the point an inactive button
     * @returns {Bool} 
     */
    IsButtonInactive() {
        targetColour := this.GetColour()
        If (Colours().IsButtonInactive(targetColour)) {
            Return true
        }
        VerboseLog("cPoint.IsButtonInactive: " this.toStringDisplay() " is now " targetColour
        )

        Return false
    }

    /**
     * Is the colour of the point a background panel colour
     * @returns {Bool} 
     */
    IsBackground() {
        targetColour := this.GetColour()
        If (Colours().IsBackground(targetColour)) {
            Return true
        }
        VerboseLog("cPoint.IsBackground: " this.toStringDisplay() " is now " targetColour
        )

        Return false
    }

    /**
     * Is the colour of the point an active button, off panel colour
     * @returns {Bool} 
     */
    IsButtonOffPanel() {
        targetColour := this.GetColour()
        If (Colours().IsButtonOffPanel(targetColour)) {
            Return true
        }
        VerboseLog("cPoint.IsButtonOffPanel: " this.toStringDisplay() " is now " targetColour
        )

        Return false
    }

    /**
     * Mouse click at point with optional delay
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     */
    Click(clickdelay := 34) {
        fCustomClick(this.x, this.y, clickdelay)
    }

    /**
     * Mouseclick at point with optional xy offset and delay
     * @param {Integer} [xOffset] Amount to offset X when clicking to avoid 
     * covering point
     * @param {Integer} [yOffset] Amount to offset Y when clicking to avoid 
     * covering point
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     */
    ClickOffset(xOffset := 1, yOffset := 1, clickdelay := 34) {
        fCustomClick(this.x + xOffset, this.y + yOffset, clickdelay)
    }

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
    ClickButtonActive(xOffset := 1, yOffset := 1, clickdelay := 34, sleepafter :=
        NavigateTime) {
        If (this.IsButtonActive()) {
            this.ClickOffset(, , clickdelay)
            Sleep(sleepafter)
            Return true
        }
        Return false
    }

    /**
     * Move mouse to point
     * @param {Integer} speed 0-100 with 100 being slowest
     * @param {String} relative Set to "R" for relative to current location
     */
    MouseMove(speed := 5, relative := "") {
        MouseMove(this.x, this.y, speed, relative)
    }


    MouseMoveInterpolateTo() {
        MouseGetPos(&startx, &starty)
        travelx := (this.x - startx) / 20
        travely := (this.y - starty) / 20
        If (travely != 0 && travelx = 0) {
            travelx := (this.x - startx) / 10
            travely := (this.y - starty) / 10
            i := 1
            Loop 10 {
                MouseMove(startx + (travelx * i), starty + (travely * i), 50)
                Sleep(17)
                i++
            }
            Return
        }
        i := 1
        Loop 20 {
            MouseMove(startx + (travelx * i), starty + (travely * i), 50)
            Sleep(17)
            i++
        }
    }

    /**
     * Point to loggable format
     * @returns {String} 
     */
    toString() {
        Return "X: " this.x " Y: " this.y
    }

    /**
     * Point to loggable format to 2 decimal places
     * @returns {String} 
     */
    toStringDisplay() {
        Return "X: " Format("{:#.2f}", this.x) " Y: " Format("{:#.2f}", this.y)
    }

    /**
     * Point to loggable format
     * @returns {String} 
     */
    toStringWColour() {
        Return this.toStringDisplay() " is now " this.GetColour()
    }

    /**
     * Gets the colour at the point, protected by trycatch
     * @returns {String} 
     */
    GetColour() {
        Try {
            fetchedColour := PixelGetColor(this.x, this.y)
        } Catch As exc {
            Log("Error 36: GetColour check failed - " exc.Message)
            MsgBox("Could not GetColour due to the following error:`n" exc.Message
            )
        }
        Return fetchedColour
    }

    /**
     * Compare colour at point to string
     * @param colour 
     * @returns {Integer} 
     */
    IsColour(colour) {
        fetchedColour := this.GetColour()
        If (colour = fetchedColour) {
            Return true
        }
        Return false
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
     * @memberof cPoint
     * @param colour 
     * @param {Integer} maxLoops Max number of loops permitted before exit
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} interval Delay between loop passes
     * @returns {Bool} 
     */
    ClickOffsetWhileColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1,
        delay := 54, interval := 50) {
        i := maxLoops
        While (IsWindowActive() && this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            If (i = 0) {
                Return false
            }
        }
        VerboseLog("ClickOffsetWhileColour: " this.toStringWColour())
        Return true
    }

    /**
     * Clickoffset with loop that checks for NOT being the specified colour, 
     * useful for clicking until something changes.
     * @memberof cPoint
     * @param colour 
     * @param {Integer} maxLoops Max number of loops permitted before exit
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} interval Delay between loop passes
     * @returns {Bool} 
     */
    ClickOffsetUntilColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1,
        delay := 54, interval := 50) {
        i := maxLoops
        While (IsWindowActive() && !this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            If (i = 0) {
                VerboseLog("ClickOffsetUntilColour: Hit max clicks " this.toStringWColour()
                )
                Return false
            }
        }
        Return true
    }

    /**
     * Loop until colour found or max loops reached
     * @memberof cPoint
     * @param colour 
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Bool} True if colour changed, false if not
     */
    WaitWhileColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        While (IsWindowActive() && this.GetColour() = colour) {
            Sleep(interval)
            i--
            If (i = 0) {
                Break
            }
        }
        VerboseLog("WaitWhileColour: " this.toStringWColour())
        If (this.GetColour() != colour) {
            Return true
        } Else {
            Return false
        }
    }

    /**
     * Loop until not colour specified or max loops reached
     * @memberof cPoint
     * @param colour 
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour matches, false if not
     */
    WaitUntilColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        While (IsWindowActive() && this.GetColour() != colour) {
            Sleep(interval)
            i--
            If (i = 0) {
                Break
            }
        }
        VerboseLog("WaitUntilColour: " this.toStringWColour())
        If (this.GetColour() = colour) {
            Return true
        } Else {
            Return false
        }
    }

    /**
     * Click with decending amounts of modifiers used when button becomes
     * inactive, starting at 25000 or startAt amount.
     * @memberof cPoint
     * @param {Integer} sleeptime Time to sleep between clicks 
     * @param {Integer} delay Time to wait between mousedown and mouseup
     * @param {Integer} startAt Amount for keyboard modifier starting level
     */
    GreedyModifierClick(sleeptime := 54, delay := 54, startAt := 25000) {
        AmountArr := ["25000", "2500", "1000", "250", "100", "25", "10", "1"]
        If (!IsWindowActive() || !IsPanelActive() || !this.IsButtonActive()) {
            Return
        }
        For Amount in AmountArr {
            If (Amount <= startAt) {
                AmountToModifier(Amount)
                VerboseLog("GreedyModifierClick amount " Amount)
                Sleep(NavigateTime)
                While (IsWindowActive() && IsPanelActive() && this.IsButtonActive()
                ) {
                    this.ClickOffset(5, 5, delay)
                    Sleep(sleeptime)
                }
            }
        }
    }

    /**
     * Converts current cPoint to screenspace and returns [x,y]
     * @memberof cPoint
     * @param hWnd 
     * @returns {Array} [x,y]
     */
    ClientToScreen(hWnd?) {
        ptr := Buffer(8), NumPut("int", this.x, "int", this.y, ptr)
        DllCall("ClientToScreen", "ptr", hWnd, "ptr", ptr)
        sx := NumGet(ptr, 0, "int"), sy := NumGet(ptr, 4, "int")
        Return [sx, sy]
    }

    /**
     * Converts current cPoint to screenspace and returns a new cPoint
     * @memberof cPoint
     * @param hWnd 
     * @returns {cPoint} 
     */
    ClientToScreencPoint(hWnd?) {
        ptr := Buffer(8), NumPut("int", this.x, "int", this.y, ptr)
        DllCall("ClientToScreen", "ptr", WinExist(LBRWindowTitle), "ptr", ptr)
        sx := NumGet(ptr, 0, "int"), sy := NumGet(ptr, 4, "int")
        Return cPoint(sx, sy, false)
    }
}