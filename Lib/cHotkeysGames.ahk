#Requires AutoHotkey v2.0

#Include ..\ScriptLib\cHotkeys.ahk

Class cHotkeysGames extends cHotkeys {
    IsGameHotkeys := true
    OpenAreas() {
        this.DebugKeys("OpenAreas")
        ControlSend("{" this.GetHotkey("OpenAreas") "}", , Window.Title)
    }

    OpenGemShop() {
        this.DebugKeys("OpenGemShop")
        ControlSend("{" this.GetHotkey("OpenGemShop") "}", , Window.Title)
    }

    OpenTrades() {
        this.DebugKeys("OpenTrades")
        ControlSend("{" this.GetHotkey("OpenTrades") "}", , Window.Title)
    }

    OpenPets() {
        this.DebugKeys("OpenPets")
        ControlSend("{" this.GetHotkey("OpenPets") "}", , Window.Title)
    }

    OpenBank() {
        this.DebugKeys("OpenBank")
        ControlSend("{" this.GetHotkey("OpenBank") "}", , Window.Title)
    }

    OpenBorbVentures() {
        this.DebugKeys("OpenBorbVentures")
        ControlSend("{" this.GetHotkey("OpenBorbVentures") "}", , Window.Title)
    }

    OpenCards() {
        this.DebugKeys("OpenCards")
        ControlSend("{" this.GetHotkey("OpenCards") "}", , Window.Title)
    }

    OpenAlchemy() {
        this.DebugKeys("OpenAlchemy")
        ControlSend("{" this.GetHotkey("OpenAlchemy") "}", , Window.Title)
    }

    OpenCrafting() {
        this.DebugKeys("OpenCrafting")
        ControlSend("{" this.GetHotkey("OpenCrafting") "}", , Window.Title)
    }

    OpenMining() {
        this.DebugKeys("OpenMining")
        ControlSend("{" this.GetHotkey("OpenMining") "}", , Window.Title)
    }

    OpenGoldPortal() {
        this.DebugKeys("OpenGoldPortal")
        ControlSend("{" this.GetHotkey("OpenGoldPortal") "}", , Window.Title)
    }

    OpenRedPortal() {
        this.DebugKeys("OpenRedPortal")
        ControlSend("{" this.GetHotkey("OpenRedPortal") "}", , Window.Title)
    }

    OpenGreenPortal() {
        this.DebugKeys("OpenGreenPortal")
        ControlSend("{" this.GetHotkey("OpenGreenPortal") "}", , Window.Title)
    }

    OpenBluePortal() {
        this.DebugKeys("OpenBluePortal")
        ControlSend("{" this.GetHotkey("OpenBluePortal") "}", , Window.Title)
    }

    OpenBLCShop() {
        this.DebugKeys("OpenBlc")
        ControlSend("{" this.GetHotkey("OpenBlc") "}", , Window.Title)
    }

    OpenMLCShop() {
        this.DebugKeys("OpenMlc")
        ControlSend("{" this.GetHotkey("OpenMlc") "}", , Window.Title)
    }

    OpenULCShop() {
        this.DebugKeys("OpenUlc")
        ControlSend("{" this.GetHotkey("OpenUlc") "}", , Window.Title)
    }

    TriggerBlazingSkull() {
        this.DebugKeys("TriggerBlazingSkull")
        ControlSend("{" this.GetHotkey("TriggerBlazingSkull") "}", , Window.Title
        )
    }

    TriggerGravity() {
        this.DebugKeys("TriggerGravity")
        ControlSend("{" this.GetHotkey("TriggerGravity") "}", , Window.Title)
    }

    TriggerSuitcase() {
        this.DebugKeys("TriggerSuitcase")
        ControlSend("{" this.GetHotkey("TriggerSuitcase") "}", , Window.Title)
    }

    TriggerViolin() {
        this.DebugKeys("TriggerViolin")
        ControlSend("{" this.GetHotkey("TriggerViolin") "}", , Window.Title)
    }

    TriggerWind() {
        this.DebugKeys("TriggerWind")
        ControlSend("{" this.GetHotkey("TriggerWind") "}", , Window.Title)
    }

    TriggerWobblyWings() {
        this.DebugKeys("TriggerWobblyWings")
        ControlSend("{" this.GetHotkey("TriggerWobblyWings") "}", , Window.Title
        )
    }

    TriggerSeeds() {
        this.DebugKeys("TriggerSeeds")
        ControlSend("{" this.GetHotkey("TriggerSeeds") "}", , Window.Title)
    }

    RefreshTrades() {
        this.DebugKeys("RefreshTrades")
        ControlSend("{" this.GetHotkey("RefreshTrades") "}", , Window.Title)
    }

    ClosePanel() {
        this.DebugKeys("ClosePanel")
        ControlSend("{" this.GetHotkey("ClosePanel") "}", , Window.Title)
    }

    OpenConverters() {
        this.DebugKeys("OpenConverters")
        ControlSend("{" this.GetHotkey("OpenConverters") "}", , Window.Title)
    }

    EquipDefaultGearLoadout() {
        this.DebugKeys("EquipDefaultGearLoadout")
        ControlSend("{" this.GetHotkey("EquipDefaultGearLoadout") "}", , Window
        .Title)
    }

    EquipTowerGearLoadout() {
        this.DebugKeys("EquipTowerGearLoadout")
        ControlSend("{" this.GetHotkey("EquipTowerGearLoadout") "}", , Window.Title
        )
    }

    EquipSlapGearLoadout() {
        this.DebugKeys("EquipSlapGearLoadout")
        ControlSend("{" this.GetHotkey("EquipSlapGearLoadout") "}", , Window.Title)
    }

    EquipSwordGearLoadout() {
        this.DebugKeys("EquipSwordGearLoadout")
        ControlSend("{" this.GetHotkey("EquipSwordGearLoadout") "}", , Window.Title)
    }

    EquipElectricGearLoadout() {
        this.DebugKeys("EquipElectricGearLoadout")
        ControlSend("{" this.GetHotkey("EquipElectricGearLoadout") "}", , Window.Title)
    }

    ;These are not currently used so you can ignore the keybinds below
    /*
    
    EquipPyramidGearLoadout() {
        ControlSend("{Numpad6}", , Window.Title) ; Inactive
    }
    
    EquipQuarkGearLoadout() {
        ControlSend("{Numpad7}", , Window.Title)
    }
    
    EquipPilingGearLoadout() {
        ControlSend("{Numpad8}", , Window.Title) ; Inactive
    } */

    DebugKeys(key) {
        ; Single place to comment out the debug for all keys
        ;Out.D(key " Key sent: " this.GetHotkey(key))
    }
}
