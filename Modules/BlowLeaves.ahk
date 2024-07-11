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
        Log("Starting Blow Leaves task")
    }

    /**
     * Run task to blow leaves off the screen
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        Log("Blow Leaves task loop")
        MousePattern.SetThreeHorizontal()
        MousePattern.Task()
        MousePattern.SetFiveHorizontal()
        MousePattern.Task()
        MousePattern.SetSpiral()
        MousePattern.Task()
        MousePattern.SetSpiralReverse()
        MousePattern.Task()
    }

    /**
     * 
     */
    PostTask() {
        Log("Ending Blow Leaves task")
    }

    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
    }
}