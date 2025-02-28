#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sElectric extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1981, 1303).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Electric.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1861, 312).ClickButtonActive() ; storage
        Sleep(50)
        cPoint(1859, 419).ClickButtonActive() ; charging value
        Sleep(50)
        cPoint(1858, 536).ClickButtonActive() ; max relic
        Sleep(50)
        cPoint(1860, 642).ClickButtonActive() ; relic damage
        Sleep(50)
        cPoint(1689, 758).ClickButtonActive() ; unlock plasma to energy converters
        Sleep(50)
        cPoint(1693, 866).ClickButtonActive() ; gem business
        Sleep(50)
        cPoint(1693, 979).ClickButtonActive() ; unlock mirrors
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1860, 717).ClickButtonActive() ; mirror efficiency
        Sleep(50)
        cPoint(1696, 825).ClickButtonActive() ; relic fragments
        Sleep(50)
        cPoint(1865, 944).ClickButtonActive() ; relic fragment chance
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

        cPoint(1689, 758).ClickButtonActive() ; unlock plasma to energy converters
        Sleep(50)
        While (isactive && (storagecount < 3 && chargingcount < 3)) {
            If (cPoint(1861, 312).ClickButtonActive()) { ; storage
                storagecount++
            }
            Sleep(250)
            If (cPoint(1859, 419).ClickButtonActive()) { ; charging value
                chargingcount++
            }
            Sleep(250)
        }
        gToolTip.CenterCDDel()
    }

}
