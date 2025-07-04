#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sPlasma extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cLBRButton(1786, 1305).Click() ; Shop button
        Sleep(150)
    }

    /**
     * FirstPass shop upgrades
     */
    FirstPass(*) {
        UlcWindow()
        Shops.Plasma.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        ; skip
        ; skip
        cLBRButton(1862, 536).ClickButtonActive() ; Blow off
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1858, 756).ClickButtonActive() ; craft backpack
        Sleep(50)
        cLBRButton(1859, 867).ClickButtonActive() ; craft sets
        Sleep(50)
    }
    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Plasma.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        ; skip
        ; skip
        cLBRButton(1862, 536).ClickButtonActive() ; Blow off
        Sleep(50)
        cLBRButton(1863, 651).ClickButtonActive() ; Energy storage
        Sleep(50)
        cLBRButton(1857, 757).ClickButtonActive() ; Shard count
        Sleep(50)
        cLBRButton(1861, 876).ClickButtonActive() ; Leafscender time
        Sleep(50)
        cLBRButton(1858, 988).ClickButtonActive() ; type damage
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1858, 525).ClickButtonActive() ; cheaper transform
        Sleep(50)
        cLBRButton(1862, 645).ClickButtonActive() ; craft hammer
        Sleep(50)
        cLBRButton(1858, 756).ClickButtonActive() ; craft backpack
        Sleep(50)
        cLBRButton(1859, 867).ClickButtonActive() ; craft sets
        Sleep(50)
        cLBRButton(1687, 978).ClickButtonActive() ; gem business
        Sleep(50)
    }
}
