#Requires AutoHotkey v2.0


Class cTask {
    Task := () => {}
    StopCallback := () => {}
    Looping := false

    __New(Task, StopCallback) {
        this.Task := Task
        this.StopCallback := StopCallback
    }

    Loop(){
        this.Looping := true
        while (this.StopCallback) {
            this.Task()
        }
        this.Looping := false
    }

    LoopTill(msecs){
        this.Looping := true
        while (this.StopCallback) {
            this.Task()
        }
        this.Looping := false
    }

    Stop() {
        this.Looping := false
        this.StopCallback := false
    }

    IsRunning() {
        return this.Looping
    }

    RunOnce() {
        this.Looping := true
        this.Task()
        this.Looping := false
    }

    RunOnceIn(msecs) {
        SetTimer(this.RunOnce, -msecs)
    }

    LoopIn(msecs) {
        SetTimer(this.Loop, -msecs)
    }
}