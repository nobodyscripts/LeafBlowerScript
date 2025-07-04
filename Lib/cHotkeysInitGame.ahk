#Requires AutoHotkey v2.0

#Include cHotkeysGames.ahk

; ------------------- Ingame Hotkeys -------------------
; Loads UserHotkeys.ini values for the rest of the script to use

/** @type {cHotkeysGames} */
Global GameKeys := cHotkeysGames()

GameKeys.Hotkeys["OpenAreas"] := cHotkey("OpenAreas", Map("EN-US", "v", "EN-GB",
    "v", "Other", "v"), "Shops")

GameKeys.Hotkeys["OpenGemShop"] := cHotkey("OpenGemShop", Map("EN-US", ".",
    "EN-GB", ".", "Other", "."), "Shops")

GameKeys.Hotkeys["OpenTrades"] := cHotkey("OpenTrades", Map("EN-US", "y",
    "EN-GB", "y", "Other", "y"), "Shops")

GameKeys.Hotkeys["OpenPets"] := cHotkey("OpenPets", Map("EN-US", "k", "EN-GB",
    "k", "Other", "k"), "Shops")

GameKeys.Hotkeys["OpenBank"] := cHotkey("OpenBank", Map("EN-US", "n", "EN-GB",
    "n", "Other", "n"), "Shops")

GameKeys.Hotkeys["OpenBorbVentures"] := cHotkey("OpenBorbVentures", Map("EN-US",
    "j", "EN-GB", "j", "Other", "j"), "Shops")

GameKeys.Hotkeys["OpenCards"] := cHotkey("OpenCards", Map("EN-US", "i", "EN-GB",
    "i", "Other", "i"), "Shops")

GameKeys.Hotkeys["OpenAlchemy"] := cHotkey("OpenAlchemy", Map("EN-US", "o",
    "EN-GB", "o", "Other", "o"), "Shops")

GameKeys.Hotkeys["OpenCrafting"] := cHotkey("OpenCrafting", Map("EN-US", "m",
    "EN-GB", "m", "Other", "m"), "Shops")

GameKeys.Hotkeys["OpenMining"] := cHotkey("OpenMining", Map("EN-US", "l",
    "EN-GB", "l", "Other", "l"), "Shops")

GameKeys.Hotkeys["OpenBlc"] := cHotkey("OpenBlc", Map("EN-US", "s",
    "EN-GB", "s", "Other", "s"), "Shops")

GameKeys.Hotkeys["OpenMlc"] := cHotkey("OpenMlc", Map("EN-US", "d",
    "EN-GB", "d", "Other", "d"), "Shops")

GameKeys.Hotkeys["OpenUlc"] := cHotkey("OpenUlc", Map("EN-US", "f",
    "EN-GB", "f", "Other", "f"), "Shops")

GameKeys.Hotkeys["OpenGoldPortal"] := cHotkey("OpenGoldPortal", Map("EN-US",
    "z", "EN-GB", "z", "Other", "z"), "Prestige")

GameKeys.Hotkeys["OpenRedPortal"] := cHotkey("OpenRedPortal", Map("EN-US",
    "x", "EN-GB", "x", "Other", "x"), "Prestige")

GameKeys.Hotkeys["OpenGreenPortal"] := cHotkey("OpenGreenPortal", Map("EN-US",
    "c", "EN-GB", "c", "Other", "c"), "Prestige")

GameKeys.Hotkeys["OpenBluePortal"] := cHotkey("OpenBluePortal", Map("EN-US",
    "g", "EN-GB", "g", "Other", "g"), "Prestige")

GameKeys.Hotkeys["TriggerBlazingSkull"] := cHotkey("TriggerBlazingSkull", Map(
    "EN-US", "p", "EN-GB", "p", "Other", "p"), "Artifacts")

GameKeys.Hotkeys["TriggerGravity"] := cHotkey("TriggerGravity", Map("EN-US",
    "]", "EN-GB", "]", "Other", "]"), "Artifacts")

GameKeys.Hotkeys["TriggerSuitcase"] := cHotkey("TriggerSuitcase", Map("EN-US",
    ",", "EN-GB", ",", "Other", ","), "Artifacts")

GameKeys.Hotkeys["TriggerViolin"] := cHotkey("TriggerViolin", Map("EN-US", "/",
    "EN-GB", "/", "Other", "/"), "Artifacts")

GameKeys.Hotkeys["TriggerWind"] := cHotkey("TriggerWind", Map("EN-US", "[",
    "EN-GB", "[", "Other", "["), "Artifacts")

GameKeys.Hotkeys["TriggerWobblyWings"] := cHotkey("TriggerWobblyWings", Map(
    "EN-US", "\", "EN-GB", "#", "Other", "#"), "Artifacts")

GameKeys.Hotkeys["TriggerSeeds"] := cHotkey("TriggerSeeds", Map("EN-US", "h",
    "EN-GB", "h", "Other", "h"), "Artifacts")

GameKeys.Hotkeys["RefreshTrades"] := cHotkey("RefreshTrades", Map("EN-US",
    "Space", "EN-GB", "Space", "Other", "Space"), "Feature")

GameKeys.Hotkeys["ClosePanel"] := cHotkey("ClosePanel", Map("EN-US", "Esc",
    "EN-GB", "Esc", "Other", "Esc"), "Feature")

GameKeys.Hotkeys["OpenConverters"] := cHotkey("OpenConverters", Map("EN-US",
    "b", "EN-GB", "b", "Other", "b"), "Feature")

GameKeys.Hotkeys["EquipDefaultGearLoadout"] := cHotkey(
    "EquipDefaultGearLoadout", Map("EN-US", "Numpad1", "EN-GB", "Numpad1",
        "Other", "Numpad1"), "Loadouts")

GameKeys.Hotkeys["EquipSlapGearLoadout"] := cHotkey(
    "EquipSlapGearLoadout", Map("EN-US", "Numpad2", "EN-GB", "Numpad2",
        "Other", "Numpad2"), "Loadouts")

GameKeys.Hotkeys["EquipTowerGearLoadout"] := cHotkey("EquipTowerGearLoadout",
    Map("EN-US", "Numpad3", "EN-GB", "Numpad3", "Other", "Numpad3"), "Loadouts"
)

GameKeys.Hotkeys["EquipSwordGearLoadout"] := cHotkey(
    "EquipSwordGearLoadout", Map("EN-US", "Numpad4", "EN-GB", "Numpad4",
        "Other", "Numpad4"), "Loadouts")

GameKeys.Hotkeys["EquipElectricGearLoadout"] := cHotkey(
    "EquipElectricGearLoadout", Map("EN-US", "Numpad5", "EN-GB", "Numpad5",
        "Other", "Numpad5"), "Loadouts")
