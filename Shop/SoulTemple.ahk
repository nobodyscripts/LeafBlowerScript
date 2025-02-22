#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSoulTemple extends Zone {

    /**
     * Open SoulTemple upgrade screen
     */
    GoTo(*) {
        UlcWindow()
        Travel.SoulTemple.GoTo()
        Sleep(50)

        If (!Travel.SoulTemple.IsZone()) {
            Out.I("Failure: Soul Temple floor control did not travel to Soul Temple zone")
            return false
        }
        Travel.ClosePanelIfActive()
        If (Window.IsPanel()) {
            Travel.ClosePanelIfActive()
        }
        While (Window.IsPanel()) {
            Sleep(17)
        }
        cPoint(1279, 641).Click() ; center screen
        While (!Window.IsPanel()) {
            Sleep(17)
        }
        If (Window.IsPanel()) {
            Return true
        }
        Out.I("SoulTemple floor control travel failed, window didn't open")
        Return false
    }

    /**
     * Use the unlock max button
     */
    UnlockMax(*) {
        UlcWindow()
        If (Shops.SoulTemple.GoTo()) {
            If (cPoint(537, 662).ClickButtonActive()) { ; unlock max button
                Sleep(50)
            }
            If (cPoint(537, 662).ClickButtonActive()) {
                Sleep(50)
            }
            If (!cPoint(537, 662).IsBackground()) {
                Out.I("SoulTemple unlock max failed, likely due to lack of resources")
                Return false
            }
            Out.I("SoulTemple max success")
            Return true
        }
        Return false
    }

    /**
     * Unlock max floor and increase max floor targeted by 100
     */
    MaxFloor(*) {
        Out.D("MaxSoulTempleFloors")
        UlcWindow()
        If (Shops.SoulTemple.UnlockMax()) {
            AmountToModifier(100)
            Sleep(50)
            cPoint(985, 462).ClickButtonActive() ; Decrease level
            Sleep(50)
            cPoint(1536, 462).ClickButtonActive() ; Increase level
            Sleep(50)
            ResetModifierKeys()
            Out.I("SoulTemple maxed floor success")
            Return true
        }
        Return false
    }
}

    /* UlcWindow()
    If (!Travel.SoulTemple.IsZone()) {
        Out.D("Trying to max crypt floors in wrong zone")
        Return
    }
    Out.D("Max crypt floors")
    Travel.ClosePanelIfActive()
    Sleep(100)
    Travel.ClosePanelIfActive()
    Sleep(100)
    If (!Window.Ispanel()) {
        cPoint(1282, 622).Click() ; Open 
        gToolTip.CenterMS("Maxing crypt floors", 500)
        cPoint(1464, 457).WaitUntilActiveButton(500, 20)
        cPoint(537, 670).ClickButtonActive()
        Sleep(50)
        AmountToModifier(100)
        Sleep(50)
        cPoint(1536, 462).ClickButtonActive() ; Increase level
        Sleep(50)
        ResetModifierKeys()
    } */
