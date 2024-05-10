#Requires AutoHotkey v2.0

#Include ..\ExtLIbs\jsongo_AHKv2-main\src\jsongo.v2.ahk

/**
 * Update game settings to match scripts needs
 */
fGameSettings(*) {
    if (WinExist(LBRWindowTitle)) {
        MsgBox("CLOSE GAME BEFORE RUNNING GAME SETTINGS CHANGE SCRIPT`n"
            "Script aborted")
        cReload()
        return
    }
    if (!settingsJson := ConvertGameSettingsToJson(ActiveGameSettingsPath)) {
        return
    }
    settingsJson := ApplyScriptDefaultsOnGameSettings(settingsJson)
    stringJson := jsongo.Stringify(settingsJson)
    backupfile := StrReplace(ActiveGameSettingsPath,
        "options.dat",
        "options backup "
        FormatTime(FileGetTime(ActiveGameSettingsPath, "M"),
            "yyyy MM dd '-' HH'-'mm'-'ss") ".dat")

    if (SetGameSettings(ActiveGameSettingsPath, stringJson, backupfile)) {
        Log("Game Settings file updated at " ActiveGameSettingsPath "`r`n"
            "Backup file made: " backupfile)
        MsgBox("Game Settings file updated at " ActiveGameSettingsPath "`r`n"
            "Backup file made: " backupfile)
    } else {
        Log("Error: Game Settings file not found at " ActiveGameSettingsPath "`r`n")
        MsgBox("Error: Game Settings file not found at " ActiveGameSettingsPath)
    }
}

ConvertGameSettingsToJson(filename) {
    settingsfile := GetGameSettings(filename)
    if (!settingsfile) {
        Log("Error: No Game Settings found in " settingsfile)
        return false
    }
    return jsongo.Parse(settingsfile)
}

GetGameSettings(filename) {
    try {
        if (FileExist(filename)) {
            return FileRead(filename)
        } else {
            Log("Error: Game Settings file not found at " filename "`r`n")
            MsgBox("Error: Game Settings file not found at " filename)
        }
    } catch as exc {
        Log("Error: Error opening file " filename " - " exc.Message "`r`n")
        MsgBox("Error: Error opening file " filename " - " exc.Message)
    }
    return false
}

SetGameSettings(filename, data, backupName) {
    try {
        if (FileExist(filename)) {
            try {
                if (!FileExist(backupName)) {
                    FileMove(filename, backupName)
                } else {
                    Log("Warn: Backup already exists, overwriting main options.dat")
                    FileDelete(filename)
                }
            } catch as exc {
                Log("Error: Error moving file " filename " to " backupName " - " exc.Message "`r`n")
                MsgBox("Error: Error moving file " filename " to " backupName " - " exc.Message)
            }
        }
        FileAppend(data, filename)
        return true
    } catch as exc {
        Log("Error: Error writing file " filename " - " exc.Message "`r`n")
        MsgBox("Error: Error writing file " filename " - " exc.Message)
    }
    return false
}

ApplyScriptDefaultsOnGameSettings(jsonData) {
    ; if fullscreen was on, first thing we need to do is reset 'window' to a
    ; usable size otherwise we accidentally windowed borderless fullscreen
    if (jsonData['fullscreen']['value'] > 0) {
        jsonData['window_data']['value']['x'] := A_ScreenWidth / 4
        jsonData['window_data']['value']['y'] := A_ScreenHeight / 4
        jsonData['window_data']['value']['height'] := A_ScreenHeight / 2
        jsonData['window_data']['value']['width'] := A_ScreenWidth / 2
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
    jsonData['hotkey_areas']['value'] := 86.0
    jsonData['hotkey_artifact_blazing_skull']['value'] := 80.0
    jsonData['hotkey_artifact_gold_suitcase']['value'] := 188.0
    jsonData['hotkey_artifact_gravity_ball']['value'] := 221.0
    jsonData['hotkey_artifact_seed_bag']['value'] := 72.0
    jsonData['hotkey_artifact_vital_violin']['value'] := 191.0
    jsonData['hotkey_artifact_wind']['value'] := 219.0
    jsonData['hotkey_artifact_wings']['value'] := 222.0
    jsonData['hotkey_alchemy']['value'] := 79.0
    jsonData['hotkey_banks']['value'] := 78.0
    jsonData['hotkey_borbventures']['value'] := 74.0
    jsonData['hotkey_cards']['value'] := 73.0
    jsonData['hotkey_crafting']['value'] := 77.0
    jsonData['hotkey_load_loadout_0']['value'] := 97.0
    jsonData['hotkey_load_loadout_2']['value'] := 99.0
    jsonData['hotkey_mines']['value'] := 76.0
    jsonData['hotkey_pets']['value'] := 75.0
    jsonData['hotkey_prestige']['value'] := 88.0
    jsonData['hotkey_refresh_trades']['value'] := 32.0
    jsonData['hotkey_shop_gems']['value'] := 190.0
    jsonData['hotkey_trading']['value'] := 89.0

    ; These keybinds are unused, so check they are not set to used values,
    ; preventing two keys using the same keybind
    gamesettingshotkeys := [
        ; direct use hotkeys
        'hotkey_afk_mode',
        'hotkey_resource_draw_selection', ; Changes the stat display on the right
        'hotkey_transcend_card',
        'hotkey_draw_hud',
        'hotkey_house_constructor',
        ; features bar
        'hotkey_guide',
        'hotkey_supporter_shop',
        'hotkey_season_pass',
        'hotkey_unique_leaves',
        'hotkey_artifacts',
        'hotkey_items',
        'hotkey_materials',
        'hotkey_relics',
        'hotkey_scrolls',
        'hotkey_chests',
        'hotkey_death_book',
        'hotkey_skins',
        'hotkey_achievements',
        'hotkey_milestones',
        'hotkey_stats',
        'hotkey_lore',
        'hotkey_daily_rewards',
        'hotkey_challenges',
        'hotkey_bot_control_panel',
        'hotkey_community_leaves',
        'hotkey_account_gateway',
        'hotkey_news',
        ; use artifacts
        'hotkey_artifact_vortex',
        'hotkey_artifact_lantern',
        'hotkey_artifact_nature_rod',
        'hotkey_artifact_fruit',
        'hotkey_artifact_orb',
        'hotkey_artifact_leafscension_exploit',
        ; crafted sets
        'hotkey_load_craft_set_0',
        'hotkey_load_craft_set_1',
        'hotkey_load_craft_set_2',
        'hotkey_load_craft_set_3',
        'hotkey_load_craft_set_4',
        'hotkey_load_craft_set_5',
        'hotkey_load_craft_set_6',
        'hotkey_load_craft_set_7',
        ; loadouts
        'hotkey_load_loadout_1',
        'hotkey_load_loadout_3',
        'hotkey_load_loadout_4',
        'hotkey_load_loadout_5',
        'hotkey_load_loadout_6',
        'hotkey_load_loadout_7',
        ; shops bar
        'hotkey_tool_shop',
        'hotkey_leaf_shop',
        'hotkey_gold_shop',
        'hotkey_platinum_shop',
        'hotkey_bismuth_shop',
        'hotkey_cosmic_shop',
        'hotkey_void_shop',
        'hotkey_exotic_shop',
        'hotkey_celestial_shop',
        'hotkey_mythical_shop',
        'hotkey_lava_shop',
        'hotkey_ice_shop',
        'hotkey_obsidian_shop',
        'hotkey_silicon_shop',
        'hotkey_benitoite_shop',
        'hotkey_moonstone_shop',
        'hotkey_sand_shop',
        'hotkey_ancient_shop',
        'hotkey_sacred_shop',
        'hotkey_biotite_shop',
        'hotkey_malachite_shop',
        'hotkey_hematite_shop',
        'hotkey_plasma_shop',
        'hotkey_coal_shop',
        'hotkey_energy_electrical_shop',
        'hotkey_gem_leaves_shop',
        'hotkey_coins_shop',
        'hotkey_blc_shop',
        'hotkey_mlc_shop',
        'hotkey_silver_token_shop',
        'hotkey_gold_token_shop',
        ; science flasks
        'hotkey_red_science',
        'hotkey_green_science',
        'hotkey_blue_science',
        'hotkey_magenta_science',
        'hotkey_orange_science',
        'hotkey_black_science',
        'hotkey_strange_science',
        ; Portals
        'hotkey_blc',
        'hotkey_mlc',
        ; mixture
        'hotkey_converters',
        'hotkey_printers',
        'hotkey_farming',
        'hotkey_mulch_shop',
        'hotkey_leafscension',
        'hotkey_soul_shop',
        'hotkey_soul_forge',
        'hotkey_dice',
        'hotkey_quarks',
        'hotkey_event_shop']
    for (key in gamesettingshotkeys) {
        jsonData[key]['value'] := ResetIncorrectHotkey(jsonData[key]['value'])
    }
    return jsonData
}

ResetIncorrectHotkey(var) {
    aInUse := [32.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0,
        86.0, 88.0, 89.0, 97.0, 99.0, 188.0, 190.0, 191.0, 219.0, 221.0, 222.0]

    for (key in aInUse) {
        if (var = key) {
            var := -1.0
        }
    }
    return var
}