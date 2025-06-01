#Requires AutoHotkey v2.0

#Include cLogging.ahk

/**
 * Gets current user keyboard layout in format 0x00000000
 * @returns {String} Current layout code
 */
GetKeyboardLayout() {
    Return Format("0x{:x}", DllCall("GetKeyboardLayout", "UInt", 0, "UInt"))
}

/**
 * Convert keyboard layout code to locale 
 * @example 
 * "EN-GB" = ConvertLayoutToCode("0x8090809")
 * @param KeyboardLayout 0x00000000
 * @returns {String} en-gb
 */
ConvertLayoutToCode(KeyboardLayout) {
    Switch KeyboardLayout {
    Case "0x4090409": ; American
        Return "EN-US"
    Case "0x8090809": ; UK
        Return "EN-GB"
    default:
        Out.I("New keyboard layout needs adding: " KeyboardLayout)
        Return "EN-GB"
    }
}

/**
 * Singular hotkey class
 * @property Name Hotkey Name
 * @property Category Hotkey category to seperate by feature
 * @function __New constructor
 * @function Create Old constructor deprecated
 * @function SetValue Set after construction
 * @function GetValue Get basic value
 * @function GetValueVK Get virtual keyboard value
 * @function GetDefaultValue Get default value for locale
 * @function GetDefaultValueVK Get default virtual keyboard value for locale
 */
Class cHotkey {
    Name := ""
    Category := "Default"

    /**
     * Constructs new cHotkey instance
     * @constructor
     * @param {String} iName Hotkey Name
     * @param {String} iValue 
     * @param {String} iCategory Hotkey category to seperate by feature
     * @returns {cHotkey} 
     */
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

    /**
     * Constructs new cHotkey instance (Deprecated)
     * @param iName Hotkey Name
     * @param iValue 
     * @param {String} iCategory Hotkey category to seperate by feature
     * @returns {cHotkey} 
     */
    Create(iName, iValue, iCategory := "Default") {
        Out.Deprecated()
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

    /**
     * Get hotkey value (Name of button)
     * @returns {Boolean} Hotkey key
     */
    GetValue() {
        If (this.Value) {
            Return this.Value
        }
        Return false
    }

    /**
     * Get virtual keyboard hotkey value (Name of button)
     * @returns {Boolean} Hotkey virtual key 
     */
    GetValueVK() {
        If (this.ValueVK) {
            Return this.ValueVK
        }
        Return false
    }

    /**
     * Get default key value for layout
     * @param {String} locale Locale code as set in ConvertLayoutToCode()
     * @returns {Integer | String} False if no locale, else default value
     */
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

    /**
     * Get default virtual key value for layout
     * @param {String} locale Locale code as set in ConvertLayoutToCode()
     * @returns {Integer | String} False if no locale, else default virtual value
     */
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
