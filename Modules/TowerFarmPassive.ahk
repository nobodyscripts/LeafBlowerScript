#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\Spammers.ahk

global TowerPassiveCraftEnabled := true
global TowerPassiveBanksEnabled := true
global TowerPassiveTravelEnabled := true
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
    if (TowerPassiveTravelEnabled) {
        GoToLeafTower()
    }
    starttime := A_Now
    craftStopCoord := Points.Crafting.Stop
    Spammer.TowerPassiveStart()
    if (TowerPassiveBanksEnabled) {
        Travel.OpenPets()
        Sleep(NavigateTime)
        ToolTip("Tower Passive, Bank Maintainer Active", Window.W / 2, Window.RelH(
            200), 4)
        BankSinglePass()
        ToolTip(, , , 4)
    }
    Travel.ClosePanelIfActive()
    ToolTip("Tower Farm Passive Active", Window.W / 2, Window.H / 2, 5)
    loop {
        if (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
        TowerPassiveBanksEnabled) {
            Out.I("TowerPassive: Bank Maintainer starting.")
            ToolTip("Tower Passive, Bank Maintainer Active", Window.W / 2,
                Window.RelH(200), 4)
            BankSinglePass()
            ToolTip(, , , 4)
            starttime := A_Now
        }
        if (!Window.IsActive()) {
            break
        }
        if (TowerPassiveCraftEnabled) {
            Sleep(NavigateTime)
            Travel.OpenCrafting()
            Sleep(NavigateTime)
            if (!Window.IsPanel()) {
                Travel.OpenCrafting()
                Sleep(NavigateTime)
            }
        }
        while (DateDiff(A_Now, starttime, "Seconds") < BankDepositTime * 60) {
            if (!Window.IsActive()) {
                break
            }
            if (TowerPassiveCraftEnabled && craftStopCoord.IsButtonActive()) {
                craftStopCoord.ClickOffset(, , 17)
            }
        }
    }
    ToolTip(, , , 5)
    Spammer.KillTowerPassive()
}
