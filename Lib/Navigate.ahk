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
#Include ..\Shop\Header.ahk

Global DisableZoneChecks := false
Global NavigateTime := 150

GoToGF() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x121328") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Flame Brazier (Green Flame)")
            Travel.OpenAreasFireFields()

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
        Out.D("Travel success to Flame Brazier (Green Flame).")
        Return true
    } Else {
        Out.I(
            "Traveling to Flame Brazier (Green Flame). Attempt to blind travel"
            " with slowed times.")
        ; TODO Replace below with travel and move to Points
        Travel.OpenAreasFireFields(200)
        fSlowClickRelL(1680, 947, NavigateTime + 200) ; Open Flame Brazier (GF zone)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x121328")) {
            Out.D("Blind travel success to Flame Brazier (Green Flame).")
            Return true
        } Else {
            Out.I("Traveling to Flame Brazier (Green Flame) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToSS() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x17190F") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Flame Universe (Soulseeker)")
            ; TODO Replace below with travel and move to Points
            Travel.OpenAreasFireFields()
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
        Out.D("Travel success to Flame Universe (Soulseeker).")
        Return true
    } Else {
        Out.I(
            "Traveling to Flame Universe (Soulseeker). Attempt to blind travel"
            " with slowed times.")
        ; TODO Replace below with travel and move to Points
        Travel.OpenAreasFireFields(200)
        Travel.ScrollAmountDown(2, NavigateTime + 200)
        fSlowClickRelL(1680, 988, NavigateTime + 200) ; Open Flame Universe (SS zone)
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x17190F")) {
            Out.D("Blind travel success to Flame Universe (Soulseeker).")
            Return true
        } Else {
            Out.I("Traveling to Flame Universe (Soulseeker) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToShadowCavern() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x260000") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Shadow Cavern")
            ; TODO Replace below with travel and move to Points
            Travel.OpenAreasFireFields()
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
        Out.D("Travel success to shadow cavern.")
        Return true
    } Else {
        Out.I("Traveling to Shadow Cavern. Attempt to blind travel with slowed"
            " times.")
        ; TODO Replace below with travel and move to Points
        Travel.OpenAreasFireFields(200)
        fSlowClickRelL(1670, 320, NavigateTime + 200) ; Go to shadow cavern
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x260000")) {
            Out.D("Blind travel success to shadow cavern.")
            Return true
        } Else {
            Out.I("Traveling to Shadow Cavern failed, colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GotoResetSS() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    GoToShadowCavern()
    Travel.ClosePanelIfActive()
    button := Points.Areas.FireFields.BorbianaJones
    Out.I(button.GetColour())
    ; Go to Borbiana Jones screen
    If (button.IsColour("0x60F811")) {
        button.Click(NavigateTime)
        Sleep(NavigateTime)
    }
}

ResetSS() {
    GotoResetSS()
    ; Reset SpectralSeeker
    button := Points.Areas.FireFields.ResetSS
    If (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

ResetGF() {
    GotoResetSS()
    ; Reset Green Flame
    button := Points.Areas.FireFields.ResetGF
    If (button.IsButtonActive()) {
        button.Click(NavigateTime)
    }
}

GoToNatureBoss() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x090B10") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to The Doomed Tree")
            While (!Travel.IsOnEventPanel()) {
                Travel.OpenAreasEvents(100)
            }
            Sleep(NavigateTime)
            If (!NatureBossButtonClick()) {
                Out.I("Nature event inactive, no button found.")
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
        Out.D("Travel success to The Doomed Tree.")
        Return true
    } Else {
        Out.I(
            "Traveling to The Doomed Tree. Attempt to blind travel with slowed"
            " times.")
        While (!Travel.IsOnEventPanel()) {
            Travel.OpenAreasEvents(200)
        }
        Sleep(NavigateTime + 200)
        If (!NatureBossButtonClick()) {
            Out.I("Nature event inactive, no button found.")
            Return false
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x090B10")) {
            Out.D("Blind travel success to The Doomed Tree.")
            Return true
        } Else {
            Out.I("Traveling to The Doomed Tree failed, colour found was " GetAreaSampleColour())
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

GoToCheeseBoss() {
    button := Points.Areas.Events.CursedHalloween
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x150412") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Cursed Halloween")
            Travel.OpenAreasEvents()
            Sleep(NavigateTime)
            If (!button.IsBackground()) {
                ; Open Cheese boss area
                button.Click(NavigateTime)
            } Else {
                Out.I("Halloween event inactive, no button found.")
                Return false
            }
            Sleep(NavigateTime)
            i++
        }
    }
    If (IsAreaSampleColour("0x150412")) {
        Out.D("Travel success to Cursed Halloween.")
        Return true
    } Else {
        Out.I(
            "Traveling to Cursed Halloween. Attempt to blind travel with slowed"
            " times.")
        Travel.OpenAreasEvents(200)
        Sleep(NavigateTime + 200)
        If (!button.IsBackground()) {
            ; Open Cheese boss area
            button.Click(NavigateTime + 200)
        } Else {
            Out.I("Halloween event inactive, no button found.")
            Return false
        }
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x150412")) {
            Out.D("Blind travel success to Cursed Halloween.")
            Return true
        } Else {
            Out.I("Traveling to Cursed Halloween, colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToFarmField() {
    button := Points.Areas.Events.FarmField
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    ; Of course i get this working then find a better way
    i := 0
    ; This ones messy because the colour matches home garden
    If (!DisableZoneChecks) {
        Out.I("Traveling to Farm Field")
        ; If farmfields we'll see the green + timer
        If (IsAreaSampleColour("0x4A9754") && IsBossTimerActive()) {
            Sleep(NavigateTime)
            Return true
        }
        ; If we're at home garden attempt to travel, boss timer should appear,
        ; breaking
        While ((IsAreaSampleColour("0x4A9754") && !IsBossTimerActive()) && i <=
        4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
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
        Out.D("Travel success to Farm Field.")
        Return true
    } Else {
        Out.I("Traveling to Farm Field. Attempt to blind travel with slowed"
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
            Out.D("Blind travel success to Farm Field.")
            Return true
        } Else {
            Out.I("Traveling to Farm Field failed, colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToAstralOasis() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.QuarkAmbit.AstralOasis
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x000108") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Astral Oasis (Quark Boss 1)")
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
        Out.D("Blind travel success to Astral Oasis (Quark Boss 1).")
        Return true
    } Else {
        Out.I(
            "Traveling to Astral Oasis (Quark Boss 1). Attempt to blind travel"
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
            Out.D("Blind travel success to Astral Oasis (Quark Boss 1).")
            Return true
        } Else {
            Out.I("Traveling to Astral Oasis (Quark Boss 1) failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToDimentionalTapestry() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.Events.DimentionalTapestry
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x37356B") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Dimentional Tapestry (Quark Boss 2)")
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
        Out.D("Travel success to Dimentional Tapestry (Quark Boss 2).")
        Return true
    } Else {
        Out.I("Traveling to Dimentional Tapestry (Quark Boss 2). Attempt to"
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
            Out.D(
                "Blind travel success to Dimentional Tapestry (Quark Boss 2).")
            Return true
        } Else {
            Out.I("Traveling to Dimentional Tapestry (Quark Boss 2) failed,"
                " colour found was " GetAreaSampleColour())
            Return false
        }
    }
}

GoToPlankScope() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Areas.Events.PlankScope
    button2 := Points.Areas.Events.PlankScope2
    If (!DisableZoneChecks) {
        While (!IsAreaSampleColour("0x0B1E32") && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Traveling to Plank Scope (Quark Boss 3)")
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
        Out.D("Travel success to Plank Scope (Quark Boss 3).")
        Return true
    } Else {
        Out.I(
            "Traveling to Plank Scope (Quark Boss 3). Attempt to blind travel"
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
            Out.D("Blind travel success to Plank Scope (Quark Boss 3).")
            Return true
        } Else {
            Out.I("Traveling to Plank Scope (Quark Boss 3) failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

SingleAnteLeaftonTravel(extradelay := 0) {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Out.I("Traveling to Ante Leafton")
    Travel.ClosePanelIfActive()
    Travel.OpenAreasQuark(extradelay)
    Travel.ScrollAmountDown(2)
    button := Points.Areas.QuarkAmbit.AnteLeafton
    button2 := Points.Areas.QuarkAmbit.AnteLeafton2
    If (button.IsButtonActive()) {
        button.ClickOffset(5, , NavigateTime + extradelay)
    } Else If (button2.IsButtonActive()) {
        button2.ClickOffset(5, , NavigateTime + extradelay)
    }
    Sleep(NavigateTime)
}

GoToAnteLeafton() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
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
            Out.D("Travel success to Ante Leafton.")
            Return true
        }
    }
    If (!IsAreaBlack() || !IsBossTimerActive()) {
        Out.I("Traveling to Ante Leafton. Attempt to blind travel"
            " with slowed times.")
        SingleAnteLeaftonTravel(200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (IsAreaSampleColour("0x000000")) {
            Out.D("Blind travel success to Ante Leafton.")
            Return true
        } Else {
            Out.I("Traveling to Ante Leafton failed, colour"
                " found was " GetAreaSampleColour())
            Return false
        }
    }
}

GotoCardsFirstTab() {
    If (!Window.IsActive()) {
        Out.I("No window found while trying to travel.")
        Return false
    }
    Global DisableZoneChecks
    i := 0
    button := Points.Card.Tab.Packs
    If (!DisableZoneChecks) {
        While (!Travel.Cards.IsOnPacks() && Window.IsActive() && i <= 4) {
            If (!Window.IsActive()) {
                Out.I("No window found while trying to travel.")
                Return false
            }
            Out.I("Opening cards, packs (first) tab.")
            Shops.OpenCards()
            Sleep(NavigateTime)
            button.Click(NavigateTime)
            ; Open first tab incase wrong tab
            Sleep(NavigateTime)
            i++
        }
    }
    If (Travel.Cards.IsOnPacks()) {
        Out.D("Travel success to Cards First Tab.")
        Return true
    } Else {
        ; Attempt to blind travel with slowed times
        Out.I("Opening cards, packs (first) tab. Attempt to blind travel with"
            " slowed times.")
        Shops.OpenCards(, 200)
        Sleep(NavigateTime + 200)
        button.Click(NavigateTime + 200)
        ; Open first tab incase wrong tab
        Sleep(NavigateTime + 200)
        If (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            Return true
        }
        If (Travel.Cards.IsOnPacks()) {
            Out.D("Blind travel success to Cards First Tab.")
            Return true
        } Else {
            Out.I("GotoCardsFirstTab: Not at cards first tab")
            Return false
        }
    }
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
