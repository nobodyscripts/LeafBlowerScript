#Requires AutoHotkey v2.0

Global SpammerPID := 0
Global HyacinthUseSlot := "All"
Global HyacinthFarmBoss := true
Global HyacinthUseFlower := 1
Global HyacinthUseSpheres := true
Global HyacinthUseNextAvailableFlower := true
Global HyacinthBanksEnabled := true
Global BankDepositTime := 5
Global NavigateTime := 150
Global BossFarmUsesWobblyWings := false

fFarmNormalBossAndNatureHyacinth() {
    Global BossFarmUsesWobblyWings, HyacinthFarmBoss, HyacinthUseSlot,
        BankDepositTime, HyacinthBanksEnabled, NavigateTime

    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    ToolTip()
    Killcount := 0
    starttime := A_Now
    bossfarm := false
    flowerID := HyacinthUseFlower
    flowerTypesUsed := 1
    If (HyacinthBanksEnabled) {
        Travel.OpenPets()
        Sleep(NavigateTime)
        BankSinglePass()
    }

    OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)

    ; Boss timer stuff
    IsPrevTimerLong := IsBossTimerLong()

    If (HyacinthFarmBoss && BossFarmUsesWobblyWings) {
        bossfarm := true
        GameKeys.TriggerWobblyWings()
        Sleep(NavigateTime)
        Spammer().NormalBossStart()
    }
    ; works for font 0 and font 1
    ; 530 425 harvest
    ; 666 425 harvest all
    ; 1380 750 plant
    ; 1700 750 plant all
    ; TODO Move point to Points
    HarvestAllButton := cPoint(1380, 750)
    If (StrLower(HyacinthUseSlot) = "all") {
        HarvestButton := cPoint(666, 425)
        PlantButton := cPoint(1700, 750)
    } Else {
        HarvestButton := cPoint(530, 425)
        PlantButton := cPoint(1380, 750)
    }
    Loop {
        If (!Window.IsActive()) {
            Log("BossHyacinth: Exiting as no game.")
            cReload() ; Kill if no game
            Break
        }
        If (!Window.IsPanel()) {
            Log(
                "BossHyacinth: Did not find panel. Aborted farming. Violins active"
            )
            Break
        }
        If (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            HyacinthBanksEnabled) {
            If (bossfarm) {
                Spammer().KillNormalBoss() ; Need to halt any WW spam
            }
            Log("BossHyacinth: Bank Maintainer starting.")
            ToolTip("BossHyacinth Bank Maintainer Active", Window.W / 2, Window
                .RelH(200), 4)
            BankSinglePass()
            Sleep(NavigateTime)
            ToolTip(, , , 4)
            starttime := A_Now
            OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)
            If (bossfarm) {
                Spammer().NormalBossStart() ; Restart spammer now we can travel
            }
            Sleep(NavigateTime)
        }
        If (HarvestButton.IsButtonActive()) {
            ; If harvest button active
            HarvestButton.ClickOffset(5, , NavigateTime)
        }
        If (PlantButton.IsButtonActive()) {
            ; If plant all button available, we've not run out
            If (HarvestAllButton.IsButtonActive()) {
                ; If planting available via plant button, planting available
                PlantButton.ClickOffset(5, , NavigateTime)
            } Else {
                If (HyacinthUseNextAvailableFlower && flowerTypesUsed < 16) {
                    ; If upgrading flower type and we've not gone through all 16
                    newFlowerID := FlowerToID(HyacinthUseFlower) + 1
                    If (newFlowerID > 16) {
                        newFlowerID := 1
                    }
                    flowerTypesUsed := flowerTypesUsed++
                    flowerID := newFlowerID
                } Else If (HyacinthUseNextAvailableFlower && flowerTypesUsed >=
                    16) {
                    ; Run out of seeds so exiting
                    If (HyacinthFarmBoss) Spammer().KillNormalBoss()
                        Log("BossHyacinth: Plants exausted. Exiting.")
                    ToolTip("Plants exausted. Exiting.", Window.W / 2, Window.H /
                        2 + Window.RelH(50), 2)
                    SetTimer(ToolTip.Bind(, , , 2), -3000)
                    Break
                }
            }
            Sleep(NavigateTime)
        }

        If (HyacinthUseSpheres) {
            ; Use spheres if we have got the option to do so
            UseSphereLoop(HarvestButton)
        }
        If (bossfarm) {
            IsTimerLong := IsBossTimerLong()
            ; if state of timer has changed and is now off, we killed
            If ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                ; If the timer is longer, killed too quick to get a gap
                Killcount++
            }
            IsPrevTimerLong := IsTimerLong
            If (Travel.HomeGarden.IsAreaGarden() && Spammer().IsNormalBossActive()
            ) {
                If (HyacinthFarmBoss) Spammer().KillNormalBoss()
                    Log("BossHyacinth: User killed.")
                ToolTip("Killed by boss", Window.W / 2, Window.H / 2 + Window.RelH(
                    50), 2)
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                Return
            }
            ToolTip("Hyacinth on, Kills: " . Killcount, Window.W / 2 - Window.RelW(
                150), Window.H / 2 + Window.RelH(150), 1)
        } Else {
            ToolTip("Hyacinth on, BossFarmUsesWobblyWings disabled.", Window.W /
                2 - Window.RelW(150), Window.H / 2 + Window.RelH(150), 1)
        }
    }
    ToolTip(, , , 1)
}

OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID) {
    Sleep(NavigateTime)
    While (!Travel.HomeGarden.IsAreaGarden()) {
        GoToFarmField()
    }
    Sleep(NavigateTime)
    Travel.ClosePanelIfActive()
    ClickFarmSlot(HyacinthUseSlot)
    Sleep(NavigateTime)
    SelectFlower(FlowerToID(flowerID)) ; Select flower to use
    Sleep(NavigateTime)
}

ClickFarmSlot(HyacinthUseSlot) {
    ; TODO Move point to Points
    Switch HyacinthUseSlot {
        Case "All":
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        Case "all":
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        Case 1:
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        Case 2:
            cPoint(745, 500).Click(NavigateTime) ; Slot 2
        Case 3:
            cPoint(1120, 500).Click(NavigateTime) ; Slot 3
        Case 4:
            cPoint(1490, 500).Click(NavigateTime) ; Slot 4
        Case 5:
            cPoint(1870, 500).Click(NavigateTime) ; Slot 5
        Case 6:
            cPoint(375, 865).Click(NavigateTime) ; Slot 6
        Case 7:
            cPoint(745, 865).Click(NavigateTime) ; Slot 7
        Case 8:
            cPoint(1120, 865).Click(NavigateTime) ; Slot 8
        Case 9:
            cPoint(1490, 865).Click(NavigateTime) ; Slot 9
        Case 10:
            cPoint(1870, 865).Click(NavigateTime) ; Slot 10
        default:
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
    }
}

FlowerToID(flower) {

    If (IsNumber(flower) && flower > 0 && flower < 17) {
        ; If its already a number return the number
        Return flower
    }
    flower := StrLower(flower)
    Switch flower {
        Case "hyacinth":
            Return 1
        Case "pansy":
            Return 2
        Case "hibiscus":
            Return 3
        Case "rose":
            Return 4
        Case "poppy":
            Return 5
        Case "primula":
            Return 6
        Case "forget-me-not":
            Return 7
        Case "tulip":
            Return 8
        Case "camomile":
            Return 9
        Case "dandelion":
            Return 10
        Case "aster":
            Return 11
        Case "daffodil":
            Return 12
        Case "cornflower":
            Return 13
        Case "lily of the valley":
            Return 14
        Case "dames rocket":
            Return 15
        Case "marigold":
            Return 16
        default:
            Return 1
    }
}

SelectFlower(flowerID) {
    ; TODO Move point to Points
    Switch flowerID {
        Case 1:
            cPoint(380, 600).Click(NavigateTime) ; Hyacinth Slot 1
        Case 2:
            cPoint(500, 600).Click(NavigateTime) ; Pansy Slot 2
        Case 3:
            cPoint(620, 600).Click(NavigateTime) ; Hibiscus Slot 3
        Case 4:
            cPoint(740, 600).Click(NavigateTime) ; Rose Slot 4
        Case 5:
            cPoint(860, 600).Click(NavigateTime) ; Poppy Slot 5
        Case 6:
            cPoint(980, 600).Click(NavigateTime) ; Primula Slot 6
        Case 7:
            cPoint(1100, 600).Click(NavigateTime) ; Forget-me-not Slot 7
        Case 8:
            cPoint(1220, 600).Click(NavigateTime) ; Tulip Slot 8
        Case 9:
            cPoint(380, 700).Click(NavigateTime) ; Camomile Slot 9
        Case 10:
            cPoint(500, 700).Click(NavigateTime) ; Dandelion Slot 10
        Case 11:
            cPoint(620, 700).Click(NavigateTime) ; Aster Slot 11
        Case 12:
            cPoint(740, 700).Click(NavigateTime) ; Daffodil Slot 12
        Case 13:
            cPoint(860, 700).Click(NavigateTime) ; Cornflower Slot 13
        Case 14:
            cPoint(980, 700).Click(NavigateTime) ; Lily of the Valley Slot 14
        Case 15:
            cPoint(1100, 700).Click(NavigateTime) ; Dames Rocket Slot 15
        Case 16:
            cPoint(1220, 700).Click(NavigateTime) ; Marigold Slot 16
        default:
            cPoint(380, 600).Click(NavigateTime) ; Hyacinth
    }
}

UseSphereLoop(point) {
    ; Plant should be planted, use sphere then check for harvest
    ; If no harvest button and sphere button active loop, else break
    sphereButton := Points.Hyacinth.UseSphere
    Loop {
        If (sphereButton.IsButtonActive() && !point.IsButtonActive()) {
            sphereButton.ClickOffset()
            Sleep(NavigateTime + 50)
        } Else {
            Break
        }
    }
}