#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk

Class sMoonstone extends Zone {
    /**
     * Go to zone
     */
    GoTo() {
        UlcWindow()
        Travel.ClosePanelIfActive()
        cPoint(1259, 1319).Click() ; Shop button
        Return Window.AwaitPanel()
    }

    /**
     * Max shop upgrades
     */
    Max(*) {
        UlcWindow()
        Shops.Moonstone.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        cPoint(1697, 307).ClickButtonActive() ; Unlock sand
        Sleep(50)
    }

    WaitForMoonstoneOrTimeout(*) {
        UlcWindow()
        Shops.Moonstone.GoTo()
        Travel.ScrollResetToTop()
        Sleep(50)
        EquipMulchSword() ; Activates unique leaves/pets on loadout too
        EquipMulchSword()
        If (!Travel.CursedKokkaupunki.GoTo()) {
            Out.I("Could not travel to CursedKokkaupunki, exiting")
            Return
        }
        gToolTip.CenterCD("Waiting for Moonstone to build up", 20000)
        /** @type {Timer} */
        Limiter := Timer()
        Limiter.CoolDownS(20, &isactive)
        While (!cPoint(1697, 307).IsBackground() && isactive) {
            GameKeys.TriggerWind()
            Sleep(17)
        }
        gToolTip.CenterCDDel()
        Return cPoint(1697, 307).IsBackground()

    }
}
