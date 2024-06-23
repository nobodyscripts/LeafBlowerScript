#Requires AutoHotkey v2.0

#Include ../Lib/cPoints.ahk
#Include ../Lib/Spammers.ahk

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

fTowerFarm() {
    global BankDepositTime
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    if (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    GoToLeafTower()
    starttime := A_Now
    craftStopCoord := Points.Crafting.Stop
    TowerPassiveSpammerStart()
    if (TowerPassiveBanksEnabled) {
        Travel.OpenPets()
        Sleep(NavigateTime)
        ToolTip("Tower Passive, Bank Maintainer Active", W / 2,
            WinRelPosLargeH(200), 4)
        BankSinglePass()
        ToolTip(, , , 4)
    }
    if (IsPanelActive()) {
        GameKeys.ClosePanel()
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
            Travel.OpenCrafting()
            Sleep(NavigateTime)
            if (!IsPanelActive()) {
                Travel.OpenCrafting()
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