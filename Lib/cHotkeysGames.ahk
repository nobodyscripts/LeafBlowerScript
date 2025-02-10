#Requires AutoHotkey v2.0

#Include cHotkeys.ahk

Class cHotkeysGames extends cHotkeys {
    IsGameHotkeys := true
    OpenAreas() {
        ControlSend("{" this.GetHotkey("OpenAreas") "}", , Window.Title)
    }

    OpenGemShop() {
        ControlSend("{" this.GetHotkey("OpenGemShop") "}", , Window.Title)
    }

    OpenTrades() {
        ControlSend("{" this.GetHotkey("OpenTrades") "}", , Window.Title)
    }

    OpenPets() {
        ControlSend("{" this.GetHotkey("OpenPets") "}", , Window.Title)
    }

    OpenBank() {
        ControlSend("{" this.GetHotkey("OpenBank") "}", , Window.Title)
    }

    OpenBorbVentures() {
        ControlSend("{" this.GetHotkey("OpenBorbVentures") "}", , Window.Title)
    }

    OpenCards() {
        ControlSend("{" this.GetHotkey("OpenCards") "}", , Window.Title)
    }

    OpenAlchemy() {
        ControlSend("{" this.GetHotkey("OpenAlchemy") "}", , Window.Title)
    }

    OpenCrafting() {
        ControlSend("{" this.GetHotkey("OpenCrafting") "}", , Window.Title)
    }

    OpenMining() {
        ControlSend("{" this.GetHotkey("OpenMining") "}", , Window.Title)
    }

    OpenGoldPortal() {
        ControlSend("{" this.GetHotkey("OpenGoldPortal") "}", , Window.Title)
    }

    OpenRedPortal() {
        ControlSend("{" this.GetHotkey("OpenRedPortal") "}", , Window.Title)
    }

    OpenGreenPortal() {
        ControlSend("{" this.GetHotkey("OpenGreenPortal") "}", , Window.Title)
    }

    OpenBluePortal() {
        ControlSend("{" this.GetHotkey("OpenBluePortal") "}", , Window.Title)
    }

    OpenBLCShop() {
        ControlSend("{" this.GetHotkey("OpenBlc") "}", , Window.Title)
    }

    OpenMLCShop() {
        ControlSend("{" this.GetHotkey("OpenMlc") "}", , Window.Title)
    }

    OpenULCShop() {
        ControlSend("{" this.GetHotkey("OpenUlc") "}", , Window.Title)
    }

    TriggerBlazingSkull() {
        ControlSend("{" this.GetHotkey("TriggerBlazingSkull") "}", , Window.Title
        )
    }

    TriggerGravity() {
        ControlSend("{" this.GetHotkey("TriggerGravity") "}", , Window.Title)
    }

    TriggerSuitcase() {
        ControlSend("{" this.GetHotkey("TriggerSuitcase") "}", , Window.Title)
    }

    TriggerViolin() {
        ControlSend("{" this.GetHotkey("TriggerViolin") "}", , Window.Title)
    }

    TriggerWind() {
        ControlSend("{" this.GetHotkey("TriggerWind") "}", , Window.Title)
    }

    TriggerWobblyWings() {
        ControlSend("{" this.GetHotkey("TriggerWobblyWings") "}", , Window.Title
        )
    }

    TriggerSeeds() {
        ControlSend("{" this.GetHotkey("TriggerSeeds") "}", , Window.Title)
    }

    RefreshTrades() {
        ControlSend("{" this.GetHotkey("RefreshTrades") "}", , Window.Title)
    }

    ClosePanel() {
        ControlSend("{" this.GetHotkey("ClosePanel") "}", , Window.Title)
    }

    OpenConverters() {
        ControlSend("{" this.GetHotkey("OpenConverters") "}", , Window.Title)
    }

    EquipDefaultGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipDefaultGearLoadout") "}", , Window
            .Title)
    }

    EquipTowerGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipTowerGearLoadout") "}", , Window.Title
        )
    }
    
    EquipSlapGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipSlapGearLoadout") "}", , Window.Title)
    }
    
    EquipSwordGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipSwordGearLoadout") "}", , Window.Title)
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
}