#Requires AutoHotkey v2.0

; TODO Travel and opening review

S.AddSetting("NatureFarm", "HyacinthUseSlot", "All", "text")
S.AddSetting("NatureFarm", "HyacinthFarmBoss", true, "bool")
S.AddSetting("NatureFarm", "HyacinthUseFlower", "hyacinth", "text")
S.AddSetting("NatureFarm", "HyacinthUseSpheres", false, "bool")
S.AddSetting("NatureFarm", "HyacinthUseNextAvailableFlower", false, "bool")
S.AddSetting("NatureFarm", "HyacinthBanksEnabled", true, "bool")

fFarmNormalBossAndNatureHyacinth() {
    NavigateTime := S.Get("NavigateTime")
    BankDepositTime := S.Get("BankDepositTime")
    BossFarmUsesWobblyWings := S.Get("BossFarmUsesWobblyWings")
    HyacinthUseSlot := S.Get("HyacinthUseSlot")
    HyacinthFarmBoss := S.Get("HyacinthFarmBoss")
    HyacinthUseFlower := S.Get("HyacinthUseFlower")
    HyacinthUseSpheres := S.Get("HyacinthUseSpheres")
    HyacinthUseNextAvailableFlower := S.Get("HyacinthUseNextAvailableFlower")
    HyacinthBanksEnabled := S.Get("HyacinthBanksEnabled")
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
        Shops.OpenPets()
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
        Spammer.NormalBossStart()
    }
    ; works for font 0 and font 1
    ; 530 425 harvest
    ; 666 425 harvest all
    ; 1380 750 plant
    ; 1700 750 plant all
    ; TODO Move point to Points
    HarvestAllButton := cLBRButton(1380, 750)
    If (StrLower(HyacinthUseSlot) = "all") {
        HarvestButton := cLBRButton(666, 425)
        PlantButton := cLBRButton(1700, 750)
    } Else {
        HarvestButton := cLBRButton(530, 425)
        PlantButton := cLBRButton(1380, 750)
    }
    Loop {
        If (!Window.IsActive()) {
            Out.I("BossHyacinth: Exiting as no game.")
            Reload() ; Kill if no game
            Break
        }
        If (!Window.IsPanel()) {
            Out.I(
                "BossHyacinth: Did not find panel. Aborted farming. Violins active"
            )
            Break
        }
        If (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
        HyacinthBanksEnabled) {
            If (bossfarm) {
                Spammer.KillNormalBoss() ; Need to halt any WW spam
            }
            Out.I("BossHyacinth: Bank Maintainer starting.")
            ToolTip("BossHyacinth Bank Maintainer Active", Window.W / 2, Window
                .RelH(200), 4)
            BankSinglePass()
            Sleep(NavigateTime)
            ToolTip(, , , 4)
            starttime := A_Now
            OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)
            If (bossfarm) {
                Spammer.NormalBossStart() ; Restart spammer now we can travel
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
                    If (HyacinthFarmBoss) Spammer.KillNormalBoss()
                        Out.I("BossHyacinth: Plants exausted. Exiting.")
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
            If (Travel.HomeGarden.IsAreaGarden() && Spammer.IsNormalBossActive()) {
                If (HyacinthFarmBoss) Spammer.KillNormalBoss()
                    Out.I("BossHyacinth: User killed.")
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
    NavigateTime := S.Get("NavigateTime")
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
    NavigateTime := S.Get("NavigateTime")
    ; TODO Move point to Points
    Switch HyacinthUseSlot {
    Case "All":
        cLBRButton(375, 500).Click(NavigateTime) ; Slot 1
    Case "all":
        cLBRButton(375, 500).Click(NavigateTime) ; Slot 1
    Case 1:
        cLBRButton(375, 500).Click(NavigateTime) ; Slot 1
    Case 2:
        cLBRButton(745, 500).Click(NavigateTime) ; Slot 2
    Case 3:
        cLBRButton(1120, 500).Click(NavigateTime) ; Slot 3
    Case 4:
        cLBRButton(1490, 500).Click(NavigateTime) ; Slot 4
    Case 5:
        cLBRButton(1870, 500).Click(NavigateTime) ; Slot 5
    Case 6:
        cLBRButton(375, 865).Click(NavigateTime) ; Slot 6
    Case 7:
        cLBRButton(745, 865).Click(NavigateTime) ; Slot 7
    Case 8:
        cLBRButton(1120, 865).Click(NavigateTime) ; Slot 8
    Case 9:
        cLBRButton(1490, 865).Click(NavigateTime) ; Slot 9
    Case 10:
        cLBRButton(1870, 865).Click(NavigateTime) ; Slot 10
    default:
        cLBRButton(375, 500).Click(NavigateTime) ; Slot 1
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
    NavigateTime := S.Get("NavigateTime")
    ; TODO Move point to Points
    Switch flowerID {
    Case 1:
        cLBRButton(380, 600).Click(NavigateTime) ; Hyacinth Slot 1
    Case 2:
        cLBRButton(500, 600).Click(NavigateTime) ; Pansy Slot 2
    Case 3:
        cLBRButton(620, 600).Click(NavigateTime) ; Hibiscus Slot 3
    Case 4:
        cLBRButton(740, 600).Click(NavigateTime) ; Rose Slot 4
    Case 5:
        cLBRButton(860, 600).Click(NavigateTime) ; Poppy Slot 5
    Case 6:
        cLBRButton(980, 600).Click(NavigateTime) ; Primula Slot 6
    Case 7:
        cLBRButton(1100, 600).Click(NavigateTime) ; Forget-me-not Slot 7
    Case 8:
        cLBRButton(1220, 600).Click(NavigateTime) ; Tulip Slot 8
    Case 9:
        cLBRButton(380, 700).Click(NavigateTime) ; Camomile Slot 9
    Case 10:
        cLBRButton(500, 700).Click(NavigateTime) ; Dandelion Slot 10
    Case 11:
        cLBRButton(620, 700).Click(NavigateTime) ; Aster Slot 11
    Case 12:
        cLBRButton(740, 700).Click(NavigateTime) ; Daffodil Slot 12
    Case 13:
        cLBRButton(860, 700).Click(NavigateTime) ; Cornflower Slot 13
    Case 14:
        cLBRButton(980, 700).Click(NavigateTime) ; Lily of the Valley Slot 14
    Case 15:
        cLBRButton(1100, 700).Click(NavigateTime) ; Dames Rocket Slot 15
    Case 16:
        cLBRButton(1220, 700).Click(NavigateTime) ; Marigold Slot 16
    default:
        cLBRButton(380, 600).Click(NavigateTime) ; Hyacinth
    }
}

UseSphereLoop(point) {
    NavigateTime := S.Get("NavigateTime")
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
