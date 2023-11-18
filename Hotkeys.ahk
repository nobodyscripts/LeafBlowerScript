#Requires AutoHotkey v2.0

; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame
; Make sure to reload (F2) if you change these while running
; https://www.autohotkey.com/docs/v2/KeyList.htm for a list of possible keys

OpenAreas() {
    ControlSend "{v}", , "Leaf Blower Revolution"
}

OpenGemShop() {
    ControlSend "{.}", , "Leaf Blower Revolution" ; Period/full stop
}

OpenTrades() {
    ControlSend "{y}", , "Leaf Blower Revolution"
}

OpenPets() {
    ControlSend "{k}", , "Leaf Blower Revolution"
}

OpenBorbVentures() {
    ControlSend "{j}", , "Leaf Blower Revolution"
}

OpenCards() {
    ControlSend "{i}", , "Leaf Blower Revolution"
}

OpenAlchemy() {
    ControlSend "{o}", , "Leaf Blower Revolution" ; Letter O
}

TriggerSuitcase() {
    ControlSend "{,}", , "Leaf Blower Revolution" ; Comma
}

TriggerViolin() {
    ControlSend "{/}", , "Leaf Blower Revolution"
}

RefreshTrades() {
    ControlSend "{Space}", , "Leaf Blower Revolution"
}

EquipDefaultGearLoadout() {
    ControlSend "{Numpad1}", , "Leaf Blower Revolution"
    ; Used as default after using other loadouts
    ; In my case this is my brew set
}

EquipTowerGearLoadout() {
    ControlSend "{Numpad3}", , "Leaf Blower Revolution"
}

ClosePanel() {
    ControlSend "{Esc}", , "Leaf Blower Revolution"
}
/* These are not currently used so you can ignore the keybinds below


OpenTools() {
    ControlSend "{1}", , "Leaf Blower Revolution" ; Inactive
}

TriggerWind() {
    ControlSend "{[}", , "Leaf Blower Revolution" ; Inactive
}

TriggerGravity() {
    ControlSend "{]}", , "Leaf Blower Revolution" ; Inactive
}

TriggerWobblyWings() {
    ControlSend "{#}", , "Leaf Blower Revolution" ; Inactive
}

EquipDamageGearLoadout() {
    ControlSend "{Numpad2}", , "Leaf Blower Revolution" ; Inactive
}

EquipBlowingGearLoadout() {
    ControlSend "{Numpad4}", , "Leaf Blower Revolution" ; Inactive
}

EquipSwordGearLoadout() {
    ControlSend "{Numpad5}", , "Leaf Blower Revolution" ; Inactive
}

EquipPyramidGearLoadout() {
    ControlSend "{Numpad6}", , "Leaf Blower Revolution" ; Inactive
}

EquipTargetCenterGearLoadout() {
    ControlSend "{Numpad7}", , "Leaf Blower Revolution" ; Inactive
}

EquipEightGearLoadout() {
    ControlSend "{Numpad8}", , "Leaf Blower Revolution" ; Inactive
}
*/