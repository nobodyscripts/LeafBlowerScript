#Requires AutoHotkey v2.0

/** @type {cMousePattern} */
global MousePattern := cMousePattern()

Class cMousePattern {
    
    Task := () => {}

    SetThreeHorizontal() {

    }

    SetFiveHorizontal() {

    }

    SetSpiral() {

    }

    SetBox() {

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

    Run(){
        while (this.StopCallback) {
            for point in this.PatternArr {

            }
        }
    }

    Stop() {
        this.StopCallback := false
    }

}