#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMalachite extends Zone {

    /**
     * Is the shop icon unlocked or not
     */
    IsShopUnlocked() {
        /** @type {cLBRButton} */
        point := cLBRButton(1691, 1308)
        Out.D(point.GetColour())
        Return point.IsButtonActive() ? true : false
    }

    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        If (!this.IsShopUnlocked()) {
            Out.E("Failure: Malachite shop not unlocked for use")
        }
        cLBRButton(1639, 1308).ClickOffset() ; Shop button
        If (!Window.AwaitPanel()) {
            Out.I("Malachite shop button colour: " cLBRButton(1639, 1308).GetColour())
            cLBRButton(1639, 1308).ClickOffset() ; Shop button
        }
        Return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Malachite.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cLBRButton(1691, 305).ClickButtonActive() ; unlock hema
        Sleep(50)
        cLBRButton(1687, 649).ClickButtonActive() ; Unlock shardify
        Sleep(50)
        cLBRButton(1858, 761).ClickButtonActive() ; shardify upgrade
        Sleep(50)
        cLBRButton(1858, 872).ClickButtonActive() ; focused tools
        Sleep(50)
        cLBRButton(1861, 985).ClickButtonActive() ; focused equipment
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1861, 528).ClickButtonActive() ; focused pets
        Sleep(50)
        cLBRButton(1856, 642).ClickButtonActive() ; focued uniques
        Sleep(50)
        cLBRButton(1856, 747).ClickButtonActive() ; Craft hammer
        Sleep(50)
        cLBRButton(1858, 858).ClickButtonActive() ; card detector
        Sleep(50)
        cLBRButton(1863, 975).ClickButtonActive() ; boss card detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1700, 945).ClickButtonActive() ; Gem business
        Sleep(50)
    }
}
