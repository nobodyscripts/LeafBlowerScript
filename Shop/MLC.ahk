#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMLC extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        GameKeys.OpenMLCShop()
        Sleep(150)
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        Shops.MLC.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        If (cPoint(1689, 315).ClickButtonActive()) { ; unlock cards
            Sleep(50)
        }
        If (cPoint(1697, 407).ClickButtonActive()) { ; unlock bv
            Sleep(50)
        }
        If (cPoint(1859, 533).ClickButtonActive()) { ; All leaves
            Sleep(50)
        }
        If (cPoint(1860, 647).ClickButtonActive()) { ; MLC
            Sleep(50)
        }
        If (cPoint(1860, 756).ClickButtonActive()) { ; blc
            Sleep(50)
        }
        ; missing (toggle)
        ; missing (toggle)
        Travel.ScrollAmountDown(7)
        Sleep(50)
        ; missing (toggle)
        ; missing (toggle)
        ; missing (toggle)
        If (!Rects.MLCShop.AutoFacts.PixelSearch()) {
            If (cPoint(1692, 875).ClickButtonActive()) { ; Autofacts (toggle)
                Sleep(50)
            }
        }
        If (cPoint(1863, 989).ClickButtonActive()) { ; Faster Autofacts
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1858, 527).ClickButtonActive()) { ; Offline seeds
            Sleep(50)
        }
        If (cPoint(1859, 645).ClickButtonActive()) { ; Offline MLC
            Sleep(50)
        }
        If (cPoint(1863, 760).ClickButtonActive()) { ; offline mlc
            Sleep(50)
        }
        If (cPoint(1860, 870).ClickButtonActive()) { ; mtf
            Sleep(50)
        }
        If (cPoint(1860, 985).ClickButtonActive()) { ; crunchy tower
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1857, 528).ClickButtonActive()) { ; offline tower
            Sleep(50)
        }
        If (cPoint(1856, 646).ClickButtonActive()) { ; authority
            Sleep(50)
        }
        If (cPoint(1693, 766).ClickButtonActive()) { ; crunchy areas
            Sleep(50)
        }
        If (cPoint(1858, 877).ClickButtonActive()) { ; crunchy coins
            Sleep(50)
        }
        If (cPoint(1861, 989).ClickButtonActive()) { ; crunchy blc
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1687, 537).ClickButtonActive()) { ; crunchy pets
            Sleep(50)
        }
        If (!Rects.MLCShop.CrunchySeeds.PixelSearch()) {
            If (cPoint(1685, 649).ClickButtonActive()) { ; crunchy seeds lite (toggle)
                Sleep(50)
            }
        }
        If (cPoint(1694, 763).ClickButtonActive()) { ; crunchy unique
            Sleep(50)
        }
        ; missing
        If (!Rects.MLCShop.PoweredALB.PixelSearch()) {
            If (cPoint(1690, 987).ClickButtonActive()) { ; leaf powered alb (toggle)
                Sleep(50)
            }
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1856, 535).ClickButtonActive()) { ; trade education
            Sleep(50)
        }
        If (cPoint(1856, 643).ClickButtonActive()) { ; faster artifacts
            Sleep(50)
        }
        If (cPoint(1857, 758).ClickButtonActive()) { ; offline artifacts
            Sleep(50)
        }
        If (cPoint(1860, 869).ClickButtonActive()) { ; critical converters
            Sleep(50)
        }
        If (cPoint(1857, 980).ClickButtonActive()) { ; craft forge
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1860, 532).ClickButtonActive()) { ; craft hammer
            Sleep(50)
        }
        If (cPoint(1858, 639).ClickButtonActive()) { ; faster autocraft
            Sleep(50)
        }
        If (cPoint(1692, 746).ClickButtonActive()) { ; unlock silver converters
            Sleep(50)
        }
        If (cPoint(1699, 856).ClickButtonActive()) { ; unlock gold converters
            Sleep(50)
        }
        If (cPoint(1691, 974).ClickButtonActive()) { ; unlock amber leaf
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1692, 516).ClickButtonActive()) { ; unlock amythyst leaf
            Sleep(50)
        }
        If (cPoint(1693, 633).ClickButtonActive()) { ; unlock emerald leaf
            Sleep(50)
        }
        If (cPoint(1689, 748).ClickButtonActive()) { ; unlock kyanite leaf
            Sleep(50)
        }
        If (cPoint(1692, 864).ClickButtonActive()) { ; unlock rhondonite leaf
            Sleep(50)
        }
        If (cPoint(1688, 979).ClickButtonActive()) { ; unlock ruby leaf
            Sleep(50)
        }
        Travel.ScrollAmountDown(7)
        Sleep(50)
        If (cPoint(1691, 936).ClickButtonActive()) { ; unlock tektite leaf
            Sleep(50)
        }
    }
}
