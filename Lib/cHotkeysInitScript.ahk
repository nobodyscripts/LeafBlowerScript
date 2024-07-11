#Requires AutoHotkey v2.0

#Include cHotkeys.ahk

; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame
; Make sure to reload() (F2) if you change these while running
; https://www.autohotkey.com/docs/v2/KeyList.htm for a list of possible keys

/** @type {cHotkeys} */
Global Scriptkeys := cHotkeys()

Scriptkeys.IsScriptHotkeys := true

Scriptkeys.sFilename := A_ScriptDir "\ScriptHotkeys.ini"

Scriptkeys.Hotkeys["Exit"] := cHotkey("Exit", Map("EN-US", "F1", "EN-GB", "F1",
    "Other", "F1"), "Default")

Scriptkeys.Hotkeys["Reload"] := cHotkey("Reload", Map("EN-US", "F2", "EN-GB",
    "F2", "Other", "F2"), "Default")

Scriptkeys.Hotkeys["Cards"] := cHotkey("Cards", Map("EN-US", "F3", "EN-GB",
    "F3", "Other", "F3"), "Default")

Scriptkeys.Hotkeys["GemFarm"] := cHotkey("GemFarm", Map("EN-US", "F4", "EN-GB",
    "F4", "Other", "F4"), "Default")

Scriptkeys.Hotkeys["TowerBoost"] := cHotkey("TowerBoost", Map("EN-US", "F5",
    "EN-GB", "F5", "Other", "F5"), "Default")

Scriptkeys.Hotkeys["Borbv"] := cHotkey("Borbv", Map("EN-US", "F6", "EN-GB",
    "F6", "Other", "F6"), "Default")

Scriptkeys.Hotkeys["Claw"] := cHotkey("Claw", Map("EN-US", "F7", "EN-GB", "F7",
    "Other", "F7"), "Default")

Scriptkeys.Hotkeys["GFSS"] := cHotkey("GFSS", Map("EN-US", "F8", "EN-GB", "F8",
    "Other", "F8"), "Default")

Scriptkeys.Hotkeys["BossFarm"] := cHotkey("BossFarm", Map("EN-US", "F9",
    "EN-GB", "F9", "Other", "F9"), "Default")

Scriptkeys.Hotkeys["NatureBoss"] := cHotkey("NatureBoss", Map("EN-US", "F10",
    "EN-GB", "F10", "Other", "F10"), "Default")

Scriptkeys.Hotkeys["AutoClicker"] := cHotkey("AutoClicker", Map("EN-US", "F11",
    "EN-GB", "F11", "Other", "F11"), "Default")

Scriptkeys.Hotkeys["GameResize"] := cHotkey("GameResize", Map("EN-US", "F12",
    "EN-GB", "F12", "Other", "F12"), "Default")

Scriptkeys.Hotkeys["MineMaintain"] := cHotkey("MineMaintain", Map("EN-US",
    "Insert", "EN-GB", "Insert", "Other", "Insert"), "Default")

Scriptkeys.Hotkeys["HyacinthFarm"] := cHotkey("HyacinthFarm", Map("EN-US",
    "Home", "EN-GB", "Home", "Other", "Home"), "Default")

Scriptkeys.Hotkeys["Bank"] := cHotkey("Bank", Map("EN-US", "PgUp", "EN-GB",
    "PgUp", "Other", "PgUp"), "Default")

Scriptkeys.Hotkeys["CursedCheese"] := cHotkey("CursedCheese", Map("EN-US",
    "Del", "EN-GB", "Del", "Other", "Del"), "Default")

Scriptkeys.Hotkeys["TowerPassive"] := cHotkey("TowerPassive", Map("EN-US",
    "End", "EN-GB", "End", "Other", "End"), "Default")

Scriptkeys.Hotkeys["Leafton"] := cHotkey("Leafton", Map("EN-US", "PgDn",
    "EN-GB", "PgDn", "Other", "PgDn"), "Default")

If (IsSet(DisableScriptKeysInit)) {
    Scriptkeys.initHotkeys(IsSecondary)
}