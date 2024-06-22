#Requires AutoHotkey v2.0

#Include cTask.ahk

Class Feature extends cTask {
    ; Is task running
    _isRunning := false
    ; Period to run for
    RunFor := -1
    ; Cooldown before task runs again
    Cooldown := 0
    ; What loadout the task needs
    Loadout := 0
    ; What Zone is needed for task
    Zone := Zone()

    CheckGameSettings() {

    }

    Initialise() {

    }

    Run() {

    }

    RunOnce() {

    }

    Cleanup() {

    }

}
#Include <cZone>