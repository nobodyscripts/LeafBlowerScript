#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMalachite extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1639, 1308).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Malachite.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1691, 305).ClickButtonActive() ; unlock hema
        Sleep(50)
        cPoint(1687, 649).ClickButtonActive() ; Unlock shardify
        Sleep(50)
        cPoint(1858, 761).ClickButtonActive() ; shardify upgrade
        Sleep(50)
        cPoint(1858, 872).ClickButtonActive() ; focused tools
        Sleep(50)
        cPoint(1861, 985).ClickButtonActive() ; focused equipment
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1861, 528).ClickButtonActive() ; focused pets
        Sleep(50)
        cPoint(1856, 642).ClickButtonActive() ; focued uniques
        Sleep(50)
        cPoint(1856, 747).ClickButtonActive() ; Craft hammer
        Sleep(50)
        cPoint(1858, 858).ClickButtonActive() ; card detector
        Sleep(50)
        cPoint(1863, 975).ClickButtonActive() ; boss card detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1700, 945).ClickButtonActive() ; Gem business
        Sleep(50)
    }
}
