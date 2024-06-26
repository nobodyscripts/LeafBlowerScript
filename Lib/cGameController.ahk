#Requires AutoHotkey v2.0

/**
 * Controller for TAS functionality
 */
Class cGameController {
    ; Progress state of user ingame
    Progress := Progress()
    ; Object of current tasks for this phase of progression
    Tasklist := this.Progress.GetChunkTaskList()

}

/**
 * Contains state and tests for 1 phase of game progress
 */
Class Progress {

    TaskList := TaskList()

    GetCurrent() {

    }

    IsChunkComplete() {

    }

    GetPhaseTasklist() {

    }
}

Class TaskList {
    
/** @type {Task} Array of Task*/
    Tasks := []
}


