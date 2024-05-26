#Requires AutoHotkey v2.0

#include HotkeysClass.ahk

; ------------------- Ingame Hotkeys -------------------
; Loads UserHotkeys.ini values for the rest of the script to use

global LBRWindowTitle
global GameKeys := cHotkeys()

GameKeys.Hotkeys["OpenAreas"] := singleHotkey().Create(
    "OpenAreas",
    Map(
        "EN-US", "v",
        "EN-GB", "v",
        "Other", "v"
    ),
    "Shops")

GameKeys.Hotkeys["OpenGemShop"] := singleHotkey().Create(
    "OpenGemShop",
    Map(
        "EN-US", ".",
        "EN-GB", ".",
        "Other", "."
    ),
    "Shops")

GameKeys.Hotkeys["OpenTrades"] := singleHotkey().Create(
    "OpenTrades",
    Map(
        "EN-US", "y",
        "EN-GB", "y",
        "Other", "y"
    ),
    "Shops")

GameKeys.Hotkeys["OpenPets"] := singleHotkey().Create(
    "OpenPets",
    Map(
        "EN-US", "k",
        "EN-GB", "k",
        "Other", "k"
    ),
    "Shops")

GameKeys.Hotkeys["OpenBank"] := singleHotkey().Create(
    "OpenBank",
    Map(
        "EN-US", "n",
        "EN-GB", "n",
        "Other", "n"
    ),
    "Shops")

GameKeys.Hotkeys["OpenBorbVentures"] := singleHotkey().Create(
    "OpenBorbVentures",
    Map(
        "EN-US", "j",
        "EN-GB", "j",
        "Other", "j"
    ),
    "Shops")

GameKeys.Hotkeys["OpenCards"] := singleHotkey().Create(
    "OpenCards",
    Map(
        "EN-US", "i",
        "EN-GB", "i",
        "Other", "i"
    ),
    "Shops")

GameKeys.Hotkeys["OpenAlchemy"] := singleHotkey().Create(
    "OpenAlchemy",
    Map(
        "EN-US", "o",
        "EN-GB", "o",
        "Other", "o"
    ),
    "Shops")

GameKeys.Hotkeys["OpenCrafting"] := singleHotkey().Create(
    "OpenCrafting",
    Map(
        "EN-US", "m",
        "EN-GB", "m",
        "Other", "m"
    ),
    "Shops")

GameKeys.Hotkeys["OpenMining"] := singleHotkey().Create(
    "OpenMining",
    Map(
        "EN-US", "l",
        "EN-GB", "l",
        "Other", "l"
    ),
    "Shops")

GameKeys.Hotkeys["OpenGoldPortal"] := singleHotkey().Create(
    "OpenGoldPortal",
    Map(
        "EN-US", "x",
        "EN-GB", "x",
        "Other", "x"
    ),
    "Prestige")

GameKeys.Hotkeys["TriggerBlazingSkull"] := singleHotkey().Create(
    "TriggerBlazingSkull",
    Map(
        "EN-US", "p",
        "EN-GB", "p",
        "Other", "p"
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerGravity"] := singleHotkey().Create(
    "TriggerGravity",
    Map(
        "EN-US", "]",
        "EN-GB", "]",
        "Other", "]"
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerSuitcase"] := singleHotkey().Create(
    "TriggerSuitcase",
    Map(
        "EN-US", ",",
        "EN-GB", ",",
        "Other", ","
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerViolin"] := singleHotkey().Create(
    "TriggerViolin",
    Map(
        "EN-US", "/",
        "EN-GB", "/",
        "Other", "/"
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerWind"] := singleHotkey().Create(
    "TriggerWind",
    Map(
        "EN-US", "[",
        "EN-GB", "[",
        "Other", "["
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerWobblyWings"] := singleHotkey().Create(
    "TriggerWobblyWings",
    Map(
        "EN-US", "\",
        "EN-GB", "#",
        "Other", "#"
    ),
    "Artifacts")

GameKeys.Hotkeys["TriggerSeeds"] := singleHotkey().Create(
    "TriggerSeeds",
    Map(
        "EN-US", "h",
        "EN-GB", "h",
        "Other", "h"
    ),
    "Artifacts")

GameKeys.Hotkeys["RefreshTrades"] := singleHotkey().Create(
    "RefreshTrades",
    Map(
        "EN-US", "Space",
        "EN-GB", "Space",
        "Other", "Space"
    ),
    "Feature")

GameKeys.Hotkeys["ClosePanel"] := singleHotkey().Create(
    "ClosePanel",
    Map(
        "EN-US", "Esc",
        "EN-GB", "Esc",
        "Other", "Esc"
    ),
    "Feature")

GameKeys.Hotkeys["EquipDefaultGearLoadout"] := singleHotkey().Create(
    "EquipDefaultGearLoadout",
    Map(
        "EN-US", "Numpad1",
        "EN-GB", "Numpad1",
        "Other", "Numpad1"
    ),
    "Loadouts")

GameKeys.Hotkeys["EquipTowerGearLoadout"] := singleHotkey().Create(
    "EquipTowerGearLoadout",
    Map(
        "EN-US", "Numpad3",
        "EN-GB", "Numpad3",
        "Other", "Numpad3"
    ),
    "Loadouts")

GameKeys.initHotkeys(IsSecondary)

OpenAreas() {
    ControlSend("{" GameKeys.GetHotkey("OpenAreas") "}", , LBRWindowTitle)
}

OpenGemShop() {
    ControlSend("{" GameKeys.GetHotkey("OpenGemShop") "}", , LBRWindowTitle)
}

OpenTrades() {
    ControlSend("{" GameKeys.GetHotkey("OpenTrades") "}", , LBRWindowTitle)
}

OpenPets() {
    ControlSend("{" GameKeys.GetHotkey("OpenPets") "}", , LBRWindowTitle)
}

OpenBank() {
    ControlSend("{" GameKeys.GetHotkey("OpenBank") "}", , LBRWindowTitle)
}

OpenBorbVentures() {
    ControlSend("{" GameKeys.GetHotkey("OpenBorbVentures") "}", , LBRWindowTitle)
}

OpenCards() {
    ControlSend("{" GameKeys.GetHotkey("OpenCards") "}", , LBRWindowTitle)
}

OpenAlchemy() {
    ControlSend("{" GameKeys.GetHotkey("OpenAlchemy") "}", , LBRWindowTitle)
}

OpenCrafting() {
    ControlSend("{" GameKeys.GetHotkey("OpenCrafting") "}", , LBRWindowTitle)
}

OpenMining() {
    ControlSend("{" GameKeys.GetHotkey("OpenMining") "}", , LBRWindowTitle)
}

OpenGoldPortal() {
    ControlSend("{" GameKeys.GetHotkey("OpenGoldPortal") "}", , LBRWindowTitle)
}

TriggerBlazingSkull() {
    ControlSend("{" GameKeys.GetHotkey("TriggerBlazingSkull") "}", , LBRWindowTitle)
}

TriggerGravity() {
    ControlSend("{" GameKeys.GetHotkey("TriggerGravity") "}", , LBRWindowTitle)
}

TriggerSuitcase() {
    ControlSend("{" GameKeys.GetHotkey("TriggerSuitcase") "}", , LBRWindowTitle)
}

TriggerViolin() {
    ControlSend("{" GameKeys.GetHotkey("TriggerViolin") "}", , LBRWindowTitle)
}

TriggerWind() {
    ControlSend("{" GameKeys.GetHotkey("TriggerWind") "}", , LBRWindowTitle)
}

TriggerWobblyWings() {
    ControlSend("{" GameKeys.GetHotkey("TriggerWobblyWings") "}", , LBRWindowTitle)
}

TriggerSeeds() {
    ControlSend("{" GameKeys.GetHotkey("TriggerSeeds") "}", , LBRWindowTitle)
}

RefreshTrades() {
    ControlSend("{" GameKeys.GetHotkey("RefreshTrades") "}", , LBRWindowTitle)
}

ClosePanel() {
    ControlSend("{" GameKeys.GetHotkey("ClosePanel") "}", , LBRWindowTitle)
}

EquipDefaultGearLoadout() {
    ControlSend("{" GameKeys.GetHotkey("EquipDefaultGearLoadout") "}", , LBRWindowTitle)
}

EquipTowerGearLoadout() {
    ControlSend("{" GameKeys.GetHotkey("EquipTowerGearLoadout") "}", , LBRWindowTitle)
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