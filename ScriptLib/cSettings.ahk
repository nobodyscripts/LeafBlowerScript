#Requires AutoHotkey v2.0

#Include cLogging.ahk
#Include Misc.ahk

; ------------------- Settings -------------------
; Loads UserSettings.ini values for the rest of the script to use
If (!IsSet(S)) {
    /** Global settings values and management of them 
     * @type {cSettings} */
    Global S := cSettings()
}

S.AddSetting("Logging", "EnableLogging", false, "bool")
S.AddSetting("Logging", "TimestampLogs", true, "bool")
S.AddSetting("Logging", "Debug", false, "bool")
S.AddSetting("Logging", "DebugAll", false, "bool")
S.AddSetting("Logging", "Verbose", false, "bool")
S.AddSetting("Logging", "LogBuffer", true, "bool")

/**
 * Single instance of a script setting object
 * @property Name Name of the setting
 * @property DefaultValue Default value for non developers
 * @property Value Value of the setting
 * @property DataType Internal custom datatype string {bool | int | array}
 * @property Category Ini file category heading
 * @method __new Constructor
 * @method ValueToString Converts value to file writable string
 * @method SetCommaDelimStrToArr Set Value to an array of value split by comma
 */
Class singleSetting {
    ;@region Properties
    /**
     * Name of the setting
     * @type {String} 
     */
    Name := ""
    /**
     * Value for this setting
     * @type {String | Integer | Any} 
     */
    Value := ""
    /**
     * Default value for non developers
     * @type {String | Integer | Any} 
     */
    DefaultValue := 0
    /**
     * Internal custom datatype string
     * @type {String} 
     */
    DataType := "bool"
    /**
     * Ini file category heading
     * @type {String} 
     */
    Category := "Default"
    ;@endregion

    ;@region __new()
    /**
     * Constructs class and provides object back, has defaults for all except 
     * iName
     * @constructor
     * @param iName Name of the setting
     * @param {Integer} iDefaultValue Default value set in script
     * @param {String} [iDataType="bool"] Internal custom datatype
     * @param {String} [iCategory="Default"] Ini file section heading name
     * @returns {singleSetting} Returns (this)
     */
    __New(iName, iDefaultValue := 0, iDataType :=
        "bool", iCategory := "Default") {
        this.Name := iName
        this.DefaultValue := iDefaultValue
        this.Value := iDefaultValue
        this.DataType := iDataType
        this.Category := iCategory
        Return this
    }
    ;@endregion

    ;@region ValueToString()
    /**
     * Convert value to file writable string
     * @param {Any} value Defaults to getting value of the setting
     * @returns {String | Integer | Any} 
     */
    ValueToIniString(value := this.Value) {
        Switch (StrLower(this.DataType)) {
        Case "bool":
            Return BinToStr(value)
        Case "array":
            Return ArrToCommaDelimStr(value)
        default:
            Return value
        }
    }
    ;@endregion

    /**
     * Convert ini formatted string to value
     * @param value 
     */
    ValueFromIniString(value := this.Value) {
        Switch (StrLower(this.DataType)) {
        Case "bool":
            Return StrToBin(value)
        Case "array":
            Return StrSplit(value, " ", ",.")
        default:
            Return value
        }
    }

    SetFromIniString(value) {
        this.Value := this.ValueFromIniString(value)
    }

    ;@region SetCommaDelimStrToArr()
    /**
     * Set value of this.Name to an array of value split by space (comma and period stripped)
     * @param {String} var Value comma seperated string to split into array
     * @returns {Array | Any} Returns resulting value
     */
    SetCommaDelimStrToArr(var) {
        this.Value := StrSplit(var, " ", ",.")
        Return this.Value
    }
    ;@endregion
}

/**
 * cSettings - Stores settings data
 * @property Filename Full file path to ini file for settings
 * @property Section Ini section heading for settings
 * @property Map Map to store singleSettings objects per setting name
 * @method initSettings Load Map with defaults, check if file, load if possible,
 * return loaded state
 * @method loadSettings Load script settings into Map, runs UpdateSettings
 * first to add missing settings rather than reset to defaults if some settings
 * exist
 * @method UpdateSettings Adds missing settings using defaults if some settings 
 * don't exist
 * @method WriteDefaults Write default settings to ini file, does not wipe other
 * removed settings
 * @method SaveCurrentSettings Save current Map to ini file converting to format
 * safe for storage
 * @method WriteToIni Write (key, value) to ini file within (section) heading
 * @method IniToVar Reads ini value for (name) in (section) from (file) and 
 * returns as string or Boolean
 */
Class cSettings {
    ;@region Properties
    /**
     * Full file path to ini file for settings
     * @type {String} 
     */
    Filename := A_ScriptDir "\UserSettings.ini"
    /**
     * Ini section heading for settings
     * @type {String}
     */
    Section := "Default"
    /**
     * Map to store singleSettings objects per name
     * @type {Map<string, singleSetting>}
     */
    Map := Map()
    ;@endregion

    __New(FileName := "") {
        If (Filename != "") {
            this.Filename := FileName
        }
        this.AddSetting("Logging", "EnableLogging", false, "bool")
        this.AddSetting("Logging", "Verbose", false, "bool")
        this.AddSetting("Logging", "Debug", false, "bool")
        this.AddSetting("Logging", "DebugAll", false, "bool")
        this.AddSetting("Logging", "TimestampLogs", true, "bool")
        this.AddSetting("Logging", "LogBuffer", true, "bool")

        this.AddSetting("Updates", "CheckForUpdatesEnable", true, "bool")
        this.AddSetting("Updates", "CheckForUpdatesReleaseOnly", true, "bool")
        this.AddSetting("Updates", "CheckForUpdatesLastCheck", 0, "int")
    }

    ;@region AddSetting()
    /**
     * Add a setting to the class to track and update
     */
    AddSetting(section, Name, default, type) {
        If (!this.IsSetting(Name)) {
            this.Map[Name] := singleSetting(Name, default, type, section)
        }
    }
    ;@endregion

    ;@region AddSetting()
    /**
     * Add a setting to the class to track and update
     */
    IsSetting(Name) {
        Return this.Map.Has(Name)
    }
    ;@endregion

    ;@region Get()
    /**
     * Get value by setting name
     */
    Get(Name) {
        If (!this.IsSetting(Name)) {
            Out.E("Setting " Name " was not initialised so cannot be read")
            Throw Error("Setting " Name " was not initialised so cannot be read")
        }
        Return this.Map[Name].Value
    }
    ;@endregion

    ;@region Set()
    /**
     * Get value by setting name
     */
    Set(Name, value) {
        If (!this.IsSetting(Name)) {
            Out.E("Setting " Name " was not initialised so cannot be set to " value)
            Throw Error("Setting " Name " was not initialised so cannot be set to " value)
        }
        this.Map[Name].Value := value
    }
    ;@endregion

    ;@region GetDefault()
    /**
     * Get default value by setting name
     */
    GetDefault(Name) {
        If (!this.IsSetting(Name)) {
            Out.E("Setting " Name " was not initialised so cannot read default")
            Throw Error("Setting " Name " was not initialised so cannot read default")
        }
        Return this.Map[Name].DefaultValue
    }
    ;@endregion

    ;@region SetDefault()
    /**
     * Set value to default by setting name
     */
    SetDefault(Name) {
        If (!this.IsSetting(Name)) {
            Out.E("Setting " Name " was not initialised so cannot set default")
            Throw Error("Setting " Name " was not initialised so cannot set default")
        }
        Return this.Map[Name].Value := this.Map[Name].DefaultValue
    }
    ;@endregion

    ;@region initSettings()
    /**
     * Load Map with defaults, check if file, load if possible, return loaded 
     * state
     * @returns {Boolean} 
     */
    initSettings() {
        If (!FileExist(this.Filename)) {
            Out.I("No UserSettings.ini found, writing default file.")
            this.WriteDefaults()
        }
        If (this.loadSettings()) {
            Out.UpdateSettings(
                this.Get("EnableLogging"),
                this.Get("Verbose"),
                this.Get("Debug"),
                this.Get("DebugAll"),
                this.Get("LogBuffer"),
                this.Get("TimestampLogs"))
            Out.I("Loaded settings.")
        } Else {
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region loadSettings()
    /**
     * Load script settings into Map, updates missing settings and writes defaults
     * @returns {Boolean} False if error
     */
    loadSettings() {
        For (setting in this.Map) {
            Try {
                this.IniToMap(this.Map[setting].Name,
                    this.Map[setting].Category)
            } Catch As exc {
                Out.E(exc)
                If (exc.Extra) {
                    Out.E("LoadSettings failed - " exc.Message "`n" exc
                        .Extra)
                } Else {
                    Out.E("LoadSettings failed - " exc.Message)
                }
                MsgBox("Could not load all settings, making new default " .
                    this.Filename)
                Out.I("Attempting to write a new default " this.Filename ".")
                this.WriteDefaults()
                Return false
            }
        }
        Return true
    }
    ;@endregion

    ;@region WriteDefaults()
    /**
     * Write default settings to ini file, does not wipe other removed settings
     */
    WriteDefaults() {
        For (setting in this.Map) {
            this.SetDefault(this.Map[setting].Name)
            this.WriteToIni(this.Map[setting].Name)
        }
    }
    ;@endregion

    ;@region SaveCurrentSettings()
    /**
     * Save current Map to ini file converting to format safe for storage
     */
    SaveCurrentSettings() {
        For (setting in this.Map) {
            this.WriteToIni(this.Map[setting].Name)
        }
    }
    ;@endregion

    ;@region WriteToIni()
    /**
     * Write (key, value) to ini file within (section) heading
     * @param key Name of setting
     * @param value Value of setting
     * @param {String} [section="Default"] 
     */
    WriteToIni(Name) {
        value := this.Map[Name].ValueToIniString(),
        fn := this.Filename,
        cat := this.Map[Name].Category
        Try {
            storedVal := IniRead(fn, cat, Name)
        } Catch {
        }
        If (!IsSet(storedVal)) {
            IniWrite(value, this.Filename, cat, Name)
            Return
        }
        If (storedVal != value) {
            IniWrite(value, this.Filename, cat, Name)
        }
    }
    ;@endregion

    ;@region ReadFromIni()
    /**
     * Description
     */
    ReadFromIni(file, section, name) {
        value := this.Map[Name].ValueToIniString(),
        fn := this.Filename,
        cat := this.Map[Name].Category
        Try {
            storedVal := IniRead(fn, cat, Name)
        } Catch {
        }
        If (!IsSet(storedVal)) {
            IniWrite(value, this.Filename, cat, Name)
            Return value
        }
        Return storedVal
    }
    ;@endregion

    ;@region IniToVar()
    /**
     * Reads ini value for (name) in (section) from (file) and returns as 
     * string or Boolean
     * @param name 
     * @param {String} section 
     * @param {String} file 
     * @returns {Integer | String} 
     */
    IniToVar(name, section := this.Section, file := this.Filename) {
        value := this.Map[name].ValueFromIniString(this.ReadFromIni(file, section, name))
        Return value
    }
    ;@endregion

    ;@region IniToMap()
    /**
     * Reads ini value for (name) in (section) from (file) and returns as 
     * string or Boolean
     * @param name 
     * @param {String} section 
     * @param {String} file 
     * @returns {Integer | String} 
     */
    IniToMap(name, section := this.Section, file := this.Filename) {
        this.Map[name].SetFromIniString(this.ReadFromIni(file, section, name))
    }
    ;@endregion
}
