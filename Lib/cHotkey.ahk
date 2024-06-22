#Requires AutoHotkey v2.0 

GetKeyboardLayout() {
    return Format("0x{:x}", DllCall("GetKeyboardLayout", "UInt", 0, "UInt"))
}

ConvertLayoutToCode(KeyboardLayout) {
    switch KeyboardLayout {
        case "0x4090409": ; American
            return "EN-US"
        case "0x8090809": ; UK
            return "EN-GB"
        default:
            Log("New keyboard layout needs adding: " KeyboardLayout)
            return "EN-GB"
    }
}

class cHotkey {
    Name := ""
    Category := "Default"

    __New(iName := "", iValue := "", iCategory := "Default") {
        if (iName = "" || iValue = "")  {
            return this
        }
        this.Name := iName
        this.Defaults := iValue
        this.Value := this.GetDefaultValue()
        this.ValueVK := GetKeyVK(this.Value)
        this.ValueSC := GetKeySC(this.Value)
        this.Category := iCategory
        return this
    }

    Create(iName, iValue, iCategory := "Default") {
        this.Name := iName
        this.Defaults := iValue
        this.Value := this.GetDefaultValue()
        this.ValueVK := GetKeyVK(this.Value)
        this.ValueSC := GetKeySC(this.Value)
        this.Category := iCategory
        return this
    }

    /**
     * Set the hotkey values
     * @param value 
     * @param {Integer} type 0 for set by AHK Name, 1 for set by VK, 2 for set by SC
     * LBR options.dat uses VK
     */
    SetValue(value, type := 0) {
        switch type {
            case 1:
                this.Value := GetKeyName(value)
                this.ValueVK := value
                this.ValueSC := GetKeySC(value)
            case 2:
                this.Value := GetKeyName(value)
                this.ValueVK := GetKeyVK(value)
                this.ValueSC := value
            default:
                this.Value := value
                this.ValueVK := GetKeyVK(Value)
                this.ValueSC := GetKeySC(Value)
        }
    }

    GetValue() {
        if (this.Value) {
            return this.Value
        }
        return false
    }

    GetValueVK() {
        if (this.ValueVK) {
            return this.ValueVK
        }
        return false
    }

    GetDefaultValue(locale := "") {
        if (locale = "") {
            locale := ConvertLayoutToCode(GetKeyboardLayout())
        }
        if (locale = "") {
            return false
        }
        if (this.Defaults[locale]) {
            return this.Defaults[locale]
        } else {
            return this.Defaults["Other"]
        }
    }

    GetDefaultValueVK(locale := "") {
        if (locale = "") {
            locale := ConvertLayoutToCode(GetKeyboardLayout())
        }
        if (locale = "") {
            return false
        }
        if (this.Defaults[locale]) {
            return GetKeyVK(this.Defaults[locale])
        } else {
            return GetKeyVK(this.Defaults["Other"])
        }
    }
}
