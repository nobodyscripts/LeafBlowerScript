#Requires AutoHotkey v2.0

#Include ..\Lib\TAS\cTask.ahk
#Include ..\Lib\cMousePattern.ahk

Class BlowLeaves extends cTask {
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
            throw Error("No StopWhen() set")
        }
}