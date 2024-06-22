#Requires AutoHotkey v2.0

#Include Logging.ahk
#Include cHotkey.ahk

; ------------------- Script Hotkeys -------------------
; Loads UserHotkeys.ini values for the rest of the script to use

class cHotkeys {
    sFilename := A_ScriptDir "\UserHotkeys.ini"
    sFileSection := "Default"
    Hotkeys := Map()

    initHotkeys(secondary := false) {
        if (!secondary) {
            if (!FileExist(this.sFilename)) {
                OutputDebug("No UserHotkeys.ini found, writing default file.`r`n")
                Log("No UserHotkeys.ini found, writing default file.")
                this.WriteHotkeyDefaults()
            }
            if (this.loadHotkeys()) {
                Log("Loaded Hotkeys.")
            } else {
                return false
            }
            return true
        } else {
            this.sFilename := A_ScriptDir "\..\UserHotkeys.ini"
            if (this.loadHotkeys()) {
                Log("Loaded Hotkeys.")
            } else {
                return false
            }
            return true
        }
    }

    loadHotkeys() {
        KeyboardLayout := GetKeyboardLayout()
        Log("Keyboard layout detected as " KeyboardLayout ".")

        for (Key in this.Hotkeys) {
            try {
                loaded := this.IniToHotkey(this.sFilename, this.Hotkeys[Key].Category,
                    this.Hotkeys[Key].Name)
                if (loaded) {
                    this.Hotkeys[Key].SetValue(loaded)
                } else {
                    this.Hotkeys[Key].SetValue(this.Hotkeys[key].GetDefaultValue())
                }
            } catch as exc {
                if (exc.Extra) {
                    Log("Error 35: LoadHotkeys failed - " exc.Message "`n" exc.Extra)
                } else {
                    Log("Error 35: LoadHotkeys failed - " exc.Message)
                }
                MsgBox("Could not load all Hotkeys, making new default UserHotkeys.ini")
                Log("Attempting to write a new default UserHotkeys.ini.")
                this.WriteHotkeyDefaults()
                return false
            }
        }
        return true
    }

    GetHotkey(key) {
        if (this.Hotkeys[key].GetValue()) {
            return this.Hotkeys[key].GetValue()
        } else if (this.Hotkeys[key].GetDefaultValue()) {
            return this.Hotkeys[key].GetDefaultValue()
        }
        Log("Error: Did not have a hotkey for " key)
        return false
    }

    GetHotkeyVK(key) {
        if (this.Hotkeys[key].GetValueVK()) {
            return this.Hotkeys[key].GetValueVK()
        } else if (this.Hotkeys[key].GetDefaultValueVK()) {
            return this.Hotkeys[key].GetDefaultValueVK()
        }
        Log("Error: Did not have a hotkeyVk for " key)
        return false
    }

    SetHotkey(key, value, type := 0) {
        if (this.Hotkeys[key]) {
            this.Hotkeys[key].SetValue(value, type)
        }
    }

    WriteToIni(key, value, section := this.sFileSection) {
        switch value {
            case "0":
            case "-1":
            case "":
                IniWrite("-1", this.sFilename, section, key)
            default:
                IniWrite(value, this.sFilename, section, key)
        }
    }

    WriteHotkeyDefaults() {
        Log("Writing new default hotkeys file.")

        for (Key in this.Hotkeys) {
            this.WriteToIni(this.Hotkeys[Key].Name,
                this.Hotkeys[Key].GetDefaultValue(),
                this.Hotkeys[Key].Category)

        }
    }

    ToString() {
        text := "Logging hotkeys:`r`n"
        for (Key in this.Hotkeys) {
            text := text "Name: " this.Hotkeys[Key].Name " "
                . "Default:" this.Hotkeys[Key].GetDefaultValue() " "
                . "Value:" this.Hotkeys[Key].GetValue() " "
                . "Cat: " this.Hotkeys[Key].Category "`r`n"
        }
        return text
    }

    SaveCurrentHotkeys() {
        for (Key in this.Hotkeys) {
            this.WriteToIni(this.Hotkeys[Key].Name,
                this.GetHotkey(Key),
                this.Hotkeys[Key].Category)
        }
    }

    IniToHotkey(file, section, name) {
        var := IniRead(file, section, name)
        switch var {
            case "0":
                return false
            case "":
                return false
            case "-1":
                return false
            default:
                return var
        }
    }

}
