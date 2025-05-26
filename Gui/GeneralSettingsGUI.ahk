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

    If (Verbose = true) {
        settingsGUI.Add("CheckBox", "vVerbose cff8800 checked",
            "Enable Verbose Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vVerbose cff8800", "Enable Verbose Logging")
    }


    If (Debug = true) {
        settingsGUI.Add("CheckBox", "vDebug cff5100 checked",
            "Enable Debug Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vDebug cff5100", "Enable Debug Logging")
    }

    If (DebugAll = true) {
        settingsGUI.Add("CheckBox", "vDebugAll cff0000 checked",
            "Enable DebugAll Logging")
    } Else {
        settingsGUI.Add("CheckBox", "vDebugAll cff0000", "Enable DebugAll Logging")
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

    arr := [
        ""
    ]
    Loop Reg "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "KVR" {
        arr.InsertAt(2, RegExReplace(A_LoopRegName, "\W+\((TrueType|OpenType|All res)\)"))
    }
    preselectfont := 1
    For id, value IN arr {
        If (value = GuiFontName) {
            preselectfont := id
        }
    }
    settingsGUI.AddDropDownList("vGuiFontName Choose" preselectfont, arr)

    settingsGUI.Add("Text", "", "GUI Background Colour:")
    settingsGUI.AddEdit("cDefault vGuiBGColour w140", GuiBGColour)

    settingsGUI.Add("Text", "", "GUI Font Colour:")
    settingsGUI.AddEdit("cDefault vGuiFontColour w140", GuiFontColour)

    settingsGUI.Add("Button", "+Background" GuiBGColour " default", "Save").OnEvent("Click",
        ProcessUserGeneralSettings)
    settingsGUI.Add("Button", "+Background" GuiBGColour " yp", "Cancel").OnEvent("Click",
        CloseUserGeneralSettings)

    settingsGUI.Add("Button", "+Background" GuiBGColour " xs", "Install script to Start Menu").OnEvent("Click",
        InstallShortcuts)
    settingsGUI.Add("Button", "+BackgroundRed yp", "Reset all settings").OnEvent("Click",
        ResetSettings)
    settingsGUI.Add("Button", "+BackgroundYellow yp", "Reset all logs").OnEvent("Click",
        ResetLogs)
    settingsGUI.Add("Button", "+BackgroundYellow xs", "Force check for updates").OnEvent("Click",
        ForceCheckForUpdates)

    ShowGUIPosition(settingsGUI)
    MakeGUIResizableIfOversize(settingsGUI)
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
            CheckForUpdatesEnable, CheckForUpdatesReleaseOnly, DebugAll
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
        DebugAll := values.DebugAll

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

    InstallShortcuts(*) {
        full_command_line := DllCall("GetCommandLine", "str")

        If !(A_IsAdmin || RegExMatch(full_command_line, " /restart(?!\S)")) {
            Try {
                Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptDir '\Installer.ahk"'
            }
            Return
        }
        MsgBox("Could not run without Admin")
        Out.D("A_IsAdmin: " A_IsAdmin "`nCommand line: " full_command_line)
    }

    ResetSettings(*) {
        Global Out
        Out := ""
        HasPressed := MsgBox("Remove all ini files? This resets all settings.",
            "Setting Reset?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            arr := []
            Loop Files A_ScriptDir "\*", 'F' {
                If (StrLower(A_LoopFileExt) = "ini") {
                    Try {
                        FileDelete(A_LoopFileFullPath)
                        arr.Push(A_LoopFileFullPath)
                    }
                }
            }
            list := ""
            For (value in arr) {
                list .= "Deleted: " value "`n"
            }
            MsgBox("Setting Reset Complete.`n" list)
            Reload()
        }
        Out := cLog()
    }

    ResetLogs(*) {
        Global Out
        Out := ""
        HasPressed := MsgBox("Remove all log files? This resets all logs.",
            "Log Reset?", "0x1 0x100 0x10")
        If (HasPressed = "OK") {
            arr := []
            Loop Files A_ScriptDir "\*", 'F' {
                If (StrLower(A_LoopFileExt) = "log") {
                    Try {
                        FileDelete(A_LoopFileFullPath)
                        arr.Push(A_LoopFileFullPath)
                    }
                }
            }
            list := ""
            For (value in arr) {
                list .= "Deleted: " value "`n"
            }
            MsgBox("Log Reset Complete`n" list)
            Reload()
        }
        Out := cLog()
    }

    ForceCheckForUpdates(*) {
        Global CheckForUpdatesLastCheck

        Temp := thisGui.Gui
        Saving := SavingGUI()
        settingsGUI.Hide()
        Temp.Hide()
        Saving.Show()

        CheckForUpdatesLastCheck := 20000101120000
        settings.SaveCurrentSettings()
        Reload()
    }
}
