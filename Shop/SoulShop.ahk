#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSoulShop extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(2147, 1221).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.SoulShop.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1687, 310).ClickButtonActive() ; unlock banks
        Sleep(50)
        If (!cPoint(1323, 427).IsBackground()) {
            cPoint(1690, 422).ClickButtonActive() ; unlock borb taxi 
            Sleep(50)
        }
        cPoint(1860, 534).ClickButtonActive() ; key finder
        Sleep(50)
        cPoint(1862, 654).ClickButtonActive() ; key multi
        Sleep(50)
        cPoint(1861, 764).ClickButtonActive() ; particle finder
        Sleep(50)
        cPoint(1862, 878).ClickButtonActive() ; particle multi
        Sleep(50)
        cPoint(1860, 990).ClickButtonActive() ; bonus reward finder
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1859, 537).ClickButtonActive() ; bonus reward multi
        Sleep(50)
        cPoint(1857, 649).ClickButtonActive() ; leaf dmg multi 1
        Sleep(50)
        cPoint(1857, 762).ClickButtonActive() ; leaf dmg multi 2
        Sleep(50)
        cPoint(1861, 873).ClickButtonActive() ; leaf dmg multi 3
        Sleep(50)
        cPoint(1860, 985).ClickButtonActive() ; leaf dmg multi 4
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1855, 527).ClickButtonActive() ; brew multi 1
        Sleep(50)
        cPoint(1861, 642).ClickButtonActive() ; brew multi 2
        Sleep(50)
        cPoint(1857, 750).ClickButtonActive() ; brew multi 3
        Sleep(50)
        cPoint(1856, 866).ClickButtonActive() ; brew multi 4
        Sleep(50)
        cPoint(1857, 972).ClickButtonActive() ; craft hammer
        Sleep(50)
    }
}
