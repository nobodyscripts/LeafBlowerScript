#Requires AutoHotkey v2.0

#Include cPoint.ahk

If (!IsSet(MousePattern)) {
    /** @type {cMousePattern} */
    Global MousePattern := cMousePattern()
}

Class cMousePattern {
    /**
     * Mouse movement pattern array of points to move mouse to
     * @type {cPoint[]} cPoint Array
     */
    Pattern := []

    /**
     * Run mousemove on set of points in Pattern
     * @param Interupt If true stop Task mid way
     */
    Task(Interupt) {
        If (this.Pattern != []) {
            first := true
            For (point in this.Pattern) {
                If (Interupt()) {
                    Break
                }
                If (first) {
                    ; Move instantly to first point
                    point.MouseMove(0)
                    first := false
                } Else {
                    ; Otherwise move incrementally to point to 'smooth' motion
                    point.MouseMoveInterpolateTo(50)
                }
            }
        }
    }

    SetThreeHorizontal() {
        /**
         * |---------------------|
         * |  >>>>>>>>>>>>>>>>>  |
         * |                  |  |
         * |  <<<<<<<<<<<<<<<<<  |
         * |  |                  |
         * |  >>>>>>>>>>>>>>>>>  |
         * |---------------------|
         */
        WSeg := Window.W / 8
        HSeg := Window.H / 4
        left1 := cPoint(WSeg, HSeg, false)
        left2 := cPoint(WSeg, HSeg * 2, false)
        left3 := cPoint(WSeg, HSeg * 3, false)
        right1 := cPoint(WSeg * 7, HSeg, false)
        right2 := cPoint(WSeg * 7, HSeg * 2, false)
        right3 := cPoint(WSeg * 7, HSeg * 3, false)
        this.Pattern := [left1, right1, right2, left2, left3, right3]
    }

    ThreeHorizontal() {
        this.SetThreeHorizontal()
        this.Task(false)
    }

    SetFiveHorizontal() {
        /**
         * |---------------------------------|
         * |  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |
         * |                              |  |
         * |  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  |
         * |  |                              |
         * |  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |
         * |                              |  |
         * |  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  |
         * |  |                              |
         * |  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |
         * |---------------------------------|
         */
        WSeg := Window.W / 8
        HSeg := Window.H / 6
        left1 := cPoint(WSeg, HSeg, false)
        left2 := cPoint(WSeg, HSeg * 2, false)
        left3 := cPoint(WSeg, HSeg * 3, false)
        left4 := cPoint(WSeg, HSeg * 4, false)
        left5 := cPoint(WSeg, HSeg * 5, false)
        right1 := cPoint(WSeg * 7, HSeg, false)
        right2 := cPoint(WSeg * 7, HSeg * 2, false)
        right3 := cPoint(WSeg * 7, HSeg * 3, false)
        right4 := cPoint(WSeg * 7, HSeg * 4, false)
        right5 := cPoint(WSeg * 7, HSeg * 5, false)
        this.Pattern := [left1, right1, right2, left2, left3, right3, right4,
            left4, left5, right5]
    }

    FiveHorizontal() {
        this.SetFiveHorizontal()
        this.Task(false)
    }

    SetSpiral() {
        /**
         * |---------------------------------|
         * |  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |
         * |                              |  |
         * |  |>>>>>>>>>>>>>>>>>>>>>>>>>  |  |
         * |  |                        |  |  |
         * |  |  >>>>>>>>>>>>>>>>>>>>  |  |  |
         * |  |  |                     |  |  |
         * |  |  <<<<<<<<<<<<<<<<<<<<<<<  |  |
         * |  |                           |  |
         * |  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  |
         * |---------------------------------|
         */
        WSeg := Window.W / 8
        HSeg := Window.H / 6

        left1 := cPoint(WSeg, HSeg, false)
        left2 := cPoint(WSeg, HSeg * 5, false)
        left3 := cPoint(WSeg, HSeg * 2, false)
        left4 := cPoint(WSeg * 2, HSeg * 4, false)
        left5 := cPoint(WSeg * 2, HSeg * 3, false)
        right1 := cPoint(WSeg * 7, HSeg, false)
        right2 := cPoint(WSeg * 7, HSeg * 5, false)
        right3 := cPoint(WSeg * 5, HSeg * 2, false)
        right4 := cPoint(WSeg * 5, HSeg * 4, false)
        right5 := cPoint(WSeg * 6, HSeg * 3, false)
        this.Pattern := [left1, right1, right2, left2, left3, right3, right4,
            left4, left5, right5]
    }

    Spiral() {
        this.SetSpiral()
        this.Task(false)
    }

    SetSpiralReverse() {
        /**
         * |---------------------------------|
         * |  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  |
         * |                              |  |
         * |  |>>>>>>>>>>>>>>>>>>>>>>>>>  |  |
         * |  |                        |  |  |
         * |  |  >>>>>>>>>>>>>>>>>>>>  |  |  |
         * |  |  |                     |  |  |
         * |  |  <<<<<<<<<<<<<<<<<<<<<<<  |  |
         * |  |                           |  |
         * |  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  |
         * |---------------------------------|
         */
        WSeg := Window.W / 8
        HSeg := Window.H / 6

        left1 := cPoint(WSeg, HSeg, false)
        left2 := cPoint(WSeg, HSeg * 5, false)
        left3 := cPoint(WSeg, HSeg * 2, false)
        left4 := cPoint(WSeg * 2, HSeg * 4, false)
        left5 := cPoint(WSeg * 2, HSeg * 3, false)
        right1 := cPoint(WSeg * 7, HSeg, false)
        right2 := cPoint(WSeg * 7, HSeg * 5, false)
        right3 := cPoint(WSeg * 5, HSeg * 2, false)
        right4 := cPoint(WSeg * 5, HSeg * 4, false)
        right5 := cPoint(WSeg * 6, HSeg * 3, false)
        this.Pattern := [right5, left5, left4, right4, right3, left3, left2,
            right2, right1, left1]
    }

    SpiralReverse() {
        this.SetSpiralReverse()
        this.Task(false)
    }

    SetBox() {
        /**
         * |---------------------------------|
         * |                                 |
         * |    >>>>>>>>>>>>>>>>>>>>>>>>>    |
         * |    |                       |    |
         * |    |                       |    |
         * |    |                       |    |
         * |    |                       |    |
         * |    |                       |    |
         * |    <<<<<<<<<<<<<<<<<<<<<<<<<    |
         * |                                 |
         * |---------------------------------|
         */
        WSeg := Window.W / 8
        HSeg := Window.H / 6
        left1 := cPoint(WSeg * 2, HSeg * 2, false)
        left2 := cPoint(WSeg * 2, HSeg * 6, false)
        right1 := cPoint(WSeg * 6, HSeg * 2, false)
        right2 := cPoint(WSeg * 6, HSeg * 6, false)
        this.Pattern := [left1, right1, right2, left2]
    }

    Box() {
        this.SetBox()
        this.Task(false)
    }
}
