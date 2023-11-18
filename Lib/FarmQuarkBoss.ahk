#Requires AutoHotkey v2.0

global QuarkFarmActive
QuarkFarmActive := false

fFarmNormalBossQuark() {
    Killcount := 0
    TimerLastCheckStatus := IsBossTimerActive()
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
            reload() ; Kill if no game
            return
        }
        ToolTip("Quark Boss Mode",
            W / 2 - WinRelPosLargeW(100),
            H / 2 - WinRelPosLargeH(50), 5)
        SetTimer(ToolTip, -500)
        TimerCurrentState := IsBossTimerActive()
        ; if state of timer has changed and is now off, we killed
        if (TimerLastCheckStatus != TimerCurrentState &&
            TimerCurrentState) {
                Killcount++
        }
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
            ToolTip("Killed by boss", W / 2, H / 2 +
                WinRelPosLargeH(50))
            SetTimer(ToolTip, -5000)
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

            }
        }
        ToolTip("Quark Kills: " . Killcount,
            W / 2 - WinRelPosLargeW(75),
            H / 2 + WinRelPosLargeH(20))
        SetTimer(ToolTip, -200)
        TimerLastCheckStatus := TimerCurrentState
    }
    Sleep(72)
    Log("QuarkFarm: Equipped Default Loadout")
    EquipDefaultGearLoadout()
}