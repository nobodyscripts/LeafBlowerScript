#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMoonstone extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1259, 1319).Click() ; Shop button
        return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Moonstone.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1697, 307).ClickButtonActive() ; Unlock sand
        Sleep(50)
    }

    WaitForMoonstoneOrTimeout(*) {
        UlcWindow()
        gToolTip.Center("Waiting for Moonstone to build up")
        while(!cPoint(1259, 1319).IsButtonActive()) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        Shops.Moonstone.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        /** @type {Timer} */
        Limiter := Timer()
        chargingcount := storagecount := 0
        Limiter.CoolDownS(20, &isactive)
        While(!cPoint(1697, 307).IsBackground() && isactive) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        gToolTip.CenterDel()
        return cPoint(1697, 307).IsBackground()
    }
}
