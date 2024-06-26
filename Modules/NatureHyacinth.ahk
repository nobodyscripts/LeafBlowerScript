#Requires AutoHotkey v2.0

global SpammerPID := 0
global HyacinthUseSlot := "All"
global HyacinthFarmBoss := true
global HyacinthUseFlower := 1
global HyacinthUseSpheres := true
global HyacinthUseNextAvailableFlower := true
global HyacinthBanksEnabled := true
global BankDepositTime := 5
global NavigateTime := 150

fFarmNormalBossAndNatureHyacinth() {
    global BossFarmUsesWobblyWings, HyacinthFarmBoss, HyacinthUseSlot,
        BankDepositTime, HyacinthBanksEnabled, NavigateTime

    ; If user set 0 in gui without adding a fraction, make at least 1 second
    if (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    ToolTip()
    Killcount := 0
    starttime := A_Now
    bossfarm := false
    flowerID := HyacinthUseFlower
    flowerTypesUsed := 1
    if (HyacinthBanksEnabled) {
        Travel.OpenPets()
        Sleep(NavigateTime)
        BankSinglePass()
    }

    OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)

    ; Boss timer stuff
    IsPrevTimerLong := IsBossTimerLong()

    if (HyacinthFarmBoss && BossFarmUsesWobblyWings) {
        bossfarm := true
        Gamekeys.TriggerWobblyWings()
        Sleep(NavigateTime)
        NormalBossSpammerStart()
    }
    ; works for font 0 and font 1
    ; 530 425 harvest
    ; 666 425 harvest all
    ; 1380 750 plant
    ; 1700 750 plant all
    HarvestAllButton := cPoint(1380, 750)
    if (StrLower(HyacinthUseSlot) = "all") {
        HarvestButton := cPoint(666, 425)
        PlantButton := cPoint(1700, 750)
    } else {
        HarvestButton := cPoint(530, 425)
        PlantButton := cPoint(1380, 750)
    }
    loop {
        if (!IsWindowActive()) {
            Log("BossHyacinth: Exiting as no game.")
            cReload() ; Kill if no game
            break
        }
        if (!IsPanelActive()) {
            Log("BossHyacinth: Did not find panel. Aborted farming. Violins active")
            break
        }
        if (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            HyacinthBanksEnabled) {
            if (bossfarm) {
                KillSpammer() ; Need to halt any WW spam
            }
            Log("BossHyacinth: Bank Maintainer starting.")
            ToolTip("BossHyacinth Bank Maintainer Active", W / 2,
                WinRelPosLargeH(200), 4)
            BankSinglePass()
            Sleep(NavigateTime)
            ToolTip(, , , 4)
            starttime := A_Now
            OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)
            if (bossfarm) {
                NormalBossSpammerStart() ; Restart spammer now we can travel
            }
            Sleep(NavigateTime)
        }
        if (HarvestButton.IsButtonActive()) {
            ; If harvest button active
            HarvestButton.ClickOffset(5, , NavigateTime)
        }
        if (PlantButton.IsButtonActive()) {
            ; If plant all button available, we've not run out
            if (HarvestAllButton.IsButtonActive()) {
                ; If planting available via plant button, planting available
                PlantButton.ClickOffset(5, , NavigateTime)
            } else {
                if (HyacinthUseNextAvailableFlower && flowerTypesUsed < 16) {
                    ; If upgrading flower type and we've not gone through all 16
                    newFlowerID := FlowerToID(HyacinthUseFlower) + 1
                    if (newFlowerID > 16) {
                        newFlowerID := 1
                    }
                    flowerTypesUsed := flowerTypesUsed++
                    flowerID := newFlowerID
                } else if (HyacinthUseNextAvailableFlower && flowerTypesUsed >= 16) {
                    ; Run out of seeds so exiting
                    if (HyacinthFarmBoss) KillSpammer()
                        Log("BossHyacinth: Plants exausted. Exiting.")
                    ToolTip("Plants exausted. Exiting.", W / 2, H / 2 +
                        WinRelPosLargeH(50), 2)
                    SetTimer(ToolTip.Bind(, , , 2), -3000)
                    break
                }

            }
            Sleep(NavigateTime)
        }

        if (HyacinthUseSpheres) {
            ; Use spheres if we have got the option to do so
            UseSphereLoop(HarvestButton)
        }
        if (bossfarm) {
            IsTimerLong := IsBossTimerLong()
            ; if state of timer has changed and is now off, we killed
            if ((IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                ; If the timer is longer, killed too quick to get a gap
                Killcount++
            }
            IsPrevTimerLong := IsTimerLong
            if (IsAreaResetToGarden() && IsSpammerActive()) {
                if (HyacinthFarmBoss) KillSpammer()
                    Log("BossHyacinth: User killed.")
                ToolTip("Killed by boss", W / 2, H / 2 +
                    WinRelPosLargeH(50), 2)
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                return
            }
            ToolTip("Hyacinth on, Kills: " . Killcount,
                W / 2 - WinRelPosLargeW(150),
                H / 2 + WinRelPosLargeH(150), 1)
        } else {
            ToolTip("Hyacinth on, BossFarmUsesWobblyWings disabled.",
                W / 2 - WinRelPosLargeW(150),
                H / 2 + WinRelPosLargeH(150), 1)
        }
    }
    ToolTip(, , , 1)
}

OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID) {
    sleep(NavigateTime)
    while (!IsAreaResetToGarden()) {
        GoToFarmField()
    }
    sleep(NavigateTime)
    Travel.ClosePanelIfActive()
    ClickFarmSlot(HyacinthUseSlot)
    sleep(NavigateTime)
    SelectFlower(FlowerToID(flowerID)) ; Select flower to use
    sleep(NavigateTime)
}

ClickFarmSlot(HyacinthUseSlot) {
    switch HyacinthUseSlot {
        case "All":
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        case "all":
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        case 1:
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
        case 2:
            cPoint(745, 500).Click(NavigateTime) ; Slot 2
        case 3:
            cPoint(1120, 500).Click(NavigateTime) ; Slot 3
        case 4:
            cPoint(1490, 500).Click(NavigateTime) ; Slot 4
        case 5:
            cPoint(1870, 500).Click(NavigateTime) ; Slot 5
        case 6:
            cPoint(375, 865).Click(NavigateTime) ; Slot 6
        case 7:
            cPoint(745, 865).Click(NavigateTime) ; Slot 7
        case 8:
            cPoint(1120, 865).Click(NavigateTime) ; Slot 8
        case 9:
            cPoint(1490, 865).Click(NavigateTime) ; Slot 9
        case 10:
            cPoint(1870, 865).Click(NavigateTime) ; Slot 10
        default:
            cPoint(375, 500).Click(NavigateTime) ; Slot 1
    }
}

FlowerToID(flower) {

    if (IsNumber(flower) && flower > 0 && flower < 17) {
        ; If its already a number return the number
        return flower
    }
    flower := StrLower(flower)
    switch flower {
        case "hyacinth":
            return 1
        case "pansy":
            return 2
        case "hibiscus":
            return 3
        case "rose":
            return 4
        case "poppy":
            return 5
        case "primula":
            return 6
        case "forget-me-not":
            return 7
        case "tulip":
            return 8
        case "camomile":
            return 9
        case "dandelion":
            return 10
        case "aster":
            return 11
        case "daffodil":
            return 12
        case "cornflower":
            return 13
        case "lily of the valley":
            return 14
        case "dames rocket":
            return 15
        case "marigold":
            return 16
        default:
            return 1
    }
}

SelectFlower(flowerID) {
    switch flowerID {
        case 1:
            cPoint(380, 600).Click(NavigateTime) ; Hyacinth Slot 1
        case 2:
            cPoint(500, 600).Click(NavigateTime) ; Pansy Slot 2
        case 3:
            cPoint(620, 600).Click(NavigateTime) ; Hibiscus Slot 3
        case 4:
            cPoint(740, 600).Click(NavigateTime) ; Rose Slot 4
        case 5:
            cPoint(860, 600).Click(NavigateTime) ; Poppy Slot 5
        case 6:
            cPoint(980, 600).Click(NavigateTime) ; Primula Slot 6
        case 7:
            cPoint(1100, 600).Click(NavigateTime) ; Forget-me-not Slot 7
        case 8:
            cPoint(1220, 600).Click(NavigateTime) ; Tulip Slot 8
        case 9:
            cPoint(380, 700).Click(NavigateTime) ; Camomile Slot 9
        case 10:
            cPoint(500, 700).Click(NavigateTime) ; Dandelion Slot 10
        case 11:
            cPoint(620, 700).Click(NavigateTime) ; Aster Slot 11
        case 12:
            cPoint(740, 700).Click(NavigateTime) ; Daffodil Slot 12
        case 13:
            cPoint(860, 700).Click(NavigateTime) ; Cornflower Slot 13
        case 14:
            cPoint(980, 700).Click(NavigateTime) ; Lily of the Valley Slot 14
        case 15:
            cPoint(1100, 700).Click(NavigateTime) ; Dames Rocket Slot 15
        case 16:
            cPoint(1220, 700).Click(NavigateTime) ; Marigold Slot 16
        default:
            cPoint(380, 600).Click(NavigateTime) ; Hyacinth
    }
}

UseSphereLoop(point) {
    ; Plant should be planted, use sphere then check for harvest
    ; If no harvest button and sphere button active loop, else break
    sphereButton := Points.Hyacinth.UseSphere
    loop {
        if (sphereButton.IsButtonActive() && !point.IsButtonActive()) {
            sphereButton.ClickOffset()
            Sleep(NavigateTime + 50)
        } else {
            break
        }
    }
}