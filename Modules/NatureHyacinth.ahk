#Requires AutoHotkey v2.0

global SpammerPID := 0
global HyacinthUseSlot := "All"
global HyacinthFarmBoss := true
global BossFarmUsesWobblyWings := true
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
        OpenPets()
        Sleep(NavigateTime)
        BankSinglePass()
    }

    OpenFarmAtSlotAndFlower(HyacinthUseSlot, flowerID)

    ; Boss timer stuff
    IsPrevTimerLong := IsBossTimerLong()

    if (HyacinthFarmBoss && BossFarmUsesWobblyWings) {
        bossfarm := true
        TriggerWobblyWings()
        Sleep(NavigateTime)
        SpamViolins()
    }
    ; works for font 0 and font 1
    ; 530 425 harvest
    ; 666 425 harvest all
    ; 1380 750 plant
    ; 1700 750 plant all
    if (StrLower(HyacinthUseSlot) = "all") {
        HarvBX := 666
        HarvBY := 425
        PlantBX := 1700
        PlantBY := 750
    } else {
        HarvBX := 530
        HarvBY := 425
        PlantBX := 1380
        PlantBY := 750
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
                    SpamViolins() ; Restart spammer now we can travel
                }
                Sleep(NavigateTime)
        }
        if (IsButtonActive(WinRelPosLargeW(HarvBX), WinRelPosLargeH(HarvBY))) {
            ; If harvest button active
            fSlowClickRelL(HarvBX + 5, HarvBY, NavigateTime)
            Sleep(NavigateTime)
        }
        if (IsButtonActive(WinRelPosLargeW(PlantBX), WinRelPosLargeH(PlantBY))) {
            ; If plant all button available, we've not run out
            if (IsButtonActive(WinRelPosLargeW(1380), WinRelPosLargeH(750))) {
                ; If planting available via plant button, planting available
                fSlowClickRelL(PlantBX + 5, PlantBY, NavigateTime)
            }
            Sleep(NavigateTime)
        } else {
            if (HyacinthUseNextAvailableFlower && flowerTypesUsed < 16) {
                ; If upgrading flower type and we've not gone through all 16
                newFlowerID := FlowerToID(HyacinthUseFlower) + 1
                if (newFlowerID > 16) {
                    newFlowerID := 1
                }
                flowerTypesUsed := flowerTypesUsed++
                flowerID := newFlowerID
            } else {
                ; Run out of seeds so exiting
                if (HyacinthFarmBoss) KillSpammer()
                    Log("BossHyacinth: Plants exausted. Exiting.")
                ToolTip("Plants exausted. Exiting.", W / 2, H / 2 +
                    WinRelPosLargeH(50), 2)
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                break
            }
        }
        if (HyacinthUseSpheres) {
            ; Use spheres if we have got the option to do so
            UseSphereLoop(HarvBX, HarvBY)
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
    GoToFarmField()
    sleep(NavigateTime)
    if (IsPanelActive()) {
        ClosePanel()
        sleep(NavigateTime)
    }
    ClickFarmSlot(HyacinthUseSlot)
    sleep(NavigateTime)
    SelectFlower(FlowerToID(flowerID)) ; Select flower to use
    sleep(NavigateTime)
}

ClickFarmSlot(HyacinthUseSlot) {
    switch HyacinthUseSlot {
        case "All":
            fSlowClickRelL(375, 500, NavigateTime) ; Slot 1
        case "all":
            fSlowClickRelL(375, 500, NavigateTime) ; Slot 1
        case 1:
            fSlowClickRelL(375, 500, NavigateTime) ; Slot 1
        case 2:
            fSlowClickRelL(745, 500, NavigateTime) ; Slot 2
        case 3:
            fSlowClickRelL(1120, 500, NavigateTime) ; Slot 3
        case 4:
            fSlowClickRelL(1490, 500, NavigateTime) ; Slot 4
        case 5:
            fSlowClickRelL(1870, 500, NavigateTime) ; Slot 5
        case 6:
            fSlowClickRelL(375, 865, NavigateTime) ; Slot 6
        case 7:
            fSlowClickRelL(745, 865, NavigateTime) ; Slot 7
        case 8:
            fSlowClickRelL(1120, 865, NavigateTime) ; Slot 8
        case 9:
            fSlowClickRelL(1490, 865, NavigateTime) ; Slot 9
        case 10:
            fSlowClickRelL(1870, 865, NavigateTime) ; Slot 10
        default:
            fSlowClickRelL(375, 500, NavigateTime) ; Slot 1
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
            fSlowClickRelL(380, 600, NavigateTime) ; Hyacinth Slot 1
        case 2:
            fSlowClickRelL(500, 600, NavigateTime) ; Pansy Slot 2
        case 3:
            fSlowClickRelL(620, 600, NavigateTime) ; Hibiscus Slot 3
        case 4:
            fSlowClickRelL(740, 600, NavigateTime) ; Rose Slot 4
        case 5:
            fSlowClickRelL(860, 600, NavigateTime) ; Poppy Slot 5
        case 6:
            fSlowClickRelL(980, 600, NavigateTime) ; Primula Slot 6
        case 7:
            fSlowClickRelL(1100, 600, NavigateTime) ; Forget-me-not Slot 7
        case 8:
            fSlowClickRelL(1220, 600, NavigateTime) ; Tulip Slot 8
        case 9:
            fSlowClickRelL(380, 700, NavigateTime) ; Camomile Slot 9
        case 10:
            fSlowClickRelL(500, 700, NavigateTime) ; Dandelion Slot 10
        case 11:
            fSlowClickRelL(620, 700, NavigateTime) ; Aster Slot 11
        case 12:
            fSlowClickRelL(740, 700, NavigateTime) ; Daffodil Slot 12
        case 13:
            fSlowClickRelL(860, 700, NavigateTime) ; Cornflower Slot 13
        case 14:
            fSlowClickRelL(980, 700, NavigateTime) ; Lily of the Valley Slot 14
        case 15:
            fSlowClickRelL(1100, 700, NavigateTime) ; Dames Rocket Slot 15
        case 16:
            fSlowClickRelL(1220, 700, NavigateTime) ; Marigold Slot 16
        default:
            fSlowClickRelL(380, 600, NavigateTime) ; Hyacinth
    }
}

UseSphereLoop(HarvBX, HarvBY) {
    ; Plant should be planted, use sphere then check for harvest
    ; If no harvest button and sphere button active loop, else break
    sphereButton := cNatureFarmUseSphere()
    loop {
        if (sphereButton.IsButtonActive() &&
            !IsButtonActive(WinRelPosLargeW(HarvBX),
                WinRelPosLargeH(HarvBY))) {
                    sphereButton.ClickOffset()
                    Sleep(NavigateTime + 50)
        } else {
            break
        }
    }
}