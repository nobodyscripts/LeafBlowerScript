#Requires AutoHotkey v2.0

Button_Click_GeneralSettings(thisGui, info) {
    Global settings, EnableLogging, NavigateTime, DisableZoneChecks,
        DisableSettingsChecks, TimestampLogs, Debug, Verbose, LogBuffer
    Global GuiBGColour, GuiFontBold, GuiFontItalic, GuiFontStrike,
        GuiFontUnderline, GuiFontColour, GuiFontSize, GuiFontWeight,
        GuiFontName

    /** @type {GUI} */
    settingsGUI := Gui(, "General Settings")
    settingsGUI.Opt("")
    SetFontOptions(settingsGUI)

    If (EnableLogging = true) {
        settingsGUI.Add("CheckBox", "vLogging checked",
            "Enable Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vLogging", "Enable Logging")
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
        settingsGUI.Add("CheckBox", "vLogBuffer checked",
            "Enable Log Buffer (Reduce disk writes)")
    } Else {
        settingsGUI.Add("CheckBox", "vLogBuffer", "Enable Log Buffer (Reduce disk writes)")
    }

    If (TimestampLogs = true) {
        settingsGUI.Add("CheckBox", "vTimestampLogs checked",
            "Enable Log Timestamps")
    } Else {
        settingsGUI.Add("CheckBox", "vTimestampLogs",
            "Enable Log Timestamps")
    }

    settingsGUI.Add("Text", "", "Navigate Time Delay (ms):")
    settingsGUI.AddEdit("cDefault")
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
        settingsGUI.Add("CheckBox", "vDisableZoneChecks checked",
            "Disable Zone Checks")
    } Else {
        settingsGUI.Add("CheckBox", "vDisableZoneChecks",
            "Disable Zone Checks")
    }

    If (DisableSettingsChecks = true) {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks checked",
            "Disable Game Settings Checks")
    } Else {
        settingsGUI.Add("CheckBox", "vDisableSettingsChecks",
            "Disable Game Settings Checks")
    }

    If (CheckForUpdatesEnable = true) {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable checked",
            "Enable Check For Updates")
    } Else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesEnable",
            "Enable Check For Updates")
    }

    If (CheckForUpdatesReleaseOnly = true) {
        settingsGUI.Add("CheckBox",
            "vCheckForUpdatesReleaseOnly checked",
            "Enable Check For Releases Only")
    } Else {
        settingsGUI.Add("CheckBox", "vCheckForUpdatesReleaseOnly",
            "Enable Check For Releases Only")
    }

    If (GuiFontBold = true) {
        settingsGUI.Add("CheckBox", "vGuiFontBold checked",
            "Enable GUI Font Bold")
    } Else {
        settingsGUI.Add("CheckBox", "vGuiFontBold",
            "Enable GUI Font Bold")
    }

    If (GuiFontItalic = true) {
        settingsGUI.Add("CheckBox", "vGuiFontItalic checked",
            "Enable GUI Font Italic")
    } Else {
        settingsGUI.Add("CheckBox", "vGuiFontItalic",
            "Enable GUI Font Italic")
    }

    If (GuiFontStrike = true) {
        settingsGUI.Add("CheckBox", "vGuiFontStrike checked",
            "Enable GUI Font Strikethrough")
    } Else {
        settingsGUI.Add("CheckBox", "vGuiFontStrike",
            "Enable GUI Font Strikethrough")
    }

    If (GuiFontUnderline = true) {
        settingsGUI.Add("CheckBox", "vGuiFontUnderline checked",
            "Enable GUI Font Underline")
    } Else {
        settingsGUI.Add("CheckBox", "vGuiFontUnderline",
            "Enable GUI Font Underline")
    }
    
    settingsGUI.Add("Text", "", "GUI Font Size:")
    settingsGUI.AddEdit("cDefault")
    If (IsInteger(GuiFontSize) || IsFloat(GuiFontSize)) {
        settingsGUI.Add("UpDown", "vGuiFontSize Range6-50",
            GuiFontSize)
    } Else {
        If (Settings.sUseNobody) {
            settingsGUI.Add("UpDown", "vGuiFontSize Range6-50", Settings.defaultNobodySettings
                .GuiFontSize)
        } Else {
            settingsGUI.Add("UpDown", "vGuiFontSize Range6-50", Settings.defaultSettings
                .GuiFontSize)
        }
    }

    settingsGUI.Add("Text", "", "GUI Font Weight:")
    settingsGUI.AddEdit("cDefault")
    If (IsInteger(GuiFontWeight) || IsFloat(GuiFontWeight)) {
        settingsGUI.Add("UpDown", "vGuiFontWeight Range0-9",
            GuiFontWeight)
    } Else {
        If (Settings.sUseNobody) {
            settingsGUI.Add("UpDown", "vGuiFontWeight Range0-9", Settings.defaultNobodySettings
                .GuiFontWeight)
        } Else {
            settingsGUI.Add("UpDown", "vGuiFontWeight Range0-9", Settings.defaultSettings
                .GuiFontWeight)
        }
    }
    
    settingsGUI.Add("Text", "", "GUI Font Name (blank for default):")
    settingsGUI.AddEdit("cDefault vGuiFontName w140", GuiFontName)

    settingsGUI.Add("Text", "", "GUI Background Colour:")
    settingsGUI.AddEdit("cDefault vGuiBGColour w140", GuiBGColour)

    settingsGUI.Add("Text", "", "GUI Font Colour:")
    settingsGUI.AddEdit("cDefault vGuiFontColour w140", GuiFontColour)

    settingsGUI.Add("Button", "+Background" GuiBGColour " default", "Save").OnEvent("Click",
        ProcessUserGeneralSettings)
    settingsGUI.Add("Button", "+Background" GuiBGColour " default yp", "Cancel").OnEvent("Click",
        CloseUserGeneralSettings)

    ShowGUIPosition(settingsGUI)
    settingsGUI.OnEvent("Size", SaveGUIPositionOnResize)
    OnMessage(0x0003, SaveGUIPositionOnMove)

    ProcessUserGeneralSettings(*) {

        Temp := thisGui.Gui
        Saving := SavingGUI()
        settingsGUI.Hide()
        Temp.Hide()
        Saving.Show()
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

        GuiBGColour := values.GuiBGColour
        GuiFontBold := values.GuiFontBold
        GuiFontItalic := values.GuiFontItalic
        GuiFontStrike := values.GuiFontStrike
        GuiFontUnderline := values.GuiFontUnderline
        GuiFontColour := values.GuiFontColour
        GuiFontSize := values.GuiFontSize
        GuiFontWeight := values.GuiFontWeight
        GuiFontName := values.GuiFontName
        settings.SaveCurrentSettings()
        UpdateDebugLevel()
        Reload()
    }

    CloseUserGeneralSettings(*) {
        settingsGUI.Hide()
    }
}
