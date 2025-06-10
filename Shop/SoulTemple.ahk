#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sSoulTemple extends Zone {

    /**
     * Open SoulTemple upgrade screen
     */
    GoTo(*) {
        UlcWindow()
        Travel.SoulTemple.GoTo()
        WaitForZoneChange("Soul Temple", 1300, 50) ; 65s

        If (!Travel.SoulTemple.IsZone()) {
            Out.I("Failure: Soul Temple floor control did not travel to Soul Temple zone")
            Return false
        }
        Travel.ClosePanelIfActive()
        If (Window.IsPanel()) {
            Travel.ClosePanelIfActive()
        }
        cLBRButton(1279, 641).Click() ; center screen
        Window.AwaitPanel()
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
            If (cLBRButton(537, 662).ClickButtonActive()) { ; unlock max button
                Sleep(50)
            }
            If (cLBRButton(537, 662).ClickButtonActive()) {
                Sleep(50)
            }
            If (!cLBRButton(537, 662).IsBackground()) {
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
            cLBRButton(985, 462).ClickButtonActive() ; Decrease level
            Sleep(50)
            cLBRButton(985, 462).ClickButtonActive() ; Decrease level
            Sleep(50)
            cLBRButton(1536, 462).ClickButtonActive() ; Increase level
            Sleep(50)
            cLBRButton(1536, 462).ClickButtonActive() ; Increase level
            Sleep(50)
            ResetModifierKeys()
            Out.I("SoulTemple maxed floor success")
            Return true
        }
        Return false
    }
}
