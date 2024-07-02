#Requires AutoHotkey v2.0

#Include cTask.ahk
#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTimer.ahk

Class BlowLeaves extends cTask {
    RunFor := 60
    Cooldown := -1
    Loadout := -1
    Zone := Zone().Any()
    GameStage := cGameStage().Any()

    ; To complete for uses of the class
    PreTask() {
    }

    /**
     * To complete for uses of the class. 
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        return false
    }

    ; To complete for uses of the class
    PostTask() {
    }

}