#Requires AutoHotkey v2.0

#Include ..\Lib\hTas.ahk
#Include ..\Lib\cMousePattern.ahk

Class BlowLeaves extends cTask {
    RunFor := 60
    Cooldown := 20
    Loadout := -1
    Zone := Zone()
    GameStage := cGameStage().Any()

    /**
     * 
     */
    PreTask() {
        Out.I("Starting Blow Leaves task")
    }

    /**
     * Run task to blow leaves off the screen
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        MousePattern.SetThreeHorizontal()
        MousePattern.Task(InteruptMousePattern)
        MousePattern.SetFiveHorizontal()
        MousePattern.Task(InteruptMousePattern)
        MousePattern.SetSpiral()
        MousePattern.Task(InteruptMousePattern)
        MousePattern.SetSpiralReverse()
        MousePattern.Task(InteruptMousePattern)

        InteruptMousePattern() {
            Return false
        }
        Return true
    }

    /**
     * 
     */
    PostTask() {
        Out.I("Ending Blow Leaves task")
    }

    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
        Return true
    }
}