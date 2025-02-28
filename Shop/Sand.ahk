#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSand extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1327, 1318).Click() ; Shop button
        return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Sand.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1858, 309).ClickButtonActive() ; max sand marketing
        Sleep(50)
    }

    WaitForSandOrTimeout(*) {
        UlcWindow()
        Shops.Sand.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        /** @type {Timer} */
        Limiter := Timer()
        Limiter.CoolDownS(20, &isactive)
        gToolTip.CenterCD("Waiting for Sand to build up", 20000)
        While(!cPoint(1858, 309).IsBackground() && isactive) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        gToolTip.CenterCDDel()
        return cPoint(1858, 309).IsBackground()
        
    }
}
