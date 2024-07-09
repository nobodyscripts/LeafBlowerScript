#Requires AutoHotkey v2.0

#Include ..\ExtLIbs\jsongo_AHKv2-main\src\jsongo.v2.ahk

/**
 * Update game settings to match scripts needs
 */
fGameSettings(*) {
    If (WinExist(LBRWindowTitle)) {
        MsgBox("CLOSE GAME BEFORE RUNNING GAME SETTINGS CHANGE SCRIPT`n"
            "Script aborted")
        cReload()
        Return
    }
    If (!settingsJson := ConvertGameSettingsToJson(ActiveGameSettingsPath)) {
        Return
    }
    settingsJson := ApplyScriptDefaultsOnGameSettings(settingsJson)
    stringJson := jsongo.Stringify(settingsJson)
    backupfile := StrReplace(ActiveGameSettingsPath, "options.dat",
        "options backup " FormatTime(FileGetTime(ActiveGameSettingsPath, "M"),
            "yyyy MM dd '-' HH'-'mm'-'ss") ".dat")

    If (SetGameSettings(ActiveGameSettingsPath, stringJson, backupfile)) {
        Log("Game Settings file updated at " ActiveGameSettingsPath "`r`n"
            "Backup file made: " backupfile)
        MsgBox("Game Settings file updated at " ActiveGameSettingsPath "`r`n"
            "Backup file made: " backupfile)
    } Else {
        Log("Error: Game Settings file not found at " ActiveGameSettingsPath "`r`n"
        )
        MsgBox("Error: Game Settings file not found at " ActiveGameSettingsPath
        )
    }
}

ConvertGameSettingsToJson(filename) {
    settingsfile := GetGameSettings(filename)
    If (!settingsfile) {
        Log("Error: No Game Settings found in " settingsfile)
        Return false
    }
    Return jsongo.Parse(settingsfile)
}

GetGameSettings(filename) {
    Try {
        If (FileExist(filename)) {
            Return FileRead(filename)
        } Else {
            Log("Error: Game Settings file not found at " filename "`r`n")
            MsgBox("Error: Game Settings file not found at " filename)
        }
    } Catch As exc {
        Log("Error: Error opening file " filename " - " exc.Message "`r`n")
        MsgBox("Error: Error opening file " filename " - " exc.Message)
    }
    Return false
}

SetGameSettings(filename, data, backupName) {
    Try {
        If (FileExist(filename)) {
            Try {
                If (!FileExist(backupName)) {
                    FileMove(filename, backupName)
                } Else {
                    Log(
                        "Warn: Backup already exists, overwriting main options.dat"
                    )
                    FileDelete(filename)
                }
            } Catch As exc {
                Log("Error: Error moving file " filename " to " backupName " - " exc
                    .Message "`r`n")
                MsgBox("Error: Error moving file " filename " to " backupName " - " exc
                    .Message)
            }
        }
        FileAppend(data, filename)
        Return true
    } Catch As exc {
        Log("Error: Error writing file " filename " - " exc.Message "`r`n")
        MsgBox("Error: Error writing file " filename " - " exc.Message)
    }
    Return false
}

ApplyScriptDefaultsOnGameSettings(jsonData) {
    KeyCodeArray := []
    ; if fullscreen was on, first thing we need to do is reset 'window' to a
    ; usable size otherwise we accidentally windowed borderless fullscreen
    If (jsonData['fullscreen']['value'] > 0) {
        jsonData['window_data']['value']['x'] := A_ScreenWidth / 4
        jsonData['window_data']['value']['y'] := A_ScreenHeight / 4
        jsonData['window_data']['value']['height'] := A_ScreenHeight / 2
        jsonData['window_data']['value']['width'] := A_ScreenWidth / 2
        MsgBox("Game window size being reset due to being in fullscreen.`r`n"
            "Adjust as needed.")
    }
    jsonData['afk_mode_lost_focus']['value'] := 0
    jsonData['alb_visible']['value'] := 80.0
    jsonData['alternative_font']['value'] := 1
    jsonData['borbventures_detailed_info']['value'] := 0
    jsonData['claw_auto_play']['value'] := 1
    jsonData['dark_dialog_bg']['value'] := 0
    jsonData['draw_trees']['value'] := 0
    jsonData['enable_aa']['value'] := 0
    jsonData['enable_notifications']['value'] := 0
    jsonData['font_size']['value'] := 0.0
    jsonData['fullscreen']['value'] := 0
    jsonData['menu_transparency']['value'] := 100.0
    jsonData['reset_scroll_position_after_prestige']['value'] := 1
    jsonData['show_death_dialogs']['value'] := 0
    jsonData['show_reward_dialogs']['value'] := 0
    jsonData['trades_detailed_info']['value'] := 0
    jsonData['disable_app_surface']['value'] := 1 ; This is alt rendering

    ; Need to check the following hotkeys don't conflict with other keybinds
    ; Also need to check if they are 27, so that users don't rebind ESC
    jsonData['hotkey_areas']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenAreas") + 0.0)
    jsonData['hotkey_artifact_blazing_skull']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerBlazingSkull") + 0.0)
    jsonData['hotkey_artifact_gold_suitcase']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerSuitcase") + 0.0)
    jsonData['hotkey_artifact_gravity_ball']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerGravity") + 0.0)
    jsonData['hotkey_artifact_seed_bag']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerSeeds") + 0.0)
    jsonData['hotkey_artifact_vital_violin']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerViolin") + 0.0)
    jsonData['hotkey_artifact_wind']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerWind") + 0.0)
    jsonData['hotkey_artifact_wings']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "TriggerWobblyWings") + 0.0)
    jsonData['hotkey_alchemy']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenAlchemy") + 0.0)
    jsonData['hotkey_banks']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenBank") + 0.0)
    jsonData['hotkey_borbventures']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenBorbVentures") + 0.0)
    jsonData['hotkey_cards']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenCards") + 0.0)
    jsonData['hotkey_crafting']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenCrafting") + 0.0)
    jsonData['hotkey_load_loadout_0']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "EquipDefaultGearLoadout") + 0.0)
    jsonData['hotkey_load_loadout_2']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "EquipTowerGearLoadout") + 0.0)
    jsonData['hotkey_mines']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenMining") + 0.0)
    jsonData['hotkey_pets']['value'] := CheckVK(GameKeys.GetHotkeyVK("OpenPets"
    ) + 0.0)
    jsonData['hotkey_prestige']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenGoldPortal") + 0.0)
    jsonData['hotkey_refresh_trades']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "RefreshTrades") + 0.0)
    jsonData['hotkey_shop_gems']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenGemShop") + 0.0)
    jsonData['hotkey_trading']['value'] := CheckVK(GameKeys.GetHotkeyVK(
        "OpenTrades") + 0.0)

    ; These keybinds are unused, so check they are not set to used values,
    ; preventing two keys using the same keybind
    notRequiredHotkeys := [
        ; direct use hotkeys
        'hotkey_afk_mode', 'hotkey_resource_draw_selection', ; Changes the stat display on the right
        'hotkey_transcend_card', 'hotkey_draw_hud', 'hotkey_house_constructor',
        ; features bar
        'hotkey_guide', 'hotkey_supporter_shop', 'hotkey_season_pass',
        'hotkey_unique_leaves', 'hotkey_artifacts', 'hotkey_items',
        'hotkey_materials', 'hotkey_relics', 'hotkey_scrolls', 'hotkey_chests',
        'hotkey_death_book', 'hotkey_skins', 'hotkey_achievements',
        'hotkey_milestones', 'hotkey_stats', 'hotkey_lore',
        'hotkey_daily_rewards', 'hotkey_challenges', 'hotkey_bot_control_panel',
        'hotkey_community_leaves', 'hotkey_account_gateway', 'hotkey_news',
        ; use artifacts
        'hotkey_artifact_vortex', 'hotkey_artifact_lantern',
        'hotkey_artifact_nature_rod', 'hotkey_artifact_fruit',
        'hotkey_artifact_orb', 'hotkey_artifact_leafscension_exploit',
        ; crafted sets
        'hotkey_load_craft_set_0', 'hotkey_load_craft_set_1',
        'hotkey_load_craft_set_2', 'hotkey_load_craft_set_3',
        'hotkey_load_craft_set_4', 'hotkey_load_craft_set_5',
        'hotkey_load_craft_set_6', 'hotkey_load_craft_set_7',
        ; loadouts
        'hotkey_load_loadout_1', 'hotkey_load_loadout_3',
        'hotkey_load_loadout_4', 'hotkey_load_loadout_5',
        'hotkey_load_loadout_6', 'hotkey_load_loadout_7',
        ; shops bar
        'hotkey_tool_shop', 'hotkey_leaf_shop', 'hotkey_gold_shop',
        'hotkey_platinum_shop', 'hotkey_bismuth_shop', 'hotkey_cosmic_shop',
        'hotkey_void_shop', 'hotkey_exotic_shop', 'hotkey_celestial_shop',
        'hotkey_mythical_shop', 'hotkey_lava_shop', 'hotkey_ice_shop',
        'hotkey_obsidian_shop', 'hotkey_silicon_shop', 'hotkey_benitoite_shop',
        'hotkey_moonstone_shop', 'hotkey_sand_shop', 'hotkey_ancient_shop',
        'hotkey_sacred_shop', 'hotkey_biotite_shop', 'hotkey_malachite_shop',
        'hotkey_hematite_shop', 'hotkey_plasma_shop', 'hotkey_coal_shop',
        'hotkey_energy_electrical_shop', 'hotkey_gem_leaves_shop',
        'hotkey_coins_shop', 'hotkey_blc_shop', 'hotkey_mlc_shop',
        'hotkey_silver_token_shop', 'hotkey_gold_token_shop',
        ; science flasks
        'hotkey_red_science', 'hotkey_green_science', 'hotkey_blue_science',
        'hotkey_magenta_science', 'hotkey_orange_science',
        'hotkey_black_science', 'hotkey_strange_science',
        ; Portals
        'hotkey_blc', 'hotkey_mlc',
        ; mixture
        'hotkey_converters', 'hotkey_printers', 'hotkey_farming',
        'hotkey_mulch_shop', 'hotkey_leafscension', 'hotkey_soul_shop',
        'hotkey_soul_forge', 'hotkey_dice', 'hotkey_quarks',
        'hotkey_event_shop']
    aInUse := [
        ; Need closepanel in this to avoid user binding to Esc
        GameKeys.GetHotkeyVK("ClosePanel") + 0.0, GameKeys.GetHotkeyVK(
            "OpenAreas") + 0.0, GameKeys.GetHotkeyVK("TriggerBlazingSkull") +
        0.0, GameKeys.GetHotkeyVK("TriggerSuitcase") + 0.0, GameKeys.GetHotkeyVK(
            "TriggerGravity") + 0.0, GameKeys.GetHotkeyVK("TriggerSeeds") + 0.0,
        GameKeys.GetHotkeyVK("TriggerViolin") + 0.0, GameKeys.GetHotkeyVK(
            "TriggerWind") + 0.0, GameKeys.GetHotkeyVK("TriggerWobblyWings") +
        0.0, GameKeys.GetHotkeyVK("OpenAlchemy") + 0.0, GameKeys.GetHotkeyVK(
            "OpenBank") + 0.0, GameKeys.GetHotkeyVK("OpenBorbVentures") + 0.0,
        GameKeys.GetHotkeyVK("OpenCards") + 0.0, GameKeys.GetHotkeyVK(
            "OpenCrafting") + 0.0, GameKeys.GetHotkeyVK(
                "EquipDefaultGearLoadout") + 0.0, GameKeys.GetHotkeyVK(
                    "EquipTowerGearLoadout") + 0.0, GameKeys.GetHotkeyVK(
                        "OpenMining") + 0.0, GameKeys.GetHotkeyVK("OpenPets") +
        0.0, GameKeys.GetHotkeyVK("OpenGoldPortal") + 0.0, GameKeys.GetHotkeyVK(
            "RefreshTrades") + 0.0, GameKeys.GetHotkeyVK("OpenGemShop") + 0.0,
        GameKeys.GetHotkeyVK("OpenTrades") + 0.0]

    VerboseLog("Script keys set to: " ArrToCommaDelimStr(aInUse))
    For (key in notRequiredHotkeys) {
        jsonData[key]['value'] := ResetIncorrectHotkey(jsonData[key]['value'],
            aInUse)
    }
    Return jsonData
}

ResetIncorrectHotkey(var, aInUse) {
    If (var = -1.0) {
        Return -1.0
    }
    If (var != "") {
        VerboseLog("Checking key " var ": " GetKeyName(Format("vk{:X}", var)))
    }
    For (key in aInUse) {
        If (var = key) {
            If (var != "") {
                DebugLog("Had to reset keybind " var ": " GetKeyName(Format(
                    "vk{:X}", var)))
            }
            var := -1.0
        }
    }
    Return var
}

CheckVK(var) {
    If (var = 27.0 || var = 27) {
        Return -1.0
    }
    Return var + 0.0
}