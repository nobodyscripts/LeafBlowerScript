#Requires AutoHotkey v2.0

#Include cGameWindow.ahk

/**
 * Defines the resolution independant locations for pixel checks.  
 * Convert positions from default client resolution to current resolution.
 * Create with relative coords and relative on, or use fixed coords with it off
 * to handle scaling manually (for dynamic situations).  
 * cPoint(x, y, relative) to construct.
 * @function __New construct
 * @example
 * cPoint(1, 10) ; Returns cPoint class
 * cPoint(1, 10, false) ; Returns cPoint class with non relative coords
 * @module cPoint
 * @argument {Integer} x X value (output depends on .relative)
 * @argument {Integer} y Y value (output depends on .relative)
 * @argument {Boolean} relative Set true for relative coords on get, false for
 * original values
 * @property {Integer} x X value (output depends on .relative)
 * @property {Integer} y Y value (output depends on .relative)
 * @property {Boolean} relative Set true for relative coords on get, false for
 * original values
 * 
 * @function Set Set new values after construction
 * @function IsBackground Is point a background colour
 * @function IsButton Is point a button colour
 * @function IsButtonActive Is point an active button colour
 * @function IsButtonInactive Is point an inactive button colour
 * @function IsButtonOffPanel Is point an off panel button colour 
 * @function Click Click left mouse button at point
 * @function ClickOffset Click left mouse button at point with an offset
 * @function ClickButtonActive Click left mouse button at point if active
 * @function MouseMove Move mouse to point
 * @function toString Convert x y to readable string
 * @function toStringWColour toSting with colour
 * @function toStringDisplay toString to 2 decimal places
 * @function GetColour Get pixel colour at point
 * @function IsColour Check if pixel colour at point is equal
 * @function ToolTipAtCoord Create a blank tooltip with top left at point
 * @function ClickOffsetUntilColour Click offset while colour doesn't match
 * @function ClickOffsetWhileColour Click offset while colour matches
 * @function WaitWhileNotColour Loop while colour doesn't match
 * @function WaitWhileColour Loop while colour matches
 * @function WaitUntilActiveButton Loop till active button or max loop
 * @function GreedyModifierClick Use decending value modifiers to click while
 * looping on an active button, start at cap amount
 * @function ClientToScreen Convert point xy to screenspace xy and return as
 * Array
 * @function ClientToScreencPoint Convert point xy to screenspace xy and return
 * new cPoint
 */
Class cPoint {
    /**
     * If Window.W has a value returns relative coord
     * otherwise returns raw value
     * @type {Integer}
     * @public
     */
    x {
        get {
            If (this.relative && Window.W != 0) {
                Return this._x / Window.DefW * Window.W
            } Else {
                If (Window.W = 0) {
                    Out.E("Window.W not set")
                }
                Return this._x
            }
        }
        set {
            this._x := Value
            If (Value > Window.DefW) {
                Out.D("Value given to cPoint out of range for default value")
                Out.Stack()
            }
            Return this._x
        }
    }

    /**
     * If Window.H has a value returns relative coord
     * otherwise returns raw value
     * @type {Integer}
     * @public
     */
    y {
        get {
            If (this.relative && Window.H != 0) {
                Return this._y / Window.DefH * Window.H
            } Else {
                If (Window.H = 0) {
                    Out.E("Window.H not set")
                }
                Return this._y
            }
        }
        set {
            this._y := Value
            If (Value > Window.DefH) {
                Out.D("Value given to cPoint out of range for default value")
                Out.Stack()
            }
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
     * Create new point instance using def resolution resolution
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
     * Mouse click at point with optional delay
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     */
    Click(clickdelay := 34) {
        If (!Window.IsActive()) {
            Out.E("No window found while trying to click at " this.x " * " this
                .y)
            Return false
        }
        MouseClick("Left", this.x, this.y, , , "D")
        Sleep(clickdelay)
        MouseClick("Left", this.x, this.y, , , "U")
        ; Out.D("Clicking at " this.toStringDisplay())
    }

    /**
     * Mouse click at point with optional delay
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     */
    ClickR(clickdelay := 34) {
        If (!Window.IsActive()) {
            Out.E("No window found while trying to click at " this.x " * " this
                .y)
            Return false
        }
        MouseClick("Right", this.x, this.y, , , "D")
        Sleep(clickdelay)
        MouseClick("Right", this.x, this.y, , , "U")
        ; Out.D("Clicking at " this.toStringDisplay())
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
        If (!Window.IsActive()) {
            Out.E("No window found while trying to click at " this.x + xOffset " * " this
                .y + yOffset)
            Return false
        }
        MouseClick("left", this.x + xOffset, this.y + yOffset, , , "D")
        Sleep(clickdelay)
        MouseClick("left", this.x + xOffset, this.y + yOffset, , , "U")
        ; Out.D("Clicking at " this.toStringDisplay(xOffset, yOffset))
    }

    /**
     * Right Mouseclick at point with optional xy offset and delay
     * @param {Integer} [xOffset] Amount to offset X when clicking to avoid 
     * covering point
     * @param {Integer} [yOffset] Amount to offset Y when clicking to avoid 
     * covering point
     * @param {Integer} [clickdelay=34] Delay for mouseclick
     */
    ClickOffsetR(xOffset := 1, yOffset := 1, clickdelay := 34) {
        If (!Window.IsActive()) {
            Out.I("No window found while trying to click at " this.x + xOffset " * " this
                .y + yOffset)
            Return false
        }
        MouseClick("right", this.x + xOffset, this.y + yOffset, , , "D")
        Sleep(clickdelay)
        MouseClick("right", this.x + xOffset, this.y + yOffset, , , "U")
        ; Out.D("Clicking at " this.toStringDisplay(xOffset, yOffset))
    }

    /**
     * Move mouse to point
     * @param {Integer} speed 0-100 with 100 being slowest
     * @param {String} relative Set to "R" for relative to current location
     */
    MouseMove(speed := 5, relative := "") {
        MouseMove(this.x, this.y, speed, relative)
    }

    /**
     * Move mouse to point
     * @param {Integer} speed 0-100 with 100 being slowest
     * @param {String} relative Set to "R" for relative to current location
     * @param {Integer} offsetX Default X + 1
     * @param {Integer} offsetY Default Y + 1
     */
    MouseMoveOffset(speed := 5, relative := "", offsetX := 1, offsetY := 1) {
        MouseMove(this.x + offsetX, this.y + offsetY, speed, relative)
    }

    MouseMoveInterpolateTo(speed := 50, sleepperiod := 17) {
        MouseGetPos(&startx, &starty)
        travelx := (this.x - startx) / 20
        travely := (this.y - starty) / 20
        If (travely != 0 && travelx = 0) {
            travelx := (this.x - startx) / 10
            travely := (this.y - starty) / 10
            i := 1
            Loop 10 {
                MouseMove(startx + (travelx * i), starty + (travely * i), speed
                )
                Sleep(sleepperiod)
                i++
            }
            Return
        }
        i := 1
        Loop 20 {
            MouseMove(startx + (travelx * i), starty + (travely * i), speed)
            Sleep(sleepperiod)
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
    toStringDisplay(xOffset := 0, yOffset := 0) {
        Return "X: " Format("{:#.2f}", this.x + xOffset) " Y: " Format(
            "{:#.2f}", this.y + yOffset)
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
     * @returns {String} 0xFFFFFF
     */
    GetColour() {
        Try {
            fetchedColour := PixelGetColor(this.x, this.y)
        } Catch As exc {
            Out.E("GetColour check failed - " exc.Message)
            MsgBox("Could not GetColour due to the following error:`n" exc.Message
            )
        }
        Return fetchedColour
    }

    /**
     * Compare colour at point to string 
     * @param colour 0xFFFFFF
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
     * Create blank tooltip at point with optional id
     * @param {Integer} id 
     */
    TextTipAtCoord(text := " ", id := 15) {
        ToolTip(text, this.x, this.y, id)
    }

    /**
     * Clickoffset with loop that checks for specified colour, useful for 
     * clicking until something changes.
     * @memberof cPoint
     * @param {String} colour "0xFFFFFF"
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
        While (Window.IsActive() && this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            If (i = 0) {
                Return false
            }
        }
        ;Out.D("ClickOffsetWhileColour: " this.toStringWColour())
        Return true
    }

    /**
     * Clickoffset with loop that checks for specified colour, useful for 
     * clicking until something changes.
     * @memberof cPoint
     * @param {Array} colour "0xFFFFFF","0xFFFFFF"
     * @param {Integer} maxLoops Max number of loops permitted before exit
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} interval Delay between loop passes
     * @returns {Bool} 
     */
    ClickOffsetWhileArrColour(colour, maxLoops := 20, offsetX := 1, offsetY := 1,
        delay := 54, interval := 50) {
        i := maxLoops
        While (Window.IsActive() && _IsProvidedColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            If (i = 0) {
                Return false
            }
        }
        ;Out.D("ClickOffsetWhileColour: " this.toStringWColour())

        _IsProvidedColour(colour) {
            j := 1
            Loop colour.Length {
                If (this.IsColour(colour[j])) {
                    Return true
                }
                j++
            }
            Return false
        }

        Return true
    }

    /**
     * Clickoffset with loop that checks for specified colour, useful for 
     * clicking until something changes.
     * @memberof cPoint
     * @param colour 
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} seconds Time period for loop
     * @returns {Bool} 
     */
    ClickOffsetWhileColourS(colour, offsetX := 1, offsetY := 1, delay := 54, seconds := 10) {
        Return this.ClickOffsetWhileColour(colour, seconds * 1000 / 20, offsetX, offsetY, delay, 20)
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
        While (Window.IsActive() && !this.IsColour(colour)) {
            this.ClickOffset(offsetX, offsetY, delay)
            Sleep(interval)
            i--
            If (i = 0) {
                ;Out.D("ClickOffsetUntilColour: Hit max clicks " this.toStringWColour())
                Return false
            }
        }
        Return true
    }

    /**
     * Clickoffset with loop that checks for NOT being the specified colour, 
     * useful for clicking until something changes.
     * @memberof cPoint
     * @param colour 
     * @param {Integer} offsetX 
     * @param {Integer} offsetY 
     * @param {Integer} delay Click delay
     * @param {Integer} seconds Time period for loop
     * @returns {Bool} 
     */
    ClickOffsetUntilColourS(colour, offsetX := 1, offsetY := 1, delay := 54, seconds := 10) {
        Return this.ClickOffsetUntilColour(colour, seconds * 1000 / 20, offsetX, offsetY, delay, 20)
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
        While (Window.IsActive() && this.GetColour() = colour) {
            Sleep(interval)
            i--
            If (i <= 0) {
                Break
            }
        }
        ;Out.D("WaitWhileColour: " this.toStringWColour())
        Return this.GetColour() != colour
    }

    /**
     * Loop until colour found or max loops reached
     * @memberof cPoint
     * @param colour 
     * @param {Integer} seconds Time period for loop
     * @returns {Bool} True if colour changed, false if not
     */
    WaitWhileColourS(colour, seconds := 10) {
        Return this.WaitWhileColour(colour, seconds * 1000 / 20, 20)
    }

    /**
     * Loop until not colour specified or max loops reached
     * @memberof cPoint
     * @param colour 
     * @param {Integer} maxLoops 
     * @param {Integer} interval Delay between loop passes
     * @returns {Integer} True if colour matches, false if not
     */
    WaitWhileNotColour(colour, maxLoops := 20, interval := 50) {
        i := maxLoops
        ;Out.D("WaitWhileNotColour: start " this.toStringWColour())
        While (Window.IsActive() && this.GetColour() != colour) {
            Sleep(interval)
            i--
            If (i <= 0) {
                Break
            }
        }
        ;Out.D("WaitWhileNotColour: finish " this.toStringWColour())
        Return this.GetColour() = colour
    }

    /**
     * Loop until not colour specified or max loops reached
     * @memberof cPoint
     * @param colour 
     * @param {Integer} seconds Time period for loop
     * @returns {Integer} True if colour matches, false if not
     */
    WaitWhileNotColourS(colour, seconds := 10) {
        Return this.WaitWhileNotColour(colour, seconds * 1000 / 20, 20)
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
        Return [
            sx,
            sy
        ]
    }

    /**
     * Converts current cPoint to screenspace and returns a new cPoint
     * @memberof cPoint
     * @param hWnd 
     * @returns {cPoint} 
     */
    ClientToScreencPoint(hWnd?) {
        ptr := Buffer(8), NumPut("int", this.x, "int", this.y, ptr)
        DllCall("ClientToScreen", "ptr", WinExist(Window.Title), "ptr", ptr)
        sx := NumGet(ptr, 0, "int"), sy := NumGet(ptr, 4, "int")
        Return cPoint(sx, sy, false)
    }
}
