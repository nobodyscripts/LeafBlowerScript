#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSoulForge extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(2213, 1217).Click() ; Shop button
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.SoulForge.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1856, 310).ClickButtonActive() ; empty soul leaf generator
        Sleep(50)
        cPoint(1860, 417).ClickButtonActive() ; empty soul leaf multiplier
        Sleep(50)
        cPoint(1858, 534).ClickButtonActive() ; completion reward
        Sleep(50)
        cPoint(1860, 647).ClickButtonActive() ; completion reward multiplier
        Sleep(50)
        cPoint(1861, 756).ClickButtonActive() ; soul forge compressor
        Sleep(50)
        cPoint(1860, 868).ClickButtonActive() ; Advanced empty soul leaf generator
        Sleep(50)
        cPoint(1868, 978).ClickButtonActive() ; advanced empty soul leaf multiplier
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1859, 520).ClickButtonActive() ; advanced completion reward
        Sleep(50)
        cPoint(1862, 638).ClickButtonActive() ; advanced completion reward multiplier
        Sleep(50)
        cPoint(1860, 745).ClickButtonActive() ; advanced soul forge compressor
        Sleep(50)
        cPoint(1858, 857).ClickButtonActive() ; soul crypt max floors
        Sleep(50)
        cPoint(1859, 970).ClickButtonActive() ; leaf damage multiplier
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cPoint(1697, 823).ClickButtonActive() ; craft forge
        Sleep(50)
        cPoint(1860, 941).ClickButtonActive() ; craft hammer
        Sleep(50)
    }

    Critical() {
        UlcWindow()
        Shops.SoulForge.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1856, 310).WaitUntilActiveButton()
        cPoint(1856, 310).ClickButtonActive() ; empty soul leaf generator

        cPoint(1860, 417).WaitUntilActiveButton()
        cPoint(1860, 417).ClickButtonActive() ; empty soul leaf multiplier

        cPoint(1858, 534).WaitUntilActiveButton()
        cPoint(1858, 534).ClickButtonActive() ; completion reward

        cPoint(1860, 647).WaitUntilActiveButton()
        cPoint(1860, 647).ClickButtonActive() ; completion reward multiplier

        cPoint(1861, 756).WaitUntilActiveButton()
        cPoint(1861, 756).ClickButtonActive() ; soul forge compressor

        cPoint(1860, 868).WaitUntilActiveButton()
        cPoint(1860, 868).ClickButtonActive() ; Advanced empty soul leaf generator

        cPoint(1868, 978).WaitUntilActiveButton()
        cPoint(1868, 978).ClickButtonActive() ; advanced empty soul leaf multiplier

        Sleep(50)
        Travel.ScrollAmountDown(7)

        cPoint(1859, 520).WaitUntilActiveButton()
        cPoint(1859, 520).ClickButtonActive() ; advanced completion reward

        cPoint(1862, 638).WaitUntilActiveButton()
        cPoint(1862, 638).ClickButtonActive() ; advanced completion reward multiplier

        cPoint(1860, 745).WaitUntilActiveButton()
        cPoint(1860, 745).ClickButtonActive() ; advanced soul forge compressor

        cPoint(1858, 857).WaitUntilActiveButton()
        cPoint(1858, 857).ClickButtonActive() ; soul crypt max floors

        cPoint(1859, 970).WaitUntilActiveButton()
        cPoint(1859, 970).ClickButtonActive() ; leaf damage multiplier

        gToolTip.CenterCD("Buying all max crypt floors", 120000)
        /** @type {Timer} */
        ctimer := Timer()
        ctimer.CoolDownM(2, &bool)
        While (cPoint(1858, 857).IsButton() && bool) {
            cPoint(1858, 857).ClickButtonActive() ; soul crypt max floors
            Sleep(100)
            cPoint(1859, 970).ClickButtonActive() ; leaf damage multiplier
            Sleep(100)
        }
        gToolTip.CenterCDDel()
    }
}
