#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sHematite extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1685, 556).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Hematite.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1686, 311).ClickButtonActive() ; Unlock energy
        Sleep(50)
        cPoint(1859, 418).ClickButtonActive() ; Energy storage
        Sleep(50)
        cPoint(1689, 532).ClickButtonActive() ; Unlock ascension shards
        Sleep(50)
        cPoint(1688, 648).ClickButtonActive() ; Unlock fusion shards
        Sleep(50)
        cPoint(1686, 766).ClickButtonActive() ; Unlock transformation shards
        Sleep(50)
        cPoint(1856, 877).ClickButtonActive() ; Saturated shards
        Sleep(50)
        ; Skip
        Travel.ScrollAmountDown(7)
        Sleep(50)
        ; Skip
        cPoint(1862, 650).ClickButtonActive() ; Craft forge
        Sleep(50)
        cPoint(1858, 768).ClickButtonActive() ; Craft Hammer
        Sleep(50)
        cPoint(1863, 880).ClickButtonActive() ; bigger backpack
        Sleep(50)
        cPoint(1859, 987).ClickButtonActive() ; card detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1861, 829).ClickButtonActive() ; boss card detector
        Sleep(50)
        cPoint(1695, 938).ClickButtonActive() ; Gem Business
    }
}
