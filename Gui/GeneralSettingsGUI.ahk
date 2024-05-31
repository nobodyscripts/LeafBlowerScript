#Requires AutoHotkey v2.0


Button_Click_GeneralSettings(thisGui, info) {
    global settings, EnableLogging, NavigateTime, DisableZoneChecks, DisableSettingsChecks

    settingsGUI := GUI(, "General Settings")
    settingsGUI.Opt("+Owner +MinSize +MinSize500x")
    settingsGUI.BackColor := "0c0018"

    if (EnableLogging = true) {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf checked", "Enable Logging")
    } else {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf", "Enable Logging")
    }

    settingsGUI.Add("Text", "ccfcfcf", "Navigate Time Delay (ms):")
    settingsGUI.AddEdit()
    If (IsInteger(NavigateTime) && NavigateTime > 0) {
        settingsGUI.Add("UpDown", "vNavigateTime Range1-9999", NavigateTime)
    } else {
        if (settings.sUseNobody) {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999",
                settings.defaultNobodySettings.NavigateTime)
        } else {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999",
                settings.defaultSettings.NavigateTime)
        }
    }

    if (DisableZoneChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf checked", "Disable Zone Checks")
    } else {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf", "Disable Zone Checks")
    }


    if (DisableSettingsChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf checked", "Disable Game Settings Checks")
    } else {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf", "Disable Game Settings Checks")
    }

    if (CheckForUpdatesEnable = true) {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable ccfcfcf checked", "Enable Check For Updates")
    } else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable ccfcfcf", "Enable Check For Updates")
    }

    if (CheckForUpdatesReleaseOnly = true) {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesReleaseOnly ccfcfcf checked", "Enable Check For Releases Only")
    } else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesReleaseOnly ccfcfcf", "Enable Check For Releases Only")
    }

    settingsGUI.Add("Button", "default", "Save").OnEvent("Click", ProcessUserGeneralSettings)
    settingsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click", CloseUserGeneralSettings)

    settingsGUI.Show("w300")

    ProcessUserGeneralSettings(*) {
        global EnableLogging, NavigateTime, DisableZoneChecks, DisableSettingsChecks,
            settings, CheckForUpdatesEnable, CheckForUpdatesReleaseOnly
        values := settingsGUI.Submit()
        EnableLogging := values.Logging
        NavigateTime := values.NavigateTime
        DisableZoneChecks := values.DisableZoneChecks
        DisableSettingsChecks := values.DisableSettingsChecks
        CheckForUpdatesEnable := values.CheckForUpdatesEnable
        CheckForUpdatesReleaseOnly := values.CheckForUpdatesReleaseOnly
        settings.SaveCurrentSettings()
    }

    CloseUserGeneralSettings(*) {
        settingsGUI.Hide()
    }
}