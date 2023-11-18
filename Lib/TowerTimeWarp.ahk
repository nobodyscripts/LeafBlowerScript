#Requires AutoHotkey v2.0

fTimeWarpAndRaiseTower() {
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check
    WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 50
    OpenAreas()
    Sleep 50
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    if (!IsButtonActive(WinRelPosW(317), WinRelPosH(574))) {
        ToolTip("Alignment issue 1, could not continue`nUse F5 to finish`nApplied default loadout",
            W / 2 - WinRelPosW(150),
            H / 2)
        EquipDefaultGearLoadout()
        return
    }
    fSlowClick(317, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll
    Sleep 100
    ResetAreaScroll()
    Sleep 100
    ;MouseMove(W/2, H/2) ; Move mouse for scrolling
    Sleep 100
    ; Move the screen up to reset the scroll incase its been changed outside
    ; the script
    ScrollAmountDown(16) ; Scroll down for the zones
    Sleep 100
    EquipTowerGearLoadout() ; Equip Tower set

    Loop {
        ; Check if: lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        ; Look for colour of a segment of the rightmost tower leaf c5d8e0
        try {
            found := PixelSearch(&OutX, &OutY,
                WinRelPosLargeW(1563), WinRelPosLargeH(430),
                WinRelPosLargeW(1604), WinRelPosLargeH(964), "0xC5D8E0", 0)
            ; Leaf pixel search
            If (!found || OutX = 0) {
                ; Not found
                ToolTip("Could not find tower area`nUse F5 to finish`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                EquipDefaultGearLoadout()
                break
            }
        } catch as exc {
            MsgBox ("Could not conduct the search due to the following error:`n"
                exc.Message)
        }
        ;ToolTip("Found tower floor leaf at: " . OutX . "x" . OutY,
        ;    OutX, OutY)

        ; Found at 1595x778 (1440)
        ; 1664 800 < tower floor zone Relative: 69 22
        ; 2066 865 < Max floor button Relative: 471 87
        ; 1664 646 < Leaksink Relative: 69 -132

        ; Open leafsing harbor to allow max level reset
        if (IsBackground(OutX + WinRelPosLargeW(69),
            OutY - WinRelPosLargeH(132))) {
                ; Background colour found
                ToolTip("Alignment issue 2, could not continue`nUse F5 to finish`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                EquipDefaultGearLoadout()
                break
        }
        fCustomClick(OutX + WinRelPosLargeW(69), OutY - WinRelPosLargeH(132))
        Sleep 100

        ; Max Tower level
        if (!IsButtonActive(OutX + WinRelPosLargeW(471), OutY + WinRelPosLargeH(87))) {
            ToolTip("Alignment issue 3, could not continue`nUse F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            EquipDefaultGearLoadout()
            break
        }
        fCustomClick(OutX + WinRelPosLargeW(471), OutY + WinRelPosLargeH(87))
        Sleep 100

        ; Select Tower area
        if (!IsButtonActive(OutX + WinRelPosLargeW(69), OutY + WinRelPosLargeH(22))) {
            ToolTip("Alignment issue 4, could not continue`nUse F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            EquipDefaultGearLoadout()
            break
        }
        fCustomClick(OutX + WinRelPosLargeW(69), OutY + WinRelPosLargeH(22))
        Sleep 100

        OpenGemShop()
        Sleep 150

        if (!IsButtonActive(WinRelPosW(904), WinRelPosH(571))) {
            ToolTip("Alignment issue 5, could not continue`nUse F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            EquipDefaultGearLoadout()
            break
        }
        fSlowClick(904, 571) ; Navigate to Time Travel tab
        Sleep 100

        if (IsButtonActive(WinRelPosW(894), WinRelPosH(312))) {
            fSlowClick(894, 312) ; Click 72h warp
        } else {
            ToolTip("Run out of 72hr boosts to use`nUse F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            EquipDefaultGearLoadout()
            break
        }
        Sleep 100
        OpenAreas() ; Doing this last as we open this to scroll to start
        Sleep 150
    }
}