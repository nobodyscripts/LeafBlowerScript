#Requires AutoHotkey v2.0

#Include cHotkeys.ahk

global LBRWindowTitle

Class cHotkeysGames extends cHotkeys {
    IsGameHotkeys := true
    OpenAreas() {
        ControlSend("{" this.GetHotkey("OpenAreas") "}", , LBRWindowTitle)
    }

    OpenGemShop() {
        ControlSend("{" this.GetHotkey("OpenGemShop") "}", , LBRWindowTitle)
    }

    OpenTrades() {
        ControlSend("{" this.GetHotkey("OpenTrades") "}", , LBRWindowTitle)
    }

    OpenPets() {
        ControlSend("{" this.GetHotkey("OpenPets") "}", , LBRWindowTitle)
    }

    OpenBank() {
        ControlSend("{" this.GetHotkey("OpenBank") "}", , LBRWindowTitle)
    }

    OpenBorbVentures() {
        ControlSend("{" this.GetHotkey("OpenBorbVentures") "}", , LBRWindowTitle)
    }

    OpenCards() {
        ControlSend("{" this.GetHotkey("OpenCards") "}", , LBRWindowTitle)
    }

    OpenAlchemy() {
        ControlSend("{" this.GetHotkey("OpenAlchemy") "}", , LBRWindowTitle)
    }

    OpenCrafting() {
        ControlSend("{" this.GetHotkey("OpenCrafting") "}", , LBRWindowTitle)
    }

    OpenMining() {
        ControlSend("{" this.GetHotkey("OpenMining") "}", , LBRWindowTitle)
    }

    OpenGoldPortal() {
        ControlSend("{" this.GetHotkey("OpenGoldPortal") "}", , LBRWindowTitle)
    }

    TriggerBlazingSkull() {
        ControlSend("{" this.GetHotkey("TriggerBlazingSkull") "}", , LBRWindowTitle)
    }

    TriggerGravity() {
        ControlSend("{" this.GetHotkey("TriggerGravity") "}", , LBRWindowTitle)
    }

    TriggerSuitcase() {
        ControlSend("{" this.GetHotkey("TriggerSuitcase") "}", , LBRWindowTitle)
    }

    TriggerViolin() {
        ControlSend("{" this.GetHotkey("TriggerViolin") "}", , LBRWindowTitle)
    }

    TriggerWind() {
        ControlSend("{" this.GetHotkey("TriggerWind") "}", , LBRWindowTitle)
    }

    TriggerWobblyWings() {
        ControlSend("{" this.GetHotkey("TriggerWobblyWings") "}", , LBRWindowTitle)
    }

    TriggerSeeds() {
        ControlSend("{" this.GetHotkey("TriggerSeeds") "}", , LBRWindowTitle)
    }

    RefreshTrades() {
        ControlSend("{" this.GetHotkey("RefreshTrades") "}", , LBRWindowTitle)
    }

    ClosePanel() {
        ControlSend("{" this.GetHotkey("ClosePanel") "}", , LBRWindowTitle)
    }

    EquipDefaultGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipDefaultGearLoadout") "}", , LBRWindowTitle)
    }

    EquipTowerGearLoadout() {
        ControlSend("{" this.GetHotkey("EquipTowerGearLoadout") "}", , LBRWindowTitle)
    }

    ;These are not currently used so you can ignore the keybinds below
    /*
    
    EquipDamageGearLoadout() {
        ControlSend("{Numpad2}", , LBRWindowTitle) ; Inactive
    }
    
    EquipTroutLoadout() {
        ControlSend("{Numpad4}", , LBRWindowTitle) ; Inactive
    }
    
    EquipSwordGearLoadout() {
        ControlSend("{Numpad5}", , LBRWindowTitle) ; Inactive
    }
    
    EquipPyramidGearLoadout() {
        ControlSend("{Numpad6}", , LBRWindowTitle) ; Inactive
    }
    
    EquipQuarkGearLoadout() {
        ControlSend("{Numpad7}", , LBRWindowTitle)
    }
    
    EquipPilingGearLoadout() {
        ControlSend("{Numpad8}", , LBRWindowTitle) ; Inactive
    } */
}