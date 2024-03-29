#Requires AutoHotkey v2.0

#Include ../Lib/Coords.ahk
#Include Spammers.ahk

global TowerPassiveCraftEnabled := true
global TowerPassiveBanksEnabled := true
global BankEnableLGDeposit := true
global BankEnableSNDeposit := true
global BankEnableEBDeposit := true
global BankEnableFFDeposit := true
global BankEnableSRDeposit := true
global BankEnableQADeposit := true
global BankDepositTime := 5
global NavigateTime := 150

global ArtifactSleepAmount := 1

fTowerFarm() {
    GoToLeafTower()
    starttime := A_Now
    craftStopCoord := cCraftingStop()
    SpamTowerPassive()
    if (TowerPassiveBanksEnabled) {
        OpenPets()
        Sleep(NavigateTime)
        ToolTip("Tower Passive, Bank Maintainer Active", W / 2,
            WinRelPosLargeH(200), 4)
        BankSinglePass()
        ToolTip(, , , 4)
    }
    if (IsPanelActive()) {
        ClosePanel()
        Sleep(NavigateTime)
    }
    ToolTip("Tower Farm Passive Active", W / 2, H / 2, 5)
    loop {
        if (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            TowerPassiveBanksEnabled) {
                Log("TowerPassive: Bank Maintainer starting.")
                ToolTip("Tower Passive, Bank Maintainer Active", W / 2,
                    WinRelPosLargeH(200), 4)
                BankSinglePass()
                ToolTip(, , , 4)
                starttime := A_Now
        }
        if (!IsWindowActive()) {
            break
        }
        if (TowerPassiveCraftEnabled) {
            Sleep(NavigateTime)
            OpenCrafting()
            Sleep(NavigateTime)
            if (!IsPanelActive()) {
                OpenCrafting()
                Sleep(NavigateTime)
            }
        }
        while (DateDiff(A_Now, starttime, "Seconds") < BankDepositTime * 60) {
            if (!IsWindowActive()) {
                break
            }
            if (TowerPassiveCraftEnabled && craftStopCoord.IsButtonActive()) {
                craftStopCoord.ClickOffset(, , 17)
            }
        }
    }
    ToolTip(, , , 5)
    KillTowerPassiveSpammer()
}