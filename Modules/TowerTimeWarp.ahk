#Requires AutoHotkey v2.0

global TowerFarmActive
TowerFarmActive := false

fTimeWarpAndRaiseTower() {
    global X, Y, W, H, TowerFarmActive
    GemTest := true
    if (GemTest) {
        Travel.OpenGemShop()
        sleep(150)

        if (!cPoint(1810, 1177).IsButtonActive()) {
            Log("TowerBoost: Found no time travel button, exiting.")
            return
        }
        ; Navigate to Time Travel tab
        cPoint(1810, 1177).Click(101)
        Sleep(101)

        if (!cPoint(1790, 643).IsButtonActive()) {
            ToolTip("No 72hr boosts to use, exiting.`n"
                "Use F5 to finish",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Found no 72 hour boosts, exiting.")
            return
        }
    }
    Travel.OpenAreas()
    ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)
    Log("TowerBoost: Equiping tower loadout")
    GameKeys.EquipTowerGearLoadout() ; Equip Tower set
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
        found := cRect(1563, 430, 1604, 964).PixelSearch("0xC5D8E0")

        ; Leaf pixel search
        If (!found) {
            ; Not found
            Log("TowerBoost: Could not find tower zone.")
            ToolTip("Could not find tower area`nUse F5 to finish"
                "`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }

        ; Found at 1595x778 (1440)
        ; 1664 800 < tower floor zone Relative: 69 22
        ; 2066 865 < Max floor button Relative: 471 87
        ; 1664 646 < Leaksink Relative: 69 -132

        ; Open leafsing harbor to allow max level reset
        if (IsBackground(found[1] + WinRelPosLargeW(69),
            found[2] - WinRelPosLargeH(132))) {
            ; Background colour found
            Log("Error 30: Tower alt area detection failed. Alignment2.")
            ToolTip("Alignment issue 2, could not continue`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }
        fCustomClick(found[1] + WinRelPosLargeW(69),
            found[2] - WinRelPosLargeH(132), 101)
        Sleep(101)

        ; Max Tower level
        if (!cPoint(found[1] + WinRelPosLargeW(471),
            found[2] + WinRelPosLargeH(67), false).IsButtonActive()) {
            Log("Error 31: Tower max detection failed. Alignment3.")
            ToolTip("Alignment issue 3, could not continue`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }
        fCustomClick(found[1] + WinRelPosLargeW(471),
            found[2] + WinRelPosLargeH(67), 101)
        Sleep(101)

        ; Select Tower area
        if (!cPoint(found[1] + WinRelPosLargeW(69),
            found[2] + WinRelPosLargeH(5), false).IsButtonActive()) {

            ToolTip(" ", found[1] + WinRelPosLargeW(69),
                found[2] + WinRelPosLargeH(5), 4)

            Log("Error 32: Tower area detection failed. Alignment4.")
            ToolTip("Alignment issue 4, could not continue`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }
        fCustomClick(found[1] + WinRelPosLargeW(69),
            found[2] + WinRelPosLargeH(5), 101)
        Sleep(101)

        Travel.OpenGemShop()
        sleep(150)

        if (!cPoint(1810, 1177).IsButtonActive()) {
            Log("Error 33: Gem purchase detection failed. Alignment5.")
            ToolTip("Alignment issue 5, could not continue`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }
        ; Navigate to Time Travel tab
        cPoint(1810, 1177).Click(101)
        Sleep(101)

        if (cPoint(1790, 643).IsButtonActive()) {
            ; Click 72h warp
            cPoint(1790, 643).Click(101)
        } else {
            Log("TowerBoost: No boosts remaining. Exiting.")
            ToolTip("Run out of 72hr boosts to use`n"
                "Use F5 to finish`nApplied default loadout",
                W / 2 - WinRelPosLargeW(100),
                H / 2)
            Log("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            break
        }
        Travel.OpenAreas() ; Doing this last as we open this to scroll to start
        sleep(150)
    }
    TowerFarmActive := false
}