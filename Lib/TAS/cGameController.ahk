#Requires AutoHotkey v2.0

#Include cProgress.ahk
#Include cGameProgress.ahk
#Include ../CheckGameSettings.ahk

/**
 * Controller for TAS functionality.
 * Handles main logic and is the controller for tasks
 */
Class cGameController {
    ; Progress state of user ingame
    Progress := Progress()
    ; Object of current tasks for this phase of progression
    Tasklist := this.Progress.GetChunkTaskList()

    Run() {
        fCheckGameSettings()

        this.Progress.LoadCurrent()

        Loop {
            Log("Current progress stage " this.Progress.Name)
            For Task in this.Progress.TaskList {
                Log("Running " Task.Name)
                Task.Run()
            }
        }

    }
}