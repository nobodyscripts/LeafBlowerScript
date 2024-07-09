#Requires AutoHotkey v2.0

GetKeyboardLayout() {
    Return Format("0x{:x}", DllCall("GetKeyboardLayout", "UInt", 0, "UInt"))
}

ConvertLayoutToCode(KeyboardLayout) {
    Switch KeyboardLayout {
        Case "0x4090409": ; American
            Return "EN-US"
        Case "0x8090809": ; UK
            Return "EN-GB"
        default:
            Log("New keyboard layout needs adding: " KeyboardLayout)
            Return "EN-GB"
    }
}

Class cHotkey {
    Name := ""
    Category := "Default"

    __New(iName := "", iValue := "", iCategory := "Default") {
        If (iName = "" || iValue = "") {
            Return this
        }
        this.Name := iName
        this.Defaults := iValue
        this.Value := this.GetDefaultValue()
        this.ValueVK := GetKeyVK(this.Value)
        this.ValueSC := GetKeySC(this.Value)
        this.Category := iCategory
        Return this
    }

    Create(iName, iValue, iCategory := "Default") {
        this.Name := iName
        this.Defaults := iValue
        this.Value := this.GetDefaultValue()
        this.ValueVK := GetKeyVK(this.Value)
        this.ValueSC := GetKeySC(this.Value)
        this.Category := iCategory
        Return this
    }

    /**
     * Set the hotkey values
     * @param value 
     * @param {Integer} type 0 for set by AHK Name, 1 for set by VK, 2 for set by SC
     * LBR options.dat uses VK
     */
    SetValue(value, type := 0) {
        Switch type {
            Case 1:
                this.Value := GetKeyName(value)
                this.ValueVK := value
                this.ValueSC := GetKeySC(value)
            Case 2:
                this.Value := GetKeyName(value)
                this.ValueVK := GetKeyVK(value)
                this.ValueSC := value
            default:
                this.Value := value
                this.ValueVK := GetKeyVK(value)
                this.ValueSC := GetKeySC(value)
        }
    }

    GetValue() {
        If (this.Value) {
            Return this.Value
        }
        Return false
    }

    GetValueVK() {
        If (this.ValueVK) {
            Return this.ValueVK
        }
        Return false
    }

    GetDefaultValue(locale := "") {
        If (locale = "") {
            locale := ConvertLayoutToCode(GetKeyboardLayout())
        }
        If (locale = "") {
            Return false
        }
        If (this.Defaults[locale]) {
            Return this.Defaults[locale]
        } Else {
            Return this.Defaults["Other"]
        }
    }

    GetDefaultValueVK(locale := "") {
        If (locale = "") {
            locale := ConvertLayoutToCode(GetKeyboardLayout())
        }
        If (locale = "") {
            Return false
        }
        If (this.Defaults[locale]) {
            Return GetKeyVK(this.Defaults[locale])
        } Else {
            Return GetKeyVK(this.Defaults["Other"])
        }
    }
}