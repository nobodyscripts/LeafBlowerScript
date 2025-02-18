#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sCoal extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1855, 1309).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Coal.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1686, 313).ClickButtonActive() ; unlock mines
        Sleep(50)
        ;skip
        ;skip
        cPoint(1861, 648).ClickButtonActive() ; heat resistance
        Sleep(50)
        cPoint(1862, 759).ClickButtonActive() ; anti crumble
        Sleep(50)
        cPoint(1859, 875).ClickButtonActive() ; prison hint
        Sleep(50)
        cPoint(1696, 984).ClickButtonActive() ; boss anti-regen health
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1857, 528).ClickButtonActive() ; green flame vuln
        Sleep(50)
        cPoint(1857, 639).ClickButtonActive() ; spectral vuln
        Sleep(50)
        cPoint(1689, 781).ClickButtonActive() ; auto ascend cards
        Sleep(50)
        cPoint(1688, 889).ClickButtonActive() ; auto transcend cards
        Sleep(50)
        cPoint(1686, 1000).ClickButtonActive() ; craft forge level
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1860, 605).ClickButtonActive() ; craft hammer
        Sleep(50)
        cPoint(1695, 714).ClickButtonActive() ; unlock craft sacred
        Sleep(50)
        cPoint(1689, 825).ClickButtonActive() ; unlock craft bio
        Sleep(50)
        cPoint(1686, 935).ClickButtonActive() ; gem business
        Sleep(50)
    }
}
