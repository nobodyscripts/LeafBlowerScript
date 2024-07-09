#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\Spammers.ahk

Global TowerPassiveCraftEnabled := true
Global TowerPassiveBanksEnabled := true
Global BankEnableLGDeposit := true
Global BankEnableSNDeposit := true
Global BankEnableEBDeposit := true
Global BankEnableFFDeposit := true
Global BankEnableSRDeposit := true
Global BankEnableQADeposit := true
Global BankDepositTime := 5
Global NavigateTime := 150

fTowerFarm() {
    Global BankDepositTime
    ; If user set 0 in gui without adding a fraction, make at least 1 second
    If (BankDepositTime = 0) {
        BankDepositTime := 0.017
    }
    GoToLeafTower()
    starttime := A_Now
    craftStopCoord := Points.Crafting.Stop
    TowerPassiveSpammerStart()
    If (TowerPassiveBanksEnabled) {
        Travel.OpenPets()
        Sleep(NavigateTime)
        ToolTip("Tower Passive, Bank Maintainer Active", W / 2, WinRelPosLargeH(
            200), 4)
        BankSinglePass()
        ToolTip(, , , 4)
    }
    Travel.ClosePanelIfActive()
    ToolTip("Tower Farm Passive Active", W / 2, H / 2, 5)
    Loop {
        If (DateDiff(A_Now, starttime, "Seconds") >= BankDepositTime * 60 &&
            TowerPassiveBanksEnabled) {
            Log("TowerPassive: Bank Maintainer starting.")
            ToolTip("Tower Passive, Bank Maintainer Active", W / 2,
                WinRelPosLargeH(200), 4)
            BankSinglePass()
            ToolTip(, , , 4)
            starttime := A_Now
        }
        If (!IsWindowActive()) {
            Break
        }
        If (TowerPassiveCraftEnabled) {
            Sleep(NavigateTime)
            Travel.OpenCrafting()
            Sleep(NavigateTime)
            If (!IsPanelActive()) {
                Travel.OpenCrafting()
                Sleep(NavigateTime)
            }
        }
        While (DateDiff(A_Now, starttime, "Seconds") < BankDepositTime * 60) {
            If (!IsWindowActive()) {
                Break
            }
            If (TowerPassiveCraftEnabled && craftStopCoord.IsButtonActive()) {
                craftStopCoord.ClickOffset(, , 17)
            }
        }
    }
    ToolTip(, , , 5)
    KillTowerPassiveSpammer()
}