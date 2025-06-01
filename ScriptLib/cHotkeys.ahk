#Requires AutoHotkey v2.0

#Include cLogging.ahk
#Include cHotkey.ahk

; ------------------- Script Hotkeys -------------------
; Loads UserHotkeys.ini values for the rest of the script to use

Class cHotkeys {
    sFilename := A_ScriptDir "\UserHotkeys.ini"
    sFileSection := "Default"
    IsGameHotkeys := false
    IsScriptHotkeys := false
    Hotkeys := Map()

    initHotkeys() {
        If (!FileExist(this.sFilename)) {
            Out.I("No " this.sFilename " found, writing default file.")
            this.WriteHotkeyDefaults()
        }
        If (this.loadHotkeys()) {
            Out.I("Loaded " this.sFilename ".")
        } Else {
            Return false
        }
        Return true
    }

    loadHotkeys() {
        KeyboardLayout := GetKeyboardLayout()
        Out.I("Keyboard layout detected as " KeyboardLayout ".")

        For (Key in this.Hotkeys) {
            Try {
                loaded := this.IniToHotkey(this.sFilename, this.Hotkeys[Key].Category,
                    this.Hotkeys[Key].Name)
                If (loaded) {
                    this.Hotkeys[Key].SetValue(loaded)
                } Else {
                    this.Hotkeys[Key].SetValue(this.Hotkeys[Key].GetDefaultValue())
                }
            } Catch As exc {
                If (exc.Extra) {
                    MsgBox("Error: LoadHotkeys failed - " exc.Message "`n" exc
                        .Extra)
                } Else {
                    Out.E("LoadHotkeys failed")
                    Out.E(exc)
                }
                MsgBox("Could not load all Hotkeys, making new default " this.sFilename
                )
                Out.I("Attempting to write a new default " this.sFilename ".")
                this.WriteHotkeyDefaults()
                Return false
            }
        }
        Return true
    }

    GetHotkey(key) {
        If (this.Hotkeys[key].GetValue()) {
            Return this.Hotkeys[key].GetValue()
        } Else If (this.Hotkeys[key].GetDefaultValue()) {
            Return this.Hotkeys[key].GetDefaultValue()
        }
        Out.E("Did not have a hotkey for " key)
        Return false
    }

    GetHotkeyVK(key) {
        If (this.Hotkeys[key].GetValueVK()) {
            Return this.Hotkeys[key].GetValueVK()
        } Else If (this.Hotkeys[key].GetDefaultValueVK()) {
            Return this.Hotkeys[key].GetDefaultValueVK()
        }
        Out.E("Did not have a hotkeyVk for " key)
        Return false
    }

    SetHotkey(key, value, type := 0) {
        If (this.Hotkeys[key]) {
            this.Hotkeys[key].SetValue(value, type)
        }
    }

    WriteToIni(key, value, section := this.sFileSection) {
        Switch value {
        Case "0":
        Case "-1":
        Case "":
            IniWrite("-1", this.sFilename, section, key)
        default:
            IniWrite(value, this.sFilename, section, key)
        }
    }

    WriteHotkeyDefaults() {
        Out.I("Writing new default hotkeys file.")

        For (Key in this.Hotkeys) {
            this.WriteToIni(this.Hotkeys[Key].Name, this.Hotkeys[Key].GetDefaultValue(),
            this.Hotkeys[Key].Category)

        }
    }

    ToString() {
        text := "Logging hotkeys:`r`n"
        For (Key in this.Hotkeys) {
            text := text "Name: " this.Hotkeys[Key].Name " " . "Default:" this.Hotkeys[
                Key].GetDefaultValue() " " . "Value:" this.Hotkeys[Key].GetValue() " " .
                "Cat: " this.Hotkeys[Key].Category "`r`n"
        }
        Return text
    }

    SaveCurrentHotkeys() {
        For (Key in this.Hotkeys) {
            this.WriteToIni(this.Hotkeys[Key].Name, this.GetHotkey(Key), this.Hotkeys[
                Key].Category)
        }
    }

    IniToHotkey(file, section, name) {
        var := IniRead(file, section, name)
        Switch var {
        Case "0":
            Return false
        Case "":
            Return false
        Case "-1":
            Return false
        default:
            Return var
        }
    }
}
