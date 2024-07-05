#Requires AutoHotkey v2.0

/**
 * Contains state and tests for 1 stage of game progress
 */
Class cGameStage {
    ; Name of the stage the class represents
    Name := ""
    /**
     * Array of cTask  
     * @type {cTask[]} 
     */
    TaskList := []

    Any() {
        return { Stage: "Any" }
    }

    GetCurrent() {

    }

    IsChunkComplete() {

    }

    GetPhaseTasklist() {

    }

    RunTaskList() {
        for task in this.TaskList {
            task.Loop()
        }
    }
}