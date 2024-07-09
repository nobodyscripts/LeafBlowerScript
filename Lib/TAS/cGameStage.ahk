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
        Return {
            Stage: "Any"
        }
    }

    GetCurrent() {

    }

    IsChunkComplete() {

    }

    GetPhaseTasklist() {

    }

    RunTaskList() {
        For task in this.TaskList {
            task.Loop()
        }
    }
}