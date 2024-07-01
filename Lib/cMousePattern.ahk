#Requires AutoHotkey v2.0

/** @type {cMousePattern} */
global MousePattern := cMousePattern()

Class cMousePattern {

    Task := () => {}

    SetThreeHorizontal() {
        point1 := 
    }

    SetFiveHorizontal() {

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
        while (this.StopCallback) {
            for point in this.PatternArr {
                MouseMove(point.x, point.y, 5, false)
            }
        }
    }

    Stop() {
        this.StopCallback := false
    }

}