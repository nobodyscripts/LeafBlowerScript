#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMulch extends Zone {

    GoTo(*) {
        UlcWindow()
        Sleep(50)
        Travel.ClosePanelIfActive()
        cPoint(1569, 1218).Click()
        Sleep(150)
    }

    Max(*) {
        Shops.Mulch.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1862, 418).ClickButtonActive() ; mulched composter (seeds count)
        Sleep(50)
        cPoint(1858, 532).ClickButtonActive() ; mulched seeds (seed reward %)
        Sleep(50)
        cPoint(1857, 692).ClickButtonActive() ; mulched chests (chests luck)
        Sleep(50)
        cPoint(1856, 810).ClickButtonActive() ; mulched luck (chests tier)
        Sleep(50)
        cPoint(1863, 914).ClickButtonActive() ; mulched slots
        Sleep(50)
        cPoint(1863, 1028).ClickButtonActive() ; insert more mulch (claw)
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1859, 580).ClickButtonActive() ; mulched claw
        Sleep(50)
        cPoint(1855, 689).ClickButtonActive() ; cursed pub (claw curse count)
        Sleep(50)
        cPoint(1857, 805).ClickButtonActive() ; Material pub
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1860, 350).ClickButtonActive() ; trade caps
        Sleep(50)
        cPoint(1859, 462).ClickButtonActive() ; trade optimization
        Sleep(50)
        cPoint(1860, 577).ClickButtonActive() ; leaf trader (trade count)
        Sleep(50)
        cPoint(1855, 687).ClickButtonActive() ; craft hammer
        Sleep(50)
        cPoint(1863, 797).ClickButtonActive() ; craft backpack
        Sleep(50)
        cPoint(1859, 911).ClickButtonActive() ; leaf counter macro
        Sleep(50)
        cPoint(1862, 1023).ClickButtonActive() ; cards detector
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1862, 935).ClickButtonActive() ; card parts detector
        Sleep(50)
    }

    BuyTrade(*) {
        Shops.Mulch.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        Travel.ScrollAmountDown(14)
        Sleep(50)
        cPoint(1860, 350).ClickButtonActive() ; trade caps
        Sleep(50)
        cPoint(1859, 462).ClickButtonActive() ; trade optimization
        Sleep(50)
        cPoint(1860, 577).ClickButtonActive() ; leaf trader (trade count)
    }
}
