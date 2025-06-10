#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk
#include ..\ScriptLib\cToolTip.ahk

Class sSoulForge extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cLBRButton(2213, 1217).Click() ; Shop button
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
        cLBRButton(1856, 310).ClickButtonActive() ; empty soul leaf generator
        Sleep(50)
        cLBRButton(1860, 417).ClickButtonActive() ; empty soul leaf multiplier
        Sleep(50)
        cLBRButton(1858, 534).ClickButtonActive() ; completion reward
        Sleep(50)
        cLBRButton(1860, 647).ClickButtonActive() ; completion reward multiplier
        Sleep(50)
        cLBRButton(1861, 756).ClickButtonActive() ; soul forge compressor
        Sleep(50)
        cLBRButton(1860, 868).ClickButtonActive() ; Advanced empty soul leaf generator
        Sleep(50)
        cLBRButton(1868, 978).ClickButtonActive() ; advanced empty soul leaf multiplier
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1859, 520).ClickButtonActive() ; advanced completion reward
        Sleep(50)
        cLBRButton(1862, 638).ClickButtonActive() ; advanced completion reward multiplier
        Sleep(50)
        cLBRButton(1860, 745).ClickButtonActive() ; advanced soul forge compressor
        Sleep(50)
        cLBRButton(1858, 857).ClickButtonActive() ; soul crypt max floors
        Sleep(50)
        cLBRButton(1859, 970).ClickButtonActive() ; leaf damage multiplier
        Sleep(50)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        cLBRButton(1697, 823).ClickButtonActive() ; craft forge
        Sleep(50)
        cLBRButton(1860, 941).ClickButtonActive() ; craft hammer
        Sleep(50)
    }

    Critical() {
        UlcWindow()
        Shops.SoulForge.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cLBRButton(1856, 310).WaitUntilActiveButton()
        cLBRButton(1856, 310).ClickButtonActive() ; empty soul leaf generator

        cLBRButton(1860, 417).WaitUntilActiveButton()
        cLBRButton(1860, 417).ClickButtonActive() ; empty soul leaf multiplier

        cLBRButton(1858, 534).WaitUntilActiveButton()
        cLBRButton(1858, 534).ClickButtonActive() ; completion reward

        cLBRButton(1860, 647).WaitUntilActiveButton()
        cLBRButton(1860, 647).ClickButtonActive() ; completion reward multiplier

        cLBRButton(1861, 756).WaitUntilActiveButton()
        cLBRButton(1861, 756).ClickButtonActive() ; soul forge compressor

        cLBRButton(1860, 868).WaitUntilActiveButton()
        cLBRButton(1860, 868).ClickButtonActive() ; Advanced empty soul leaf generator

        cLBRButton(1868, 978).WaitUntilActiveButton()
        cLBRButton(1868, 978).ClickButtonActive() ; advanced empty soul leaf multiplier

        Sleep(50)
        Travel.ScrollAmountDown(7)

        cLBRButton(1859, 520).WaitUntilActiveButton()
        cLBRButton(1859, 520).ClickButtonActive() ; advanced completion reward

        cLBRButton(1862, 638).WaitUntilActiveButton()
        cLBRButton(1862, 638).ClickButtonActive() ; advanced completion reward multiplier

        cLBRButton(1860, 745).WaitUntilActiveButton()
        cLBRButton(1860, 745).ClickButtonActive() ; advanced soul forge compressor

        cLBRButton(1858, 857).WaitUntilActiveButton()
        cLBRButton(1858, 857).ClickButtonActive() ; soul crypt max floors

        cLBRButton(1859, 970).WaitUntilActiveButton()
        cLBRButton(1859, 970).ClickButtonActive() ; leaf damage multiplier

        gToolTip.CenterCD("Buying all max crypt floors", 120000)
        /** @type {Timer} */
        ctimer := Timer()
        ctimer.CoolDownM(2, &bool)
        While (cLBRButton(1858, 857).IsButton() && bool) {
            cLBRButton(1858, 857).ClickButtonActive() ; soul crypt max floors
            Sleep(100)
            cLBRButton(1859, 970).ClickButtonActive() ; leaf damage multiplier
            Sleep(100)
        }
        gToolTip.CenterCDDel()
    }
}
