#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sPyramid extends Zone {

    /**
     * Open pyramid upgrade screen
     */
    GoTo(*) {
        UlcWindow()
        Travel.TheCursedPyramid.GoTo()
        Sleep(50)
        Travel.ClosePanelIfActive()
        Sleep(50)
        cPoint(1282, 664).ClickButtonActive() ; Colour: #D3BF8F center screen
    }

    /**
     * Use the unlock max button
     */
    UnlockMax(*) {
        UlcWindow()
        Shops.Pyramid.GoTo()
        cPoint(528, 741).WaitUntilActiveButton(400, 20)
        cPoint(528, 741).ClickButtonActive() ; Colour: #D3BF8F unlock max button
        Sleep(50)
    }
    
    /**
     * Unlock max floor and increase max floor targeted by 100
     */
    MaxFloor(*) {
        UlcWindow()
        Shops.Pyramid.UnlockMax()

        AmountToModifier(100)
        Sleep(50)
        cPoint(1539, 459).ClickButtonActive() ; Colour: #D3BF8F Increase floor button
        Sleep(50)
        ResetModifierKeys()
    }
}
