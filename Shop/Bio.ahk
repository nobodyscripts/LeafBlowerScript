#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sBiotite extends Zone {

    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1568, 1308).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */    
    Max(*) {
        UlcWindow()
        Shops.Biotite.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1683, 305).ClickButtonActive() ; Unlock Malachite
        Sleep(50)
        ; skip
        ; skip
        cPoint(1858, 630).ClickButtonActive() ; Mat storage
        Sleep(50)
        cPoint(1857, 759).ClickButtonActive() ; mtf
        Sleep(50)
        cPoint(1859, 879).ClickButtonActive() ; mtf%
        Sleep(50)
        cPoint(1862, 987).ClickButtonActive() ; max tool lvl
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1860, 529).ClickButtonActive() ; max equp level
        Sleep(50)
        cPoint(1862, 638).ClickButtonActive() ; max pet level
        Sleep(50)
        cPoint(1863, 751).ClickButtonActive() ; max unique level
        Sleep(50)
        cPoint(1858, 867).ClickButtonActive() ; craft hammer
        Sleep(50)
        cPoint(1859, 975).ClickButtonActive() ; cards detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1861, 828).ClickButtonActive() ; boss cards detector
        Sleep(50)
        cPoint(1693, 939).ClickButtonActive() ; Gem business
        Sleep(50)
    }
}
