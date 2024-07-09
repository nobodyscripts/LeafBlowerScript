#Requires AutoHotkey v2.0

#Include cHotkeysInitGame.ahk
#Include cHotkeysInitScript.ahk

#Include cTravel.ahk

#Include ..\Navigate\AreasRects.ahk
#Include ..\Navigate\AreasCoords.ahk
#Include ..\Navigate\MiscCoords.ahk

#Include ..\Navigate\Bank\Header.ahk
#Include ..\Navigate\BorbVentures\Header.ahk
#Include ..\Navigate\Brew\Header.ahk
#Include ..\Navigate\Cards\Header.ahk
#Include ..\Navigate\Claw\Header.ahk
#Include ..\Navigate\Crafting\Header.ahk
#Include ..\Navigate\GemFarm\Header.ahk
#Include ..\Navigate\Hyacinth\Header.ahk
#Include ..\Navigate\Leafton\Header.ahk
#Include ..\Navigate\Mines\Header.ahk

#Include ..\Navigate\Zones\Header.ahk


Global DisableZoneChecks := false
Global NavigateTime := 150
Global LBRWindowTitle


IsAreaResetToGarden() {
    If (!Rects.Areas.GardenReset.PixelSearch("0x4A9754")) {
        Return false
    }
    Return true
}

GoToHomeGarden() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x4A9754") && i <= 4) {
            Log("Traveling to Home Garden")
            Travel.OpenAreas()
            ; Click Home Garden button
            Points.Areas.LeafG.HomeGarden.Click(NavigateTime)
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x4A9754")) {
        DebugLog("Travel success to Home Garden.")
        Return true
    } Else {
        Log("Traveling to Home Garden. Attempt to blind travel with"
            " slowed times.")
        Travel.OpenAreas(true, 200)
        Points.Areas.LeafG.HomeGarden.Click(NavigateTime + 200)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x4A9754")) {
            DebugLog("Blind travel success to Home Garden.")
            Return true
        } Else {
            Log("Traveling to Home Garden failed, colour found was " GetAreaSampleColour()
            )
            Return false
        }
    }
}

GoToGF() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x121328") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Flame Brazier (Green Flame)")
            GoToAreaFireFieldsTab()

            ; Open Flame Brazier (GF zone)
            ; TODO Move point to Points
            fSlowClickRelL(1680, 947, NavigateTime)

            ; Need a longer delay to load the slower map
            If (NavigateTime > 201) {
                Sleep(NavigateTime)
            } Else {
                Sleep(201)
            }
            i++
        }
    }
    If (IsAreaSampleColour("0x121328")) {
        DebugLog("Travel success to Flame Brazier (Green Flame).")
        Return true
    } Else {
        Log("Traveling to Flame Brazier (Green Flame). Attempt to blind travel"
            " with slowed times.")
        ; TODO Replace below with travel and move to Points
        GoToAreaFireFieldsTab(200)
        fSlowClickRelL(1680, 947, NavigateTime + 200) ; Open Flame Brazier (GF zone)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x121328")) {
            DebugLog("Blind travel success to Flame Brazier (Green Flame).")
            Return true
        } Else {
            Log("Traveling to Flame Brazier (Green Flame) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToSS() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x17190F") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Flame Universe (Soulseeker)")
            ; TODO Replace below with travel and move to Points
            GoToAreaFireFieldsTab()
            Travel.ScrollAmountDown(2, NavigateTime)
            fSlowClickRelL(1680, 988, NavigateTime) ; Open Flame Universe (SS zone)
            If (NavigateTime > 201) { ; Need a longer delay to load the slower map
                Sleep(NavigateTime)
            } Else {
                Sleep(201)
            }
            i++
        }
    }
    If (IsAreaSampleColour("0x17190F")) {
        DebugLog("Travel success to Flame Universe (Soulseeker).")
        Return true
    } Else {
        Log("Traveling to Flame Universe (Soulseeker). Attempt to blind travel"
            " with slowed times.")
        ; TODO Replace below with travel and move to Points
        GoToAreaFireFieldsTab(200)
        Travel.ScrollAmountDown(2, NavigateTime + 200)
        fSlowClickRelL(1680, 988, NavigateTime + 200) ; Open Flame Universe (SS zone)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x17190F")) {
            DebugLog("Blind travel success to Flame Universe (Soulseeker).")
            Return true
        } Else {
            Log("Traveling to Flame Universe (Soulseeker) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToShadowCavern() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x260000") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Shadow Cavern")
            ; TODO Replace below with travel and move to Points
            GoToAreaFireFieldsTab()
            ; Go to shadow cavern
            fSlowClickRelL(1670, 320, NavigateTime)
            ; Need a longer delay to load the slower map
            If (NavigateTime > 201) {
                Sleep(NavigateTime)
            } Else {
                Sleep(201)
            }
            i++
        }
    }
    If (IsAreaSampleColour("0x260000")) {
        DebugLog("Travel success to shadow cavern.")
        Return true
    } Else {
        Log("Traveling to Shadow Cavern. Attempt to blind travel with slowed"
            " times.")
        ; TODO Replace below with travel and move to Points
        GoToAreaFireFieldsTab(200)
        fSlowClickRelL(1670, 320, NavigateTime + 200) ; Go to shadow cavern
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x260000")) {
            DebugLog("Blind travel success to shadow cavern.")
            Return true
        } Else {
            Log("Traveling to Shadow Cavern failed, colour found was " GetAreaSampleColour()
            )
            Return false
        }
    }
}

GotoResetSS() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    GoToShadowCavern()
    Travel.ClosePanelIfActive()
    button := Points.Areas.FireF.BorbianaJones
    Log(button.GetColour())
    ; Go to Borbiana Jones screen
    If (button.IsColour("0x60F811")) {
        button.Click(NavigateTime)
        Sleep(NavigateTime)
    }
}

ResetSS() {
    GotoResetSS()
    ; Reset SpectralSeeker
    button := Points.Areas.FireF.ResetSS
    If (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

ResetGF() {
    GotoResetSS()
    ; Reset Green Flame
    button := Points.Areas.FireF.ResetGF
    If (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

GoToNatureBoss() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x090B10") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to The Doomed Tree")
            While (!IsOnEventAreaPanel()) {
                Travel.OpenAreasEvents(100)
            }
            Sleep(NavigateTime)
            If (!NatureBossButtonClick()) {
                Log("Nature event inactive, no button found.")
                Return false
            }
            If (NavigateTime < 201) {
                Sleep(201)
            } Else {
                Sleep(NavigateTime)
            }
            i++
        }
    }
    If (IsAreaSampleColour("0x090B10")) {
        DebugLog("Travel success to The Doomed Tree.")
        Return true
    } Else {
        Log("Traveling to The Doomed Tree. Attempt to blind travel with slowed"
            " times.")
        While (!IsOnEventAreaPanel()) {
            Travel.OpenAreasEvents(200)
        }
        Sleep(NavigateTime + 200)
        If (!NatureBossButtonClick()) {
            Log("Nature event inactive, no button found.")
            Return false
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x090B10")) {
            DebugLog("Blind travel success to The Doomed Tree.")
            Return true
        } Else {
            Log("Traveling to The Doomed Tree failed, colour found was " GetAreaSampleColour()
            )
            Return false
        }
    }
}

NatureBossButtonClick() {
    button := Points.Areas.Events.NatureBoss
    button2 := Points.Areas.Events.NatureBoss2
    If (button.IsButton()) {
        button.Click(100)
        Return true
    } Else If (button2.IsButton()) {
        button2.Click(100)
        Return true
    } Else {
        Return false
    }
}

IsOnEventAreaPanel() {
    button := Points.Areas.Events.NatureBoss
    button2 := Points.Areas.Events.NatureBoss2
    If (button.IsButton()) {
        Return true
    } Else If (button2.IsButton()) {
        Return true
    } Else {
        Return false
    }
}

GoToCheeseBoss() {
    button := Points.Areas.Events.CursedHalloween
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x150412") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Cursed Halloween")
            Travel.OpenAreasEvents()
            Sleep(NavigateTime)
            If (!button.IsBackground()) {
                ; Open Cheese boss area
                button.Click(NavigateTime)
            } Else {
                Log("Halloween event inactive, no button found.")
                Return false
            }
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x150412")) {
        DebugLog("Travel success to Cursed Halloween.")
        Return true
    } Else {
        Log(
            "Traveling to Cursed Halloween. Attempt to blind travel with slowed"
            " times.")
        Travel.OpenAreasEvents(200)
        Sleep(NavigateTime + 200)
        If (!button.IsBackground()) {
            ; Open Cheese boss area
            button.Click(NavigateTime + 200)
        } Else {
            Log("Halloween event inactive, no button found.")
            Return false
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x150412")) {
            DebugLog("Blind travel success to Cursed Halloween.")
            Return true
        } Else {
            Log("Traveling to Cursed Halloween, colour found was " GetAreaSampleColour()
            )
            Return false
        }
    }
}

GoToFarmField() {
    button := Points.Areas.Events.FarmField
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    ; Of course i get this working then find a better way
    i := 0
    ; This ones messy because the colour matches home garden
    If (!DisableZoneChecks) {
        Log("Traveling to Farm Field")
        ; If farmfields we'll see the green + timer
        If (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
            Sleep(NavigateTime)
            Return true
        }
        ; If we're at home garden attempt to travel, boss timer should appear,
        ; breaking
        While ((IsAreaSampleColour("0x4A9754") && !IsBossTimerActive()) && i <=
            4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Travel.OpenAreasEvents()
            If (button.IsBackground()) {
                Return false
            }
            ; Open farm field
            button.Click(NavigateTime)
            Sleep(NavigateTime)
            i++
        }
        ; If we were not at home garden or now farm field, try travel
        While (!IsAreaSampleColour("0x4A9754") && i <= 4) {
            Travel.OpenAreasEvents()
            If (button.IsBackground()) {
                Return false
            }
            ; Open farm field
            button.Click(NavigateTime)
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
        DebugLog("Travel success to Farm Field.")
        Return true
    } Else {
        Log("Traveling to Farm Field. Attempt to blind travel with slowed"
            " times.")
        Travel.OpenAreasEvents(200)
        If (button.IsBackground()) {
            Return false
        }
        ; Open farm field
        button.Click(NavigateTime + 200)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x4A9754")) {
            DebugLog("Blind travel success to Farm Field.")
            Return true
        } Else {
            Log("Traveling to Farm Field failed, colour found was " GetAreaSampleColour()
            )
            Return false
        }
    }
}

GoToAstralOasis() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.QuarkA.AstralOasis
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x000108") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Astral Oasis (Quark Boss 1)")
            Travel.OpenAreasQuark()
            If (!button.IsBackground()) {
                button.ClickOffset(5, 0, NavigateTime)
            } Else {
                button.ClickOffset(5, 37, NavigateTime)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x000108")) {
        DebugLog("Blind travel success to Astral Oasis (Quark Boss 1).")
        Return true
    } Else {
        Log("Traveling to Astral Oasis (Quark Boss 1). Attempt to blind travel"
            " with slowed times.")
        Travel.OpenAreasQuark(200)
        If (!button.IsBackground()) {
            button.ClickOffset(5, 0, NavigateTime + 200)
        } Else {
            button.ClickOffset(5, 37, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x000108")) {
            DebugLog("Blind travel success to Astral Oasis (Quark Boss 1).")
            Return true
        } Else {
            Log("Traveling to Astral Oasis (Quark Boss 1) failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToDimentionalTapestry() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.Events.DimentionalTapestry
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x37356B") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Dimentional Tapestry (Quark Boss 2)")
            Travel.OpenAreasQuark()
            If (!button.IsBackground()) {
                button.ClickOffset(5, 0, NavigateTime)
            } Else {
                button.ClickOffset(5, 40, NavigateTime)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x37356B")) {
        DebugLog("Travel success to Dimentional Tapestry (Quark Boss 2).")
        Return true
    } Else {
        Log("Traveling to Dimentional Tapestry (Quark Boss 2). Attempt to"
            " blind travel with slowed times.")
        Travel.OpenAreasQuark(200)
        If (!button.IsBackground()) {
            button.ClickOffset(5, 0, NavigateTime + 200)
        } Else {
            button.ClickOffset(5, 40, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x37356B")) {
            DebugLog(
                "Blind travel success to Dimentional Tapestry (Quark Boss 2).")
            Return true
        } Else {
            Log("Traveling to Dimentional Tapestry (Quark Boss 2) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToPlankScope() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.Events.PlankScope
    button2 := Points.Areas.Events.PlankScope2
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x0B1E32") && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Traveling to Plank Scope (Quark Boss 3)")
            Travel.OpenAreasQuark()
            If (button.IsButtonActive()) {
                button.ClickOffset(5, , NavigateTime)
            } Else If (button2.IsButtonActive()) {
                button2.ClickOffset(5, , NavigateTime)
            }
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x0B1E32")) {
        DebugLog("Travel success to Plank Scope (Quark Boss 3).")
        Return true
    } Else {
        Log("Traveling to Plank Scope (Quark Boss 3). Attempt to blind travel"
            " with slowed times.")
        Travel.OpenAreasQuark(200)
        If (button.IsButtonActive()) {
            button.ClickOffset(5, , NavigateTime + 200)
        } Else If (button2.IsButtonActive()) {
            button2.ClickOffset(5, , NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x0B1E32")) {
            DebugLog("Blind travel success to Plank Scope (Quark Boss 3).")
            Return true
        } Else {
            Log("Traveling to Plank Scope (Quark Boss 3) failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

SingleAnteLeaftonTravel(extradelay := 0) {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Log("Traveling to Ante Leafton")
    Travel.ClosePanelIfActive()
    Travel.OpenAreasQuark(extradelay)
    Travel.ScrollAmountDown(2)
    button := Points.Areas.QuarkA.AnteLeafton
    button2 := Points.Areas.QuarkA.AnteLeafton2
    If (button.IsButtonActive()) {
        button.ClickOffset(5, , NavigateTime + extradelay)
    } Else If (button2.IsButtonActive()) {
        button2.ClickOffset(5, , NavigateTime + extradelay)
    }
    Sleep(NavigateTime)
}

GoToAnteLeafton() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaBlack() || !IsBossTimerActive() && i <= 4) {
            If (!SingleAnteLeaftonTravel()) {
                Return false
            }
            i++
        }
        If (IsAreaBlack() && IsBossTimerActive()) {
            DebugLog("Travel success to Ante Leafton.")
            Return true
        }
    }
    If (!IsAreaBlack() || !IsBossTimerActive()) {
        Log("Traveling to Ante Leafton. Attempt to blind travel"
            " with slowed times.")
        SingleAnteLeaftonTravel(200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x000000")) {
            DebugLog("Blind travel success to Ante Leafton.")
            Return true
        } Else {
            Log("Traveling to Ante Leafton failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

GotoCardsFirstTab() {
    If (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Card.PacksTab
    If (!DisableZoneChecks) {
        While (!IsOnCardsFirstPanel() && IsWindowActive() && i <= 4) {
            If (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                Return false
            }
            Log("Opening cards, packs (first) tab.")
            Travel.OpenCards()
            Sleep(NavigateTime)
            button.Click(NavigateTime)
            ; Open first tab incase wrong tab
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsOnCardsFirstPanel()) {
        DebugLog("Travel success to Cards First Tab.")
        Return true
    } Else {
        ; Attempt to blind travel with slowed times
        Log("Opening cards, packs (first) tab. Attempt to blind travel with"
            " slowed times.")
        Travel.OpenCards(, 200)
        Sleep(NavigateTime + 200)
        button.Click(NavigateTime + 200)
        ; Open first tab incase wrong tab
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsOnCardsFirstPanel()) {
            DebugLog("Blind travel success to Cards First Tab.")
            Return true
        } Else {
            Log("GotoCardsFirstTab: Not at cards first tab")
            Return false
        }
    }
}

IsOnCardsFirstPanel() {
    If (Points.Card.OddsButton.IsButtonActive()) {
        Return true
    }
    Return false
}

GoToAreaFireFieldsTab(extraDelay := 0) {
    i := 0
    Travel.OpenAreas(false, extraDelay)

    ; Click Favourites
    Points.Areas.Favs.Tab.Click(NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Open Fire Fields tab
    Points.Areas.FireF.Tab.Click(NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)

    ; Repeat
    Points.Areas.FireF.Tab.Click(NavigateTime + extraDelay)
    Sleep(NavigateTime + extraDelay)
}

GoToLeafTower() {
    Travel.OpenAreas()
    Travel.ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)

    ; Leaf pixel search
    ; Look for colour of a segment of the rightmost tower leaf c5d8e0
    spot := Rects.Areas.LeafTower.PixelSearch("0xC5D8E0")
    If (!spot) {
        ; Not found
        Log("TowerBoost: Could not find tower leaf to open area.")
        Return false
    }
    LeafsingButton := cPoint(spot[1] + WinRelPosLargeW(69), spot[2] -
        WinRelPosLargeH(160), false)
    ; Open leafsing harbor to allow max level reset
    If (LeafsingButton.IsBackground()) {
        ; Background colour found
        Log("Error 30: Tower alt area detection failed. Alignment2.")
        Return false
    }
    LeafsingButton.Click(101)
    Sleep(201)

    TowerMax := cPoint(spot[1] + WinRelPosLargeW(460), spot[2] +
        WinRelPosLargeH(60), false)
    ; Max Tower level
    If (!TowerMax.IsButtonActive()) {
        Log("Error 31: Tower max detection failed. Alignment3.")
        Return false
    }
    TowerMax.Click(101)
    Sleep(101)

    TowerArea := cPoint(spot[1] + WinRelPosLargeW(69), spot[2] -
        WinRelPosLargeH(5), false)
    ; Select Tower area
    If (!TowerArea.IsButtonActive()) {
        Log("Error 32: Tower area detection failed. Could not find "
            " Leaf Tower Travel Button.")
        Return
    }
    TowerArea.Click(101)
    Sleep(201)
}

IsAreaSampleColour(targetColour := "0xFFFFFF") {
    If (Points.Misc.ZoneSample.GetColour() = targetColour) {
        Return true
    }
    Return false
}

GetAreaSampleColour() {
    Return Points.Misc.ZoneSample.GetColour()
}

IsAreaFlameBrazier() {
    If (GetAreaSampleColour() = "0x121328") {
        Return true
    }
    Return false
}

IsAreaTheFireUniverse() {
    If (GetAreaSampleColour() = "0x17190F") {
        Return true
    }
    Return false
}

IsAreaGFOrSS() {
    Local col := GetAreaSampleColour()
    If (col = "0x121328" || col = "0x17190F") {
        Return true
    }
    Return false
}

IsAreaBlack() {
    Local col := GetAreaSampleColour()
    If (col = "0x000000") {
        Return true
    }
    Return false
}