#Requires AutoHotkey v2.0

#Include Functions.ahk

/**
 * Defines the locations resolution independant for area colour checks
 * @argument x1 X value top left
 * @argument y1 Y value top left
 * @argument x2 X value bottom right
 * @argument y2 Y value bottom right
 * @argument relative Set for % relative value, false for fixed
 * @property w Width
 * @property h Height
 * @method Set Coord values and relative
 * @method toString Returns coords as string for logging
 * @method ToolTipAtArea Places two blank tooltips at top left and bottom right 
 * of area aligned to top left corners of the tooltip
 * @method PixelSearch Find colour in area, returns coord
 */
Class cArea {
    x1 {
        get {
            global W
            if (this.relative && isset(W)) {
                return this._x1 / 2560 * W
            } else {
                if (!isset(W)) {
                    Log("ERR: W not set")
                }
                return this._x1
            }
        }
        set {
            this._x1 := value
            return this._x1
        }
    }

    y1 {
        get {
            global H
            if (this.relative && isset(H)) {
                return this._y1 / 1369 * H
            } else {
                if (!isset(H)) {
                    Log("ERR: H not set")
                }
                return this._y1
            }
        }
        set {
            this._y1 := value
            return this._y1
        }
    }

    x2 {
        get {
            global W
            if (this.relative && isset(W)) {
                return this._x2 / 2560 * W
            } else {
                if (!isset(W)) {
                    Log("ERR: W not set")
                }
                return this._x2
            }
        }
        set {
            this._x2 := value
            return this._x2
        }
    }

    y2 {
        get {
            global H
            if (this.relative && isset(H)) {
                return this._y2 / 1369 * H
            } else {
                if (!isset(H)) {
                    Log("ERR: H not set")
                }
                return this._y2
            }
        }
        set {
            this._y2 := value
            return this._y2
        }
    }

    w {
        get {
            if (this.x2 - this.x1 > 0) {
                return this.x2 - this.x1
            }
            return 0
        }
    }

    h {
        get {
            if (this.y2 - this.y1 > 0) {
                return this.y2 - this.y1
            }
            return 0
        }
    }

    relative := true

    __New(xin1 := "", yin1 := "", xin2 := "", yin2 := "") {
        if (xin1 != "" && yin1 != "" && xin2 != "" && yin2 != "") {
            this.Set(xin1, yin1, xin2, yin2)
        }
    }

    /**
     * Set area after creation
     * @param xin1 X1
     * @param yin1 Y1
     * @param xin2 X2
     * @param yin2 Y2
     * @param {Bool} relative Is relative or fixed
     * @returns {cArea} 
     */
    Set(xin1, yin1, xin2, yin2, relative := true) {
        this.x1 := xin1
        this.y1 := yin1
        this.x2 := xin2
        this.y2 := yin2
        this.Relative := relative
        return this
    }

    /**
     * Get log formatted string of area
     * @returns {String} Log formatted string form of coords
     */
    toString() {
        return ("X1: " this.x1 " Y1: " this.y1 " X2: " this.x2 " Y2: "
            this.y2 "`nW: " this.w " H: " this.h)
    }

    /**
     * Creates two blank tooltops to mark the area, top left corner and bottom 
     * right, top left corner of the tooltip marks the rect
     * @param {Integer} id1 Tooltip id for top left
     * @param {Integer} id2 Tooltip id for bottom right
     */
    ToolTipAtArea(id1 := 14, id2 := 15) {
        ToolTip(" ", this.x1, this.y1, id1)
        ToolTip(" ", this.x2, this.y2, id2)
    }

    /**
     * Find coord of colour in area
     * @param {String} colour "0xFFFFFF" Formatted strings
     * @param {Integer} variation Amount of colour variation allowed, 0-255 
     * none-any colour
     * @returns {Array | Bool} [x, y] or false
     */
    PixelSearch(colour := "0xFFFFFF", variation := 0) {
        try {
            found := PixelSearch(&OutX, &OutY,
                this.x1, this.y1,
                this.x2, this.y2, colour, variation)
            If (found and OutX != 0) {
                return [OutX, OutY] ; Found colour
            }
            VerboseLog("PixelSearch false: " colour " not found")
        } catch as exc {
            Log("Error 8: PixelSearch search failed - " exc.Message)
            MsgBox("Could not conduct the search due to the following error:`n"
                exc.Message)
        }
        return false
    }
}