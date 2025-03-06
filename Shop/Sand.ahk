#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSand extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        
        cPoint(1327, 1318).ClickOffset(,,72) ; Shop button
        If (!Window.AwaitPanel()) {
            Out.I("Sand shop button colour: " cPoint(1327, 1318).GetColour())
            cPoint(1327, 1318).ClickOffset(,,72) ; Shop button redundancy
        }
        Return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        If (!Shops.Sand.GoTo()) {
            Return false
        }
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1858, 309).ClickButtonActive() ; max sand marketing
        Sleep(50)
        Return true
    }

    WaitForSandOrTimeout(*) {
        UlcWindow()
        
        /** @type {Timer} */
        shopLimiter := Timer()
        shopLimiter.CoolDownS(15, &shopisactive)
        while (!Shops.Sand.GoTo() && shopisactive) {
            Sleep(17)
        }
        Travel.ScrollResetToTop()
        Sleep(50)
        /** @type {Timer} */
        Limiter := Timer()
        Limiter.CoolDownS(5, &isactive)
        gToolTip.CenterCD("Waiting for Sand to build up", 20000)
        While (!cPoint(1858, 309).IsBackground() && isactive) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        gToolTip.CenterCDDel()
        Return cPoint(1858, 309).IsBackground()
    }
}
