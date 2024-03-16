#Requires AutoHotkey v2.0

global SpammerPID := 0
global HyacinthUseSlot := "All"
global HyacinthFarmBoss := true
global BossFarmUsesWobblyWings := true

fFarmNormalBossAndNatureHyacinth() {
    global BossFarmUsesWobblyWings, HyacinthFarmBoss, HyacinthUseSlot
    ToolTip()
    Killcount := 0
    GoToFarmField()
    sleep(NavigateTime)
    ClosePanel()
    sleep(NavigateTime)
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
    sleep(NavigateTime)
    fSlowClickRelL(380, 600, NavigateTime) ; Hyacinth
    sleep(NavigateTime)
    IsPrevTimerLong := IsBossTimerLong()
    bossfarm := false
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

        if (IsButtonActive(WinRelPosLargeW(HarvBX), WinRelPosLargeH(HarvBY))) {
            fSlowClickRelL(HarvBX + 5, HarvBY, NavigateTime)
            Sleep(NavigateTime)
            if (IsButtonActive(WinRelPosLargeW(PlantBX), WinRelPosLargeH(PlantBY))) {
                fSlowClickRelL(PlantBX + 5, PlantBY, NavigateTime)
            } else {
                if (HyacinthFarmBoss) KillSpammer()
                    Log("BossHyacinth: Plants exausted. Exiting.")
                ToolTip("Plants exausted. Exiting.", W / 2, H / 2 +
                    WinRelPosLargeH(50), 2)
                SetTimer(ToolTip.Bind(, , , 2), -3000)
                break
            }
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