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
        left1 := cPoint(WSeg, HSeg, false)
        left2 := cPoint(WSeg, HSeg * 2, false)
        left3 := cPoint(WSeg, HSeg * 3, false)
        right1 := cPoint(WSeg * 7, HSeg, false)
        right2 := cPoint(WSeg * 7, HSeg * 2, false)
        right3 := cPoint(WSeg * 7, HSeg * 3, false)

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
        right1.MouseMoveInterpolateTo()
        ; Mid right
        right2.MouseMoveInterpolateTo()
        ; Mid left
        left2.MouseMoveInterpolateTo()
        ; Bottom left
        left3.MouseMoveInterpolateTo()
        ; Bottom left
        right3.MouseMoveInterpolateTo()
    }

    SetFiveHorizontal() {
        WSeg := W / 8
        HSeg := H / 6
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
        ; Top left
        left1.MouseMove(0)
        ; Top right
        right1.MouseMoveInterpolateTo()
        ; Second row
        right2.MouseMoveInterpolateTo()
        ;
        left2.MouseMoveInterpolateTo()
        ; Mid row
        left3.MouseMoveInterpolateTo()
        ;
        right3.MouseMoveInterpolateTo()
        ; Fourth row
        right4.MouseMoveInterpolateTo()
        ;
        left4.MouseMoveInterpolateTo()
        ; Bottom row
        left5.MouseMoveInterpolateTo()
        ;
        right5.MouseMoveInterpolateTo()
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
        WSeg := W / 8
        HSeg := H / 6

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

        ; Top left
        left1.MouseMove(0)
        ; Top right
        right1.MouseMoveInterpolateTo()
        right2.MouseMoveInterpolateTo()
        left2.MouseMoveInterpolateTo()
        left3.MouseMoveInterpolateTo()
        right3.MouseMoveInterpolateTo()
        right4.MouseMoveInterpolateTo()
        left4.MouseMoveInterpolateTo()
        left5.MouseMoveInterpolateTo()
        right5.MouseMoveInterpolateTo()
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
        WSeg := W / 8
        HSeg := H / 6

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
        
        right5.MouseMove(0)
        left5.MouseMoveInterpolateTo()
        left4.MouseMoveInterpolateTo()
        right4.MouseMoveInterpolateTo()
        right3.MouseMoveInterpolateTo()
        left3.MouseMoveInterpolateTo()
        left2.MouseMoveInterpolateTo()
        right2.MouseMoveInterpolateTo()
        ; Top right
        right1.MouseMoveInterpolateTo()
        ; Top left
        left1.MouseMoveInterpolateTo()
    }

    SetBox() {

    }

    SetNull() {
        this.Task := () => {}
    }
}