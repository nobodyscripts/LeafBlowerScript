#Requires AutoHotkey v2.0

global TowerFarmActive
TowerFarmActive := false

fTimeWarpAndRaiseTower() {
    global X, Y, W, H, TowerFarmActive

    OpenGemShop()
    sleep(150)

    if (!IsButtonActive(WinRelPosW(904), WinRelPosH(571))) {
        Log("TowerBoost: Found no time travel button, exiting.")
        return
    }
    fSlowClick(904, 571, 101) ; Navigate to Time Travel tab
    Sleep(101)

    if (!IsButtonActive(WinRelPosW(894), WinRelPosH(312))) {
        ToolTip("No 72hr boosts to use, exiting.`n"
        "Use F5 to finish",
        W / 2 - WinRelPosW(50),
        H / 2)
        Log("TowerBoost: Found no 72 hour boosts, exiting.")
        return
    }

    OpenAreasPanel()
    ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)
    Log("TowerBoost: Equiping tower loadout")
    EquipTowerGearLoadout() ; Equip Tower set
    TowerFarmActive := true
    Log("TowerBoost: Starting main loop.")
    Loop {
        ; Check if: lost focus, close or crash and break if so
        if (!IsWindowActive()) {
            break
        }
        WinActivate(LBRWindowTitle)
        ; Use the window found by WinExist.
        WinGetClientPos(&X, &Y, &W, &H, LBRWindowTitle)
        ; Update window size

        ; Look for colour of a segment of the rightmost tower leaf c5d8e0
        try {
            found := PixelSearch(&OutX, &OutY,
                WinRelPosLargeW(1563), WinRelPosLargeH(430),
                WinRelPosLargeW(1604), WinRelPosLargeH(964), "0xC5D8E0", 0)
            ; Leaf pixel search
            If (!found || OutX = 0) {
                ; Not found

                Log("TowerBoost: Could not find tower zone.")
                ToolTip("Could not find tower area`nUse F5 to finish"
                    "`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                Log("TowerBoost: Equiping default loadout")
                EquipDefaultGearLoadout()
                break
            }
        } catch as exc {
            Log("Error 29: Tower leaf detection failed. Alignment1 - "
             exc.Message)
            MsgBox("Alignment issue 1, could not conduct the search due to the"
                " following error:`n" exc.Message)
        }
        ; Found at 1595x778 (1440)
        ; 1664 800 < tower floor zone Relative: 69 22
        ; 2066 865 < Max floor button Relative: 471 87
        ; 1664 646 < Leaksink Relative: 69 -132

        ; Open leafsing harbor to allow max level reset
        if (IsBackground(OutX + WinRelPosLargeW(69),
            OutY - WinRelPosLargeH(132))) {
                ; Background colour found
                Log("Error 30: Tower alt area detection failed. Alignment2.")
                ToolTip("Alignment issue 2, could not continue`n"
                    "Use F5 to finish`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                Log("TowerBoost: Equiping default loadout")
                EquipDefaultGearLoadout()
                break
        }
        fCustomClick(OutX + WinRelPosLargeW(69),
            OutY - WinRelPosLargeH(132), 101)
        Sleep(101)

        ; Max Tower level
        if (!IsButtonActive(OutX + WinRelPosLargeW(471),
            OutY + WinRelPosLargeH(87))) {
                Log("Error 31: Tower max detection failed. Alignment3.")
                ToolTip("Alignment issue 3, could not continue`n"
                    "Use F5 to finish`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                Log("TowerBoost: Equiping default loadout")
                EquipDefaultGearLoadout()
                break
        }
        fCustomClick(OutX + WinRelPosLargeW(471),
            OutY + WinRelPosLargeH(87), 101)
        Sleep(101)

        ; Select Tower area
        if (!IsButtonActive(OutX + WinRelPosLargeW(69),
            OutY + WinRelPosLargeH(22))) {
                Log("Error 32: Tower area detection failed. Alignment4.")
                ToolTip("Alignment issue 4, could not continue`n"
                    "Use F5 to finish`nApplied default loadout",
                    W / 2 - WinRelPosW(50),
                    H / 2)
                Log("TowerBoost: Equiping default loadout")
                EquipDefaultGearLoadout()
                break
        }
        fCustomClick(OutX + WinRelPosLargeW(69),
            OutY + WinRelPosLargeH(22), 101)
        Sleep(101)

        OpenGemShop()
        sleep(150)

        if (!IsButtonActive(WinRelPosW(904), WinRelPosH(571))) {
            Log("Error 33: Gem purchase detection failed. Alignment5.")
            ToolTip("Alignment issue 5, could not continue`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            EquipDefaultGearLoadout()
            break
        }
        fSlowClick(904, 571, 101) ; Navigate to Time Travel tab
        Sleep(101)

        if (IsButtonActive(WinRelPosW(894), WinRelPosH(312))) {
            fSlowClick(894, 312, 101) ; Click 72h warp
        } else {
            Log("TowerBoost: No boosts remaining. Exiting.")
            ToolTip("Run out of 72hr boosts to use`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosW(50),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            EquipDefaultGearLoadout()
            break
        }
        OpenAreas() ; Doing this last as we open this to scroll to start
        sleep(150)
    }
    TowerFarmActive := false
}