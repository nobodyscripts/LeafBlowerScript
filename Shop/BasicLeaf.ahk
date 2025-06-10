#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk
#Include ..\ScriptLib\cGameStage.ahk
#Include ..\ScriptLib\cTask.ahk

Class sBasic extends Zone {

    Max(*) {

    }
}

Class ShopBasicLeaf extends cTask {
    RunFor := 60
    Cooldown := 20
    Loadout := -1
    Zone := Zone()
    GameStage := cGameStage().Any()

    /**
     * 
     */
    PreTask() {
        Out.I("Starting Shop BasicLeaf task")
        Travel.Shop.BasicLeaf.Goto()
    }

    /**
     * Run task to purchase shop items
     * @returns {Boolean} Return false to exit task loop early
     */
    Task() {
        While (Points.Shop.BasicLeaf.UnlockGold.IsButtonActive()) {
            Points.Shop.BasicLeaf.UnlockGold.ClickOffset()
        }
        While (Points.Shop.BasicLeaf.Tree.IsButtonActive()) {
            Points.Shop.BasicLeaf.Tree.ClickOffset()
        }
        While (Points.Shop.BasicLeaf.Fertilizer.IsButtonActive()) {
            Points.Shop.BasicLeaf.Fertilizer.ClickOffset()
        }
        While (Points.Shop.BasicLeaf.Marketing.IsButtonActive()) {
            Points.Shop.BasicLeaf.Marketing.ClickOffset()
        }
        While (Points.Shop.BasicLeaf.NuclearFuel.IsButtonActive()) {
            Points.Shop.BasicLeaf.NuclearFuel.ClickOffset()
        }
        While (Points.Shop.BasicLeaf.ALB.IsButtonActive()) {
            Points.Shop.BasicLeaf.ALB.ClickOffset()
        }

        Return true
    }

    /**
     * 
     */
    PostTask() {
        Out.I("Ending Shop BasicLeaf task")
    }

    /**
     * Check for loops allows loop to be exited based on conditions.
     * @returns {Boolean} Return false to exit task loop early
     */
    StopWhen() {
        Return true
    }
}