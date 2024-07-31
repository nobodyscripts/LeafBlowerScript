#Requires AutoHotkey v2.0


Button_Click_GeneralSettings(thisGui, info) {
    Global settings, EnableLogging, NavigateTime, DisableZoneChecks,
        DisableSettingsChecks, TimestampLogs, Debug, Verbose, LogBuffer

    settingsGUI := Gui(, "General Settings")
    settingsGUI.Opt("+Owner +MinSize +MinSize500x")
    settingsGUI.BackColor := "0c0018"

    If (EnableLogging = true) {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf checked",
            "Enable Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vLogging ccfcfcf", "Enable Logging")
    }

    If (Debug = true) {
        settingsGUI.Add("CheckBox", "vDebug cff8800 checked",
            "Enable Debug Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vDebug cff8800", "Enable Debug Logging")
    }

    If (Verbose = true) {
        settingsGUI.Add("CheckBox", "vVerbose cff0000 checked",
            "Enable Verbose Logging (Warn: Logs will fill quickly)")
    } Else {
        settingsGUI.Add("CheckBox", "vVerbose cff0000", "Enable Verbose Logging (Warn: Logs will fill quickly)")
    }

    If (LogBuffer = true) {
        settingsGUI.Add("CheckBox", "vLogBuffer ccfcfcf checked",
            "Enable Log Buffer (Reduce disk writes)")
    } Else {
        settingsGUI.Add("CheckBox", "vLogBuffer ccfcfcf", "Enable Log Buffer (Reduce disk writes)")
    }

    If (TimestampLogs = true) {
        settingsGUI.Add("CheckBox", "vTimestampLogs ccfcfcf checked",
            "Enable Log Timestamps")
    } Else {
        settingsGUI.Add("CheckBox", "vTimestampLogs ccfcfcf",
            "Enable Log Timestamps")
    }

    settingsGUI.Add("Text", "ccfcfcf", "Navigate Time Delay (ms):")
    settingsGUI.AddEdit()
    If (IsInteger(NavigateTime) && NavigateTime > 0) {
        settingsGUI.Add("UpDown", "vNavigateTime Range1-9999", NavigateTime)
    } Else {
        If (settings.sUseNobody) {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999", settings.defaultNobodySettings
                .NavigateTime)
        } Else {
            settingsGUI.Add("UpDown", "vNavigateTime Range1-9999", settings.defaultSettings
                .NavigateTime)
        }
    }

    If (DisableZoneChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf checked",
            "Disable Zone Checks")
    } Else {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks ccfcfcf",
            "Disable Zone Checks")
    }


    If (DisableSettingsChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf checked",
            "Disable Game Settings Checks")
    } Else {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks ccfcfcf",
            "Disable Game Settings Checks")
    }

    If (CheckForUpdatesEnable = true) {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable ccfcfcf checked",
            "Enable Check For Updates")
    } Else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable ccfcfcf",
            "Enable Check For Updates")
    }

    If (CheckForUpdatesReleaseOnly = true) {
        settingsGUI.Add("CheckBox",
            "vCheckForUpdatesReleaseOnly ccfcfcf checked",
            "Enable Check For Releases Only")
    } Else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesReleaseOnly ccfcfcf",
            "Enable Check For Releases Only")
    }

    settingsGUI.Add("Button", "default", "Save").OnEvent("Click",
        ProcessUserGeneralSettings)
    settingsGUI.Add("Button", "default yp", "Cancel").OnEvent("Click",
        CloseUserGeneralSettings)

    settingsGUI.Show("w300")

    ProcessUserGeneralSettings(*) {
        Global EnableLogging, NavigateTime, DisableZoneChecks,
            DisableSettingsChecks, TimestampLogs, settings,
            CheckForUpdatesEnable, CheckForUpdatesReleaseOnly
        values := settingsGUI.Submit()
        EnableLogging := values.Logging
        NavigateTime := values.NavigateTime
        DisableZoneChecks := values.DisableZoneChecks
        DisableSettingsChecks := values.DisableSettingsChecks
        CheckForUpdatesEnable := values.CheckForUpdatesEnable
        CheckForUpdatesReleaseOnly := values.CheckForUpdatesReleaseOnly
        TimestampLogs := values.TimestampLogs
        Debug := values.Debug
        Verbose := values.Verbose
        LogBuffer := values.LogBuffer
        settings.SaveCurrentSettings()
        UpdateDebugLevel()
    }

    CloseUserGeneralSettings(*) {
        settingsGUI.Hide()
    }
}