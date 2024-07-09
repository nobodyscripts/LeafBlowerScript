#Requires AutoHotkey v2.0

#Include ..\Lib\hTas.ahk
#Include ..\Lib\cMousePattern.ahk

Class BlowLeaves extends cTask {
    RunFor := 60
    Cooldown := -1
    Loadout := -1
    Zone := Zone().Any()
    GameStage := cGameStage().Any()

    /**
     * 
     */
    PreTask() {
        MousePattern.SetFiveHorizontal()
    }

    /**
     * Run task to blow leaves off the screen
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        MousePattern.Task()

    }

    /**
     * 
     */
    PostTask() {
        MousePattern.SetNull()
    }

    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
        Throw Error("No StopWhen() set")
    }
}