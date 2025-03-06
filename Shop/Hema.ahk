#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sHematite extends Zone {
    /**
     * Is the shop icon unlocked or not
     */
    IsShopUnlocked() {
        /** @type {cPoint} */
        point := cPoint(1691, 1308)
        Out.D(point.GetColour())
        return point.IsButtonActive() ? true : false
    }

    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        if (!this.IsShopUnlocked()) {
            Out.E("Failure: Hema shop not unlocked for use")
        }
        cPoint(1691, 1308).ClickOffset() ; Shop button
        If (!Window.AwaitPanel()) {
            Out.I("Hematite shop button colour: " cPoint(1691, 1308).GetColour())
            cPoint(1691, 1308).ClickOffset() ; Shop button
        }
        Return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        If (!Shops.Hematite.GoTo()) {
            Return false
        }
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
        Return true
    }
    /**
     * Buy Craft Bags
     */
    BuyCraftBags() {
        If (!Shops.Hematite.GoTo()) {
            Return false
        }
        Travel.ScrollResetToTop()
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1863, 880).ClickButtonActive() ; bigger backpack
        Sleep(50)
        If (cPoint(1863, 880).IsButton()) {
            Return true
        }
        Return false
    }
}
