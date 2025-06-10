#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk
#include ..\ScriptLib\cToolTip.ahk

Class sSand extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()

        cLBRButton(1327, 1318).ClickOffset(, , 72) ; Shop button
        If (!Window.AwaitPanel()) {
            Out.I("Sand shop button colour: " cLBRButton(1327, 1318).GetColour())
            cLBRButton(1327, 1318).ClickOffset(, , 72) ; Shop button redundancy
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
        cLBRButton(1858, 309).ClickButtonActive() ; max sand marketing
        Sleep(50)
        Return true
    }

    WaitForSandOrTimeout(*) {
        UlcWindow()

        /** @type {Timer} */
        shopLimiter := Timer()
        shopLimiter.CoolDownS(15, &shopisactive)
        While (!Shops.Sand.GoTo() && shopisactive) {
            Sleep(17)
        }
        Travel.ScrollResetToTop()
        Sleep(50)
        /** @type {Timer} */
        Limiter := Timer()
        Limiter.CoolDownS(5, &isactive)
        gToolTip.CenterCD("Waiting for Sand to build up", 20000)
        While (!cLBRButton(1858, 309).IsBackground() && isactive) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        gToolTip.CenterCDDel()
        Return cLBRButton(1858, 309).IsBackground()
    }
}
