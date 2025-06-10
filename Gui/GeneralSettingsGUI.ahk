#Requires AutoHotkey v2.0

Button_Click_GeneralSettings(thisGui, info) {

    EnableLogging := S.Get("EnableLogging")
    NavigateTime := S.Get("NavigateTime")
    DisableZoneChecks := S.Get("DisableZoneChecks")
    DisableSettingsChecks := S.Get("DisableSettingsChecks")
    CheckForUpdatesEnable := S.Get("CheckForUpdatesEnable")
    CheckForUpdatesReleaseOnly := S.Get("CheckForUpdatesReleaseOnly")
    TimestampLogs := S.Get("TimestampLogs")
    local Debug := S.Get("Debug")
    Verbose := S.Get("Verbose")
    LogBuffer := S.Get("LogBuffer")
    DebugAll := S.Get("DebugAll")
    GuiFontBold := S.Get("GuiFontBold")
    GuiFontItalic := S.Get("GuiFontItalic")
    GuiFontStrike := S.Get("GuiFontStrike")
    GuiFontUnderline := S.Get("GuiFontUnderline")
    GuiFontColour := S.Get("GuiFontColour")
    GuiFontSize := S.Get("GuiFontSize")
    GuiFontWeight := S.Get("GuiFontWeight")
    GuiFontName := S.Get("GuiFontName")

    GuiBGColour := S.Get("GuiBGColour")

    /** @type {cGUI} */
    MyGui := cGui(, "General Settings")
    MyGui.Opt("")
    MyGui.SetUserFontSettings()

    If (EnableLogging = true) {
        MyGui.Add("CheckBox", "vLogging checked",
            "Enable Logging")
    } Else {
        MyGui.Add("CheckBox", "vLogging", "Enable Logging")
    }

    If (Verbose = true) {
        MyGui.Add("CheckBox", "vVerbose cff8800 checked",
            "Enable Verbose Logging")
    } Else {
        MyGui.Add("CheckBox", "vVerbose cff8800", "Enable Verbose Logging")
    }

    If (Debug = true) {
        MyGui.Add("CheckBox", "vDebug cff5100 checked",
            "Enable Debug Logging")
    } Else {
        MyGui.Add("CheckBox", "vDebug cff5100", "Enable Debug Logging")
    }

    If (DebugAll = true) {
        MyGui.Add("CheckBox", "vDebugAll cff0000 checked",
            "Enable DebugAll Logging")
    } Else {
        MyGui.Add("CheckBox", "vDebugAll cff0000", "Enable DebugAll Logging")
    }

    If (LogBuffer = true) {
        MyGui.Add("CheckBox", "vLogBuffer checked",
            "Enable Log Buffer (Reduce disk writes)")
    } Else {
        MyGui.Add("CheckBox", "vLogBuffer", "Enable Log Buffer (Reduce disk writes)")
    }

    If (TimestampLogs = true) {
        MyGui.Add("CheckBox", "vTimestampLogs checked",
            "Enable Log Timestamps")
    } Else {
        MyGui.Add("CheckBox", "vTimestampLogs",
            "Enable Log Timestamps")
    }

    MyGui.Add("Text", "", "Navigate Time Delay (ms):")
    MyGui.AddEdit("cDefault")
    If (IsInteger(NavigateTime) && NavigateTime > 0) {
        MyGui.Add("UpDown", "vNavigateTime Range1-9999", NavigateTime)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vNavigateTime Range1-9999", S.defaultNobodySettings
                .NavigateTime)
        } Else {
            MyGui.Add("UpDown", "vNavigateTime Range1-9999", S.defaultSettings
                .NavigateTime)
        }
    }

    If (DisableZoneChecks = true) {
        MyGui.Add("CheckBox", "vDisableZoneChecks checked",
            "Disable Zone Checks")
    } Else {
        MyGui.Add("CheckBox", "vDisableZoneChecks",
            "Disable Zone Checks")
    }

    If (DisableSettingsChecks = true) {
        MyGui.Add("CheckBox", "vDisableSettingsChecks checked",
            "Disable Game Settings Checks")
    } Else {
        MyGui.Add("CheckBox", "vDisableSettingsChecks",
            "Disable Game Settings Checks")
    }

    If (CheckForUpdatesEnable = true) {
        MyGui.Add("CheckBox", "vCheckForUpdatesEnable checked",
            "Enable Check For Updates")
    } Else {
        MyGui.Add("CheckBox", "vCheckForUpdatesEnable",
            "Enable Check For Updates")
    }

    If (CheckForUpdatesReleaseOnly = true) {
        MyGui.Add("CheckBox",
            "vCheckForUpdatesReleaseOnly checked",
            "Enable Check For Releases Only")
    } Else {
        MyGui.Add("CheckBox", "vCheckForUpdatesReleaseOnly",
            "Enable Check For Releases Only")
    }

    If (GuiFontBold = true) {
        MyGui.Add("CheckBox", "vGuiFontBold checked",
            "Enable GUI Font Bold")
    } Else {
        MyGui.Add("CheckBox", "vGuiFontBold",
            "Enable GUI Font Bold")
    }

    If (GuiFontItalic = true) {
        MyGui.Add("CheckBox", "vGuiFontItalic checked",
            "Enable GUI Font Italic")
    } Else {
        MyGui.Add("CheckBox", "vGuiFontItalic",
            "Enable GUI Font Italic")
    }

    If (GuiFontStrike = true) {
        MyGui.Add("CheckBox", "vGuiFontStrike checked",
            "Enable GUI Font Strikethrough")
    } Else {
        MyGui.Add("CheckBox", "vGuiFontStrike",
            "Enable GUI Font Strikethrough")
    }

    If (GuiFontUnderline = true) {
        MyGui.Add("CheckBox", "vGuiFontUnderline checked",
            "Enable GUI Font Underline")
    } Else {
        MyGui.Add("CheckBox", "vGuiFontUnderline",
            "Enable GUI Font Underline")
    }

    MyGui.Add("Text", "", "GUI Font Size:")
    MyGui.AddEdit("cDefault")
    If (IsInteger(GuiFontSize) || IsFloat(GuiFontSize)) {
        MyGui.Add("UpDown", "vGuiFontSize Range6-50",
            GuiFontSize)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vGuiFontSize Range6-50", S.defaultNobodySettings
                .GuiFontSize)
        } Else {
            MyGui.Add("UpDown", "vGuiFontSize Range6-50", S.defaultSettings
                .GuiFontSize)
        }
    }

    MyGui.Add("Text", "", "GUI Font Weight:")
    MyGui.AddEdit("cDefault")
    If (IsInteger(GuiFontWeight) || IsFloat(GuiFontWeight)) {
        MyGui.Add("UpDown", "vGuiFontWeight Range0-9",
            GuiFontWeight)
    } Else {
        If (S.sUseNobody) {
            MyGui.Add("UpDown", "vGuiFontWeight Range0-9", S.defaultNobodySettings
                .GuiFontWeight)
        } Else {
            MyGui.Add("UpDown", "vGuiFontWeight Range0-9", S.defaultSettings
                .GuiFontWeight)
        }
    }

    MyGui.Add("Text", "", "GUI Font Name (blank for default):")

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
    MyGui.AddDropDownList("vGuiFontName Choose" preselectfont, arr)

    MyGui.Add("Text", "", "GUI Background Colour:")
    MyGui.AddEdit("cDefault vGuiBGColour w140", GuiBGColour)

    MyGui.Add("Text", "", "GUI Font Colour:")
    MyGui.AddEdit("cDefault vGuiFontColour w140", GuiFontColour)

    MyGui.Add("Button", "+Background" GuiBGColour " default", "Save").OnEvent("Click",
        ProcessUserGeneralSettings)
    MyGui.Add("Button", "+Background" GuiBGColour " yp", "Cancel").OnEvent("Click",
        CloseUserGeneralSettings)

    MyGui.Add("Button", "+Background" GuiBGColour " xs", "Install script to Start Menu").OnEvent("Click",
        InstallShortcuts)
    MyGui.Add("Button", "+BackgroundRed yp", "Reset all settings").OnEvent("Click",
        ResetSettings)
    MyGui.Add("Button", "+BackgroundYellow yp", "Reset all logs").OnEvent("Click",
        ResetLogs)
    MyGui.Add("Button", "+BackgroundYellow xs", "Force check for updates").OnEvent("Click",
        ForceCheckForUpdates)

    MyGui.ShowGUIPosition()
    MyGui.MakeGUIResizableIfOversize()
    MyGui.OnEvent("Size", MyGui.SaveGUIPositionOnResize.Bind(MyGui))
    OnMessage(0x0003, MyGui.SaveGUIPositionOnMove.Bind(MyGui))

    ProcessUserGeneralSettings(*) {

        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()

        values := MyGui.Submit()

        EnableLogging := values.Logging
        TimestampLogs := values.TimestampLogs
        Debug := values.Debug
        Verbose := values.Verbose
        LogBuffer := values.LogBuffer
        DebugAll := values.DebugAll
        S.Set("EnableLogging", values.Logging)
        S.Set("NavigateTime", values.NavigateTime)
        S.Set("DisableZoneChecks", values.DisableZoneChecks)
        S.Set("DisableSettingsChecks", values.DisableSettingsChecks)
        S.Set("CheckForUpdatesEnable", values.CheckForUpdatesEnable)
        S.Set("CheckForUpdatesReleaseOnly", values.CheckForUpdatesReleaseOnly)
        S.Set("TimestampLogs", values.TimestampLogs)
        S.Set("Debug", values.Debug)
        S.Set("Verbose", values.Verbose)
        S.Set("LogBuffer", values.LogBuffer)
        S.Set("DebugAll", values.DebugAll)
        S.Set("GuiBGColour", values.GuiBGColour)
        S.Set("GuiFontBold", values.GuiFontBold)
        S.Set("GuiFontItalic", values.GuiFontItalic)
        S.Set("GuiFontStrike", values.GuiFontStrike)
        S.Set("GuiFontUnderline", values.GuiFontUnderline)
        S.Set("GuiFontColour", values.GuiFontColour)
        S.Set("GuiFontSize", values.GuiFontSize)
        S.Set("GuiFontWeight", values.GuiFontWeight)
        S.Set("GuiFontName", values.GuiFontName)
        S.SaveCurrentSettings()
        Out.UpdateSettings(EnableLogging, Verbose, Debug, DebugAll, LogBuffer, TimestampLogs)
        Reload()
    }

    CloseUserGeneralSettings(*) {
        MyGui.Hide()
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
        /** @type {cLog} */
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
        }
        Out := cLog()
        Reload()
    }

    ResetLogs(*) {
        /** @type {cLog} */
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
        }
        Out := cLog()
        Reload()
    }

    ForceCheckForUpdates(*) {
        Global CheckForUpdatesLastCheck

        Temp := thisGui.Gui
        Saving := SavingGUI()
        MyGui.Hide()
        Temp.Hide()
        Saving.Show()

        CheckForUpdatesLastCheck := 20000101120000
        S.SaveCurrentSettings()
        Reload()
    }
}
