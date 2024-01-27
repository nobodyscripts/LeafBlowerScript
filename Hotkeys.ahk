#Requires AutoHotkey v2.0

; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame
; Make sure to reload() (F2) if you change these while running
; https://www.autohotkey.com/docs/v2/KeyList.htm for a list of possible keys

OpenAreas() {
    ControlSend("{v}", , LBRWindowTitle)
}

OpenGemShop() {
    ControlSend("{.}", , LBRWindowTitle) ; Period/full stop
}

OpenTrades() {
    ControlSend("{y}", , LBRWindowTitle)
}

OpenPets() {
    ControlSend("{k}", , LBRWindowTitle)
}

OpenBank() {
    ControlSend("{n}", , LBRWindowTitle)
}

OpenBorbVentures() {
    ControlSend("{j}", , LBRWindowTitle)
}

OpenCards() {
    ControlSend("{i}", , LBRWindowTitle)
}

OpenAlchemy() {
    ControlSend("{o}", , LBRWindowTitle) ; Letter O
}

TriggerBlazingSkull() {
    ControlSend("{p}", , LBRWindowTitle)
}

TriggerGravity() {
    ControlSend("{]}", , LBRWindowTitle)
}

TriggerSuitcase() {
    ControlSend("{,}", , LBRWindowTitle) ; Comma
}

TriggerViolin() {
    ControlSend("{/}", , LBRWindowTitle)
}

TriggerWind() {
    ControlSend("{[}", , LBRWindowTitle)
}

TriggerWobblyWings() {
    ControlSend("{#}", , LBRWindowTitle)
}

RefreshTrades() {
    ControlSend("{Space}", , LBRWindowTitle)
}

EquipDefaultGearLoadout() {
    ControlSend("{Numpad1}", , LBRWindowTitle)
    ; Used as default after using other loadouts
    ; In my case this is my brew set
}

EquipTowerGearLoadout() {
    ControlSend("{Numpad3}", , LBRWindowTitle)
}

EquipQuarkGearLoadout() {
    ControlSend("{Numpad7}", , LBRWindowTitle)
}

ClosePanel() {
    ControlSend("{Esc}", , LBRWindowTitle)
}

/*
;These are not currently used so you can ignore the keybinds below

OpenTools() {
    ControlSend("{1}", , LBRWindowTitle) ; Inactive
}

EquipDamageGearLoadout() {
    ControlSend("{Numpad2}", , LBRWindowTitle) ; Inactive
}

EquipBlowingGearLoadout() {
    ControlSend("{Numpad4}", , LBRWindowTitle) ; Inactive
}

EquipSwordGearLoadout() {
    ControlSend("{Numpad5}", , LBRWindowTitle) ; Inactive
}

EquipPyramidGearLoadout() {
    ControlSend("{Numpad6}", , LBRWindowTitle) ; Inactive
}

EquipEightGearLoadout() {
    ControlSend("{Numpad8}", , LBRWindowTitle) ; Inactive
}*/