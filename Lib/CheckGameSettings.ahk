#Requires AutoHotkey v2.0

#include ../ExtLIbs/PeepAHK-main/script/Peep.v2.ahk

fCheckGameSettings() {
    tooltipid := 1
    err := 0
    warn := 0
    startX := 50
    startY := 50
    incY := 40
    display := ""
    if (!jsonData := ConvertGameSettingsToJson(ActiveGameSettingsPath)) {
        return
    }

    if (jsonData['fullscreen']['value'] > 0) {
        display .= "Error: Fullscreen detected on, script requires off`n"
        err++
    }
    if (jsonData['afk_mode_lost_focus']['value'] != 0) {
        display .= "Error: Auto afk detected on, script requires off`n"
        err++
    }
    if (jsonData['alb_visible']['value'] = 100.0) {
        display .= "Warn: Alb detected 100%, script suggests less than 100%`n"
        warn++
    }
    if (jsonData['alternative_font']['value'] != 1) {
        display .= "Error: Alternative font not detected, script requires Alternative`n"
        err++
    }
    if (jsonData['borbventures_detailed_info']['value'] != 0) {
        display .= "Warn: Borbventure detailed detected on, script suggests off`n"
        warn++
    }
    if (jsonData['claw_auto_play']['value'] != 1) {
        display .= "Error: Claw Auto detected off, script requires on`n"
        err++
    }
    if (jsonData['dark_dialog_bg']['value'] != 0) {
        display .= "Error: Dark dialog background detected on, script requires off`n"
        err++
    }
    if (jsonData['draw_trees']['value'] != 0) {
        display .= "Error: Draw trees detected on, script requires off`n"
        err++
    }
    if (jsonData['enable_aa']['value'] != 0) {
        display .= "Error: Smooth graphics detected on, script requires off`n"
        err++
    }
    if (jsonData['enable_notifications']['value'] != 0) {
        display .= "Warn: Notifications detected on, script suggests off`n"
        warn++
    }
    if (jsonData['font_size']['value'] != 0.0) {
        display .= "Error: Font size detected greater than 0, script requires 0`n"
        err++
    }
    if (jsonData['menu_transparency']['value'] != 100.0) {
        display .= "Error: Menu transparency detected on, script requires off`n"
        err++
    }
    if (jsonData['reset_scroll_position_after_prestige']['value'] != 1) {
        display .= "Warn: Reset scroll after prestige detected off, script suggests on`n"
        warn++
    }
    if (jsonData['show_death_dialogs']['value'] != 0) {
        display .= "Error: Blown away dialogs detected on, script requires off`n"
        err++
    }
    if (jsonData['show_reward_dialogs']['value'] != 0) {
        display .= "Warn: Reward dialogs detected on, script suggests off`n"
        warn++
    }
    if (jsonData['trades_detailed_info']['value'] != 0) {
        display .= "Error: Trade details detected on, script requires off`n"
        err++
    }
    if (jsonData['disable_app_surface']['value'] != 1) {
        ; This is alt rendering
        display .= "Error: Alternative rendering detected off, script requires on`n"
        err++
    }

    if (err > 0 || warn > 0){
        MsgBox("Game resized, game setting checks found: " err " Errors and " warn " Warnings.`n`n" display)
    } else {
        MsgBox("Game resized, game setting checks found: " err " Errors and " warn " Warnings.")
    }

}