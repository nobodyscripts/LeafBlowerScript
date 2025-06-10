#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

/**
 * @method IsFloor100Done Is sacred nebula unlocked
 * @method Goto Travel to the pyramid floor screen
 * @method UnlockMax Unlock max floor but don't increase it
 * @method MaxFloor Unlock max floor and increase it by 100 after resetting
 */
Class sPyramid extends Zone {

    /**
     * Open pyramid upgrade screen
     */
    GoTo(*) {
        UlcWindow()
        Travel.TheCursedPyramid.GoTo()
        Sleep(50)
        Travel.ClosePanelIfActive()
        If (Window.IsPanel()) {
            Travel.ClosePanelIfActive()
        }

        cLBRButton(1279, 641).Click() ; Colour: #D3BF8F center screen
        While (!Window.IsPanel()) {
            Sleep(17)
        }
        If (Window.IsPanel()) {
            Return true
        }
        Out.I("Pyramid floor control travel failed, window didn't open")
        Return false
    }

    /**
     * Use the unlock max button
     */
    UnlockMax(*) {
        UlcWindow()
        If (Shops.Pyramid.GoTo()) {
            If (cLBRButton(537, 741).ClickButtonActive()) { ; unlock max button
                Sleep(50)
            }
            If (cLBRButton(537, 741).ClickButtonActive()) {
                Sleep(50)
            }
            If (!cLBRButton(537, 741).IsBackground()) {
                Out.I("Pyramid unlock max failed, likely due to lack of resources")
                Return false
            }
            Return true
        }
        Return false
    }

    /**
     * Unlock max floor and increase max floor targeted by 100
     */
    MaxFloor(*) {
        Out.D("MaxPyramidFloors")
        UlcWindow()
        If (Shops.Pyramid.UnlockMax()) {
            AmountToModifier(100)
            Sleep(50)
            cLBRButton(985, 462).ClickButtonActive() ; Decrease level
            Sleep(50)
            cLBRButton(1536, 462).ClickButtonActive() ; Increase level
            Sleep(50)
            ResetModifierKeys()
            Out.I("Pyramid max floor success")
            Return true
        }
        Return false
    }

    /**
     * Is sacred nebula unlocked
     */
    IsFloor100Done() {
        Travel.OpenAreas()
        While (!Window.IsPanel()) {
            Sleep(17)
        }
        If (Points.Areas.SacredNebula.Tab.IsButtonActive()) {
            Return true
        } Else {
            Return false
        }
    }
}
