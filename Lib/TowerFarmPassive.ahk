#Requires AutoHotkey v2.0

global ArtifactSleepAmount := 1

fTowerFarm() {
    GoToLeafTower()
    ToolTip("Tower Farm Passive Active", W/2, H/2, 4)
    loop {
        if (!IsWindowActive()) {
            Log("TowerFarm: Exiting as no game.")
            return
        }
        if (IsAreaResetToGarden()) {
            GoToLeafTower()
        }
        if (IsWindowActive() && !IsBossTimerActive() && !IsAreaResetToGarden()) {
            TriggerBlazingSkull()
            TriggerWind()
            Sleep(ArtifactSleepAmount)
        }
    }
    
}