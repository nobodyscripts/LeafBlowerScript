#Requires AutoHotkey v2.0

global QuarkFarmActive := false
global QuarkFarmResetToBoss := 0

fFarmNormalBossQuark() {
    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
    IsPrevTimerLong := IsBossTimerLong()
    Log("QuarkFarm: Equipped Quark Loadout")
    EquipQuarkGearLoadout()
    Sleep(72)
    switch QuarkFarmResetToBoss {
        case 1:
            GoToAstralOasis()
            Sleep(150)
            ClosePanel()
        case 2:
            GoToDimentionalTapestry()
            Sleep(150)
            ClosePanel()
        case 3:
            GoToPlankScope()
            Sleep(150)
            ClosePanel()
        default:

    }
    loop {
        if (!IsWindowActive()) {
            Log("BossQuark: Exiting as no game.")
            cReload() ; Kill if no game
            return
        }
        ToolTip("Quark Boss Mode",
            W / 2 - WinRelPosLargeW(100),
            H / 2 - WinRelPosLargeH(50), 5)
        TimerCurrentState := IsBossTimerActive()
        IsTimerLong := IsBossTimerLong()
        ; if state of timer has changed and is now off, we killed
        if ((TimerLastCheckStatus != TimerCurrentState && TimerCurrentState) ||
            (IsPrevTimerLong != IsTimerLong && IsTimerLong)) {
                ; If the timer is longer, killed too quick to get a gap
                Killcount++
        }
        TimerLastCheckStatus := IsBossTimerActive()
        IsPrevTimerLong := IsBossTimerLong()
        ; if we just started and there is a timer or looped and theres
        ; still a timer, we need to use a violin
        if (IsBossTimerActive()) {
            TriggerViolin()
            Sleep(ArtifactSleepAmount)
        } else {
            TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
        ; If boss killed us at gf assume we're weak and reset gf
        ; If user set gf kills too high it'll hit this
        if (IsAreaResetToGarden()) {
            Log("BossQuark: User killed.")
            ToolTip("Killed by boss", W / 2 - WinRelPosLargeW(70), H / 2 +
                WinRelPosLargeH(50), 6)
            SetTimer(ToolTip.Bind(, , , 6), -3000)
            switch QuarkFarmResetToBoss {
                case 1:
                    Sleep(10000)
                    GoToAstralOasis()
                    Sleep(150)
                    ClosePanel()
                case 2:
                    Sleep(10000)
                    GoToDimentionalTapestry()
                    Sleep(150)
                    ClosePanel()
                case 3:
                    Sleep(10000)
                    GoToPlankScope()
                    Sleep(150)
                    ClosePanel()
                default:
                    ToolTip("Exiting quark mode.", W / 2 - WinRelPosLargeW(100),
                        H / 1.7, 7)
                    SetTimer(ToolTip.Bind(, , , 7), -3000)
                    break
            }
        }
        ToolTip("Quark Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(75),
            H / 2 + WinRelPosLargeH(20), 8)
    }
    SetTimer(ToolTip.Bind(, , , 5), -1)
    SetTimer(ToolTip.Bind(, , , 8), -1)
    Sleep(72)
    Log("QuarkFarm: Equipped Default Loadout")
    EquipDefaultGearLoadout()
}