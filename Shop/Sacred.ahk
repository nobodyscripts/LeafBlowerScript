#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSacred extends Zone {

    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1496, 1306) ; Shop button
    }
    
    Max(*) {
        UlcWindow()
        Shops.Sacred.GoTo()
        Sleep(100)
        Travel.ScrollResetToTop()
        cPoint(1688, 311).ClickButtonActive() ; Unlock Relic
        Sleep(50)
        cPoint(1859, 451).ClickButtonActive() ; Relic drop chance
        Sleep(50)
        ; skip
        ; skip
        cPoint(1859, 787).ClickButtonActive() ; Crafting backpack
        Sleep(50)
        cPoint(1860, 900).ClickButtonActive() ; brew crit
        Sleep(50)
        cPoint(1858, 1010).ClickButtonActive() ; Brew time
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1686, 552).ClickButtonActive() ; Leafscension bot
        Sleep(50)
        cPoint(1857, 670).ClickButtonActive() ; Leafscender input reduction
        Sleep(50)
        cPoint(1860, 775).ClickButtonActive() ; Card detector
        Sleep(50)
        cPoint(1860, 890).ClickButtonActive() ; Card part detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1855, 443).ClickButtonActive() ; Craft hammer
        Sleep(50)
        cPoint(1687, 543).ClickButtonActive() ; Gem business
        Sleep(50)
        cPoint(1682, 654).ClickButtonActive() ; Ancient seed Unlock
        Sleep(50)
        cPoint(1687, 761).ClickButtonActive() ; amber seed
        Sleep(50)
        cPoint(1684, 877).ClickButtonActive() ; amethyst seed
        Sleep(50)
        cPoint(1679, 988).ClickButtonActive() ; emerald seed
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1689, 532).ClickButtonActive() ; kyanite seed
        Sleep(50)
        cPoint(1688, 645).ClickButtonActive() ; rhodonite seed
        Sleep(50)
        cPoint(1689, 752).ClickButtonActive() ; ruby seed
        Sleep(50)
        cPoint(1679, 860).ClickButtonActive() ; tektite seed
        Sleep(50)
        cPoint(1689, 977).ClickButtonActive() ; meeds
        Sleep(50)
    }
}
