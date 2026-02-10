#Requires AutoHotkey v2.0

/**
 * Prestiges collection of functions for Prestiging
 * @module Prestiges
 * @method ActivateGoldPortal Leaf Crunch Activate
 * @method ActivateRedPortal BLC Activate
 * @method ActivateGreenPortal MLC Activate
 * @method WaitForPortalAnimation Dynamic wait for gui to reappear
 */
Class Prestiges {
    ;@region Activate portals
    /**
     * Leaf Crunch Activate
     */
    ActivateGoldPortal(*) {
        /** @type {cLBRButton} */
        prestigeButton := cLBRButton(1393, 551)
        UlcWindow()
        Out.D("Leaf Crunch Activate")
        Shops.OpenGoldPortal()
        prestigeButton.WaitUntilActiveButtonS(3)
        If (!prestigeButton.IsButtonActive()) {
            Out.I("Didn't find lc crunch button, aborting.")
            Global ULCStageExit := true
            Return false
        }
        prestigeButton.ClickButtonActive()
        prestigeButton.ClickButtonActive()
        prestigeButton.WaitUntilNotButtonS(10)
        Return true
    }

    /**
     * BLC Activate
     */
    ActivateRedPortal(*) {
        UlcWindow()
        Out.D("BLC Activate")
        Shops.OpenRedPortal()
        /** @type {cLBRButton} */
        crunchbtn := cLBRButton(1337, 558)
        crunchbtn.WaitUntilActiveButtonS(3)
        If (!crunchbtn.IsButtonActive()) {
            Out.I("Didn't find blc crunch button, aborting.")
            Global ULCStageExit := true
            Return false
        }
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilActiveButtonS(2)
        crunchbtn.ClickButtonActive()
        Sleep(34)
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilNotButtonS(10)
        Return true
    }

    /**
     * MLC Activate
     */
    ActivateGreenPortal(*) {
        /** @type {cLBRButton} */
        crunchbtn := cLBRButton(1329, 563)

        UlcWindow()
        Out.D("MLC Activate")
        Shops.OpenGreenPortal()
        crunchbtn.WaitUntilActiveButtonS(3)
        If (!crunchbtn.IsButtonActive()) {
            Out.I("Didn't find MLC Crunch button, aborting.")
            Global ULCStageExit := true
            Return false
        }
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilActiveButtonS(2)
        crunchbtn.ClickButtonActive()
        Sleep(34)
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilNotButtonS(10)
        Return true
    }
    /**
     * ULC Activate
     */
    ActivateBluePortal(*) {
        /** @type {cLBRButton} */
        crunchbtn := cLBRButton(1710, 498)
        UlcWindow()
        Out.D("ULC Activate")
        GameKeys.OpenBluePortal()
        crunchbtn.WaitUntilActiveButtonS(3)
        If (!crunchbtn.IsButtonActive()) {
            Out.I("Didn't find ULC Crunch button, aborting.")
            Global ULCStageExit := true
            Return false
        }
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilActiveButtonS(2)
        crunchbtn.ClickButtonActive()
        Sleep(34)
        crunchbtn.ClickButtonActive()
        crunchbtn.WaitUntilNotButtonS(10)
        Return true
    }

    WaitForPortalAnimation(*) {
        UlcWindow()
        Out.D("WaitForPortalAnimation")
        gToolTip.Center("Waiting for portal animation to finish")
        Points.Misc.NotifArrowExist.WaitUntilActiveButtonS(20)
        Sleep(200)
        If (!Points.Misc.NotifArrowExist.IsButtonActive()) {
            Out.I("Failed to see ui after portal animation")
            Global ULCStageExit := true
        }
        gToolTip.CenterDel()
    }
    ;@endregion
}
