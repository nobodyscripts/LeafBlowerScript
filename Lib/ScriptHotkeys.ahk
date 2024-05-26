#Requires AutoHotkey v2.0

#include HotkeysClass.ahk


; ------------------- Keybinds -------------------

; Customise these to match your keybinds or change to these ingame
; Make sure to reload() (F2) if you change these while running
; https://www.autohotkey.com/docs/v2/KeyList.htm for a list of possible keys

global Scriptkeys := cHotkeys()

ScriptKeys.sFilename := A_ScriptDir "\ScriptHotkeys.ini"

Scriptkeys.Hotkeys["Exit"] := singleHotkey().Create(
    "Exit",
    Map(
        "EN-US", "F1",
        "EN-GB", "F1",
        "Other", "F1"
    ),
    "Default")

Scriptkeys.Hotkeys["Reload"] := singleHotkey().Create(
    "Reload",
    Map(
        "EN-US", "F2",
        "EN-GB", "F2",
        "Other", "F2"
    ),
    "Default")

Scriptkeys.Hotkeys["Cards"] := singleHotkey().Create(
    "Cards",
    Map(
        "EN-US", "F3",
        "EN-GB", "F3",
        "Other", "F3"
    ),
    "Default")

Scriptkeys.Hotkeys["GemFarm"] := singleHotkey().Create(
    "GemFarm",
    Map(
        "EN-US", "F4",
        "EN-GB", "F4",
        "Other", "F4"
    ),
    "Default")

Scriptkeys.Hotkeys["TowerBoost"] := singleHotkey().Create(
    "TowerBoost",
    Map(
        "EN-US", "F5",
        "EN-GB", "F5",
        "Other", "F5"
    ),
    "Default")

Scriptkeys.Hotkeys["Borbv"] := singleHotkey().Create(
    "Borbv",
    Map(
        "EN-US", "F6",
        "EN-GB", "F6",
        "Other", "F6"
    ),
    "Default")

Scriptkeys.Hotkeys["Claw"] := singleHotkey().Create(
    "Claw",
    Map(
        "EN-US", "F7",
        "EN-GB", "F7",
        "Other", "F7"
    ),
    "Default")

Scriptkeys.Hotkeys["GFSS"] := singleHotkey().Create(
    "GFSS",
    Map(
        "EN-US", "F8",
        "EN-GB", "F8",
        "Other", "F8"
    ),
    "Default")

Scriptkeys.Hotkeys["BossFarm"] := singleHotkey().Create(
    "BossFarm",
    Map(
        "EN-US", "F9",
        "EN-GB", "F9",
        "Other", "F9"
    ),
    "Default")

Scriptkeys.Hotkeys["NatureBoss"] := singleHotkey().Create(
    "NatureBoss",
    Map(
        "EN-US", "F10",
        "EN-GB", "F10",
        "Other", "F10"
    ),
    "Default")

Scriptkeys.Hotkeys["AutoClicker"] := singleHotkey().Create(
    "AutoClicker",
    Map(
        "EN-US", "F11",
        "EN-GB", "F11",
        "Other", "F11"
    ),
    "Default")

Scriptkeys.Hotkeys["GameResize"] := singleHotkey().Create(
    "GameResize",
    Map(
        "EN-US", "F12",
        "EN-GB", "F12",
        "Other", "F12"
    ),
    "Default")

Scriptkeys.Hotkeys["MineMaintain"] := singleHotkey().Create(
    "MineMaintain",
    Map(
        "EN-US", "Insert",
        "EN-GB", "Insert",
        "Other", "Insert"
    ),
    "Default")

Scriptkeys.Hotkeys["HyacinthFarm"] := singleHotkey().Create(
    "HyacinthFarm",
    Map(
        "EN-US", "Home",
        "EN-GB", "Home",
        "Other", "Home"
    ),
    "Default")

Scriptkeys.Hotkeys["Bank"] := singleHotkey().Create(
    "Bank",
    Map(
        "EN-US", "PgUp",
        "EN-GB", "PgUp",
        "Other", "PgUp"
    ),
    "Default")

Scriptkeys.Hotkeys["CursedCheese"] := singleHotkey().Create(
    "CursedCheese",
    Map(
        "EN-US", "Del",
        "EN-GB", "Del",
        "Other", "Del"
    ),
    "Default")

Scriptkeys.Hotkeys["TowerPassive"] := singleHotkey().Create(
    "TowerPassive",
    Map(
        "EN-US", "End",
        "EN-GB", "End",
        "Other", "End"
    ),
    "Default")

Scriptkeys.Hotkeys["Leafton"] := singleHotkey().Create(
    "Leafton",
    Map(
        "EN-US", "PgDn",
        "EN-GB", "PgDn",
        "Other", "PgDn"
    ),
    "Default")

Scriptkeys.initHotkeys(IsSecondary)
