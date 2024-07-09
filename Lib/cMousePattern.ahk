#Requires AutoHotkey v2.0

#Include hGlobals.ahk
#Include cPoint.ahk

/** @type {cMousePattern} */
Global MousePattern := cMousePattern()

Class cMousePattern {

    Task := () => {}

    SetThreeHorizontal() {
        WSeg := W / 8
        HSeg := H / 4
        left1 := cPoint(WSeg, HSeg)
        left2 := cPoint(WSeg, HSeg * 2)
        left3 := cPoint(WSeg, HSeg * 3)
        right1 := cPoint(WSeg * 7, HSeg)
        right2 := cPoint(WSeg * 7, HSeg * 2)
        right3 := cPoint(WSeg * 7, HSeg * 3)


        /**
         * |---------------------|
         * |  >>>>>>>>>>>>>>>>>  |
         * |                  |  |
         * |  <<<<<<<<<<<<<<<<<  |
         * |  |                  |
         * |  >>>>>>>>>>>>>>>>>  |
         * |---------------------|
         */

        ; Top left
        left1.MouseMove(0)
        ; Top right
        right1.MouseMove(10)
        ; Mid right
        right2.MouseMove(10)
        ; Mid left
        left2.MouseMove(10)
        ; Top left
        left3.MouseMove(10)
        ; Top left
        right3.MouseMove(10)

    }

    SetFiveHorizontal() {
        WSeg := W / 8
        HSeg := H / 6
        left1 := cPoint(WSeg, HSeg)
        left2 := cPoint(WSeg, HSeg * 2)
        left3 := cPoint(WSeg, HSeg * 3)
        left4 := cPoint(WSeg, HSeg * 4)
        left5 := cPoint(WSeg, HSeg * 5)
        right1 := cPoint(WSeg * 7, HSeg)
        right2 := cPoint(WSeg * 7, HSeg * 2)
        right3 := cPoint(WSeg * 7, HSeg * 3)
        right4 := cPoint(WSeg * 7, HSeg * 4)
        right5 := cPoint(WSeg * 7, HSeg * 5)

        ; Top left
        left1.MouseMove(0)
        ; Top right
        right1.MouseMove(10)
    }

    SetSpiral() {

    }

    SetBox() {

    }

    SetNull() {
        this.Task := () => {}
    }
}

Class cMouseTask {

    PatternArr := []
    Speed := 0
    StopCallback := () => {}

    __New(PatternArr, Speed, StopCallback) {
        this.PatternArr := PatternArr
        this.Speed := Speed
        this.StopCallback := StopCallback
    }

    Run() {
        While (this.StopCallback) {
            For point in this.PatternArr {
                MouseMove(point.x, point.y, 5, false)
            }
        }
    }

    Stop() {
        this.StopCallback := false
    }

}