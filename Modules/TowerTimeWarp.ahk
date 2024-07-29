#Requires AutoHotkey v2.0

Global TowerFarmActive
TowerFarmActive := false

fTimeWarpAndRaiseTower() {
    Global TowerFarmActive
    GemTest := true
    If (GemTest) {
        Travel.OpenGemShop()
        Sleep(150)

        ; TODO Move point to Points
        If (!cPoint(1810, 1177).IsButtonActive()) {
            Out.I("TowerBoost: Found no time travel button, exiting.")
            Return
        }
        ; Navigate to Time Travel tab
        ; TODO Move point to Points
        cPoint(1810, 1177).Click(101)
        Sleep(101)

        ; TODO Move point to Points
        If (!cPoint(1790, 643).IsButtonActive()) {
            ToolTip("No 72hr boosts to use, exiting.`n"
                "Use F5 to finish", Window.W / 2 - Window.RelW(100), Window.H /
                2)
            Out.I("TowerBoost: Found no 72 hour boosts, exiting.")
            Return
        }
    }
    Travel.OpenAreas()
    Travel.ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)
    Out.I("TowerBoost: Equiping tower loadout")
    GameKeys.EquipTowerGearLoadout() ; Equip Tower set
    TowerFarmActive := true
    Out.I("TowerBoost: Starting main loop.")
    Loop {
        ; Check if: lost focus, close or crash and break if so
        If (!Window.IsActive()) {
            Break
        }
        ; Look for colour of a segment of the rightmost tower leaf c5d8e0
        ; TODO Move rect to Rects
        found := cRect(1563, 430, 1604, 964).PixelSearch("0xC5D8E0")

        ; Leaf pixel search
        If (!found) {
            ; Not found
            Out.I("TowerBoost: Could not find tower zone.")
            ToolTip("Could not find tower area`nUse F5 to finish"
                "`nApplied default loadout", Window.W / 2 - Window.RelW(100),
                Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }

        ; Found at 1595x778 (1440)
        ; 1664 800 < tower floor zone Relative: 69 22
        ; 2066 865 < Max floor button Relative: 471 87
        ; 1664 646 < Leaksink Relative: 69 -132

        ; Open leafsing harbor to allow max level reset
        If (cPoint(found[1] + Window.RelW(69), found[2] - Window.RelH(132),
            false).IsBackground()) {
            ; Background colour found
            Out.I("Error 30: Tower alt area detection failed. Alignment2.")
            ToolTip("Alignment issue 2, could not continue`n"
                "Use F5 to finish`nApplied default loadout", Window.W / 2 -
                Window.RelW(100), Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }
        ; TODO Move to cPoint
        fCustomClick(found[1] + Window.RelW(69), found[2] - Window.RelH(132),
            101)
        Sleep(101)

        ; Max Tower level
        If (!cPoint(found[1] + Window.RelW(471), found[2] + Window.RelH(67),
            false).IsButtonActive()) {
            Out.I("Error 31: Tower max detection failed. Alignment3.")
            ToolTip("Alignment issue 3, could not continue`n"
                "Use F5 to finish`nApplied default loadout", Window.W / 2 -
                Window.RelW(100), Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }
        ; TODO Move to cPoint
        fCustomClick(found[1] + Window.RelW(471), found[2] + Window.RelH(67),
            101)
        Sleep(101)

        ; Select Tower area
        If (!cPoint(found[1] + Window.RelW(69), found[2] + Window.RelH(5),
            false).IsButtonActive()) {

            ToolTip(" ", found[1] + Window.RelW(69), found[2] + Window.RelH(5),
                4)

            Out.I("Error 32: Tower area detection failed. Alignment4.")
            ToolTip("Alignment issue 4, could not continue`n"
                "Use F5 to finish`nApplied default loadout", Window.W / 2 -
                Window.RelW(100), Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }
        ; TODO Move to cPoint
        fCustomClick(found[1] + Window.RelW(69), found[2] + Window.RelH(5), 101
        )
        Sleep(101)

        Travel.OpenGemShop()
        Sleep(150)
        ; TODO move points to Points
        If (!cPoint(1810, 1177).IsButtonActive()) {
            Out.I("Error 33: Gem purchase detection failed. Alignment5.")
            ToolTip("Alignment issue 5, could not continue`n"
                "Use F5 to finish`nApplied default loadout", Window.W / 2 -
                Window.RelW(100), Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }
        ; Navigate to Time Travel tab
        ; TODO Move point to Points
        cPoint(1810, 1177).Click(101)
        Sleep(101)

        ; TODO Move point to Points
        If (cPoint(1790, 643).IsButtonActive()) {
            ; Click 72h warp
            ; TODO Move point to Points
            cPoint(1790, 643).Click(101)
        } Else {
            Out.I("TowerBoost: No boosts remaining. Exiting.")
            ToolTip("Run out of 72hr boosts to use`n"
                "Use F5 to finish`nApplied default loadout", Window.W / 2 -
                Window.RelW(100), Window.H / 2)
            Out.I("TowerBoost: Equiping default loadout")
            GameKeys.EquipDefaultGearLoadout()
            Break
        }
        Travel.OpenAreas() ; Doing this last as we open this to scroll to start
        Sleep(150)
    }
    TowerFarmActive := false
}