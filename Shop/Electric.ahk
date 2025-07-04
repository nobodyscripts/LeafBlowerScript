#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk
#include ..\ScriptLib\cToolTip.ahk

Class sElectric extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cLBRButton(1981, 1303).Click() ; Shop button
        Return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Electric.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cLBRButton(1861, 312).ClickButtonActive() ; storage
        Sleep(50)
        cLBRButton(1859, 419).ClickButtonActive() ; charging value
        Sleep(50)
        cLBRButton(1858, 536).ClickButtonActive() ; max relic
        Sleep(50)
        cLBRButton(1860, 642).ClickButtonActive() ; relic damage
        Sleep(50)
        cLBRButton(1689, 758).ClickButtonActive() ; unlock plasma to energy converters
        Sleep(50)
        cLBRButton(1693, 866).ClickButtonActive() ; gem business
        Sleep(50)
        cLBRButton(1693, 979).ClickButtonActive() ; unlock mirrors
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1860, 717).ClickButtonActive() ; mirror efficiency
        Sleep(50)
        cLBRButton(1696, 825).ClickButtonActive() ; relic fragments
        Sleep(50)
        cLBRButton(1865, 944).ClickButtonActive() ; relic fragment chance
        Sleep(50)
    }

    WaitForElectricOrTimeout(*) {
        UlcWindow()
        Shops.Electric.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        /** @type {Timer} */
        Limiter := Timer()
        chargingcount := storagecount := 0
        Limiter.CoolDownS(15, &isactive)
        gToolTip.CenterCD("Waiting for Electric to build up", 15000)

        cLBRButton(1689, 758).ClickButtonActive() ; unlock plasma to energy converters
        Sleep(50)
        While (isactive && (storagecount < 3 && chargingcount < 3)) {
            If (cLBRButton(1861, 312).ClickButtonActive()) { ; storage
                storagecount++
            }
            Sleep(250)
            If (cLBRButton(1859, 419).ClickButtonActive()) { ; charging value
                chargingcount++
            }
            Sleep(250)
        }
        gToolTip.CenterCDDel()
    }

}
