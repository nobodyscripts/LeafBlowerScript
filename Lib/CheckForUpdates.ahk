#Requires AutoHotkey v2.0

#Include ..\ExtLIbs\jsongo_AHKv2-main\src\jsongo.v2.ahk
#Include ScriptSettings.ahk
#Include Logging.ahk

/** @type {Boolean} */
global CheckForUpdatesEnable := true
/** @type {Boolean} */
global CheckForUpdatesReleaseOnly := true
/** @type {DateTime} */
global CheckForUpdatesLastCheck := 0
/**
 * 30 mins in ms, check time (unused)
 * @type {Integer}
 */
global CheckForUpdatesInterval := 30 * 60 * 60 * 1000
/**
 * Limit to check once every 24 hours
 * @type {Integer} "24"
 */
global CheckForUpdatesLimiter := 24 
/** @type {UpdateChecker} */
global Updater := UpdateChecker()

;Updater.Init()
;Updater.Check()
; Check every hour
;SetTimer(Updater.Check, CheckForUpdatesInterval, 20)

/*

https://api.github.com/repos/<username>/<repository_name>/releases
https://api.github.com/repos/nobodyscripts/leafblowerscript/releases
returns json, 0.tag_name = "v3.1.1", 0.url = web link for browser

https://api.github.com/users/nobodyscripts/events/public

*/

class ScriptVersion {
    raw := ""

    Major := 0
    Minor := 0
    Patch := 0
    Release := ""
    Build := 0

    /**
     * 
     * @param {string} var Json string of format 
     */
    SetByJson(var) {
        if (!var.Has("Major")) {
            split := StrSplit(var["Version"], ".", "vV") ; "3.1.2-Alpha"
            splitPatch := StrSplit(split[3], "-") ; "2-Alpha"

            this.Major := split[1]
            this.Minor := split[2]
            this.Patch := splitPatch[1]
            this.Release := splitPatch[2]
            this.Build := var["Build"]
            return
        }
        this.raw := var
        this.Major := var["Major"]
        this.Minor := var["Minor"]
        this.Patch := var["Patch"]
        this.Release := var["Release"]
        this.Build := var["Build"]
    }

    ReleaseToVal(var := this.Release) {
        switch var {
            case "Test":
                return 0
            case "Alpha":
                return 1
            case "Beta":
                return 2
            case "Pre-Release":
                return 3
            default:
                return 99
        }
    }
}

CompareScriptVersions(obj, obj2, ReleasesOnly) {
    if (!ReleasesOnly) {
        ; if not just releases check if build is newer first
        if (obj.Build > obj2.Build) {
            return 1
        }
        if (obj.Build < obj2.Build) {
            return -1
        }
    }
    ; Major x.0.0
    if (obj.Major > obj2.Major) {
        return 1
    }
    if (obj.Major < obj2.Major) {
        return -1
    }
    ; Minor 0.x.0
    if (obj.Minor > obj2.Minor) {
        return 1
    }
    if (obj.Minor < obj2.Minor) {
        return -1
    }
    ; Patch 0.0.x
    if (obj.Patch > obj2.Patch) {
        return 1
    }
    if (obj.Patch < obj2.Patch) {
        return -1
    }
    if (!ReleasesOnly) {
        ; Release
        thisRelease := obj.ReleaseToVal()
        thatRelease := obj2.ReleaseToVal()

        if (thisRelease > thatRelease) {
            return 1
        }
        if (thisRelease < thatRelease) {
            return -1
        }
    } else {
        ; If only releases and one of them has a flag, favour the other
        if (obj2.Release != "" && obj.Release = "") {
            return -1
        }
        if (obj.Release != "" && obj2.Release = "") {
            return 1
        }
    }
    return 0
}

class UpdateChecker {
    Enabled := true
    ReleasesOnly := true
    LastCheckTime := 0
    CheckInterval := 0 ; hours
    MaxChecks := 0
    CurrentVersion := 0
    CurrentJsonFile := A_ScriptDir "\Version.json"
    IsNewRelease := false
    IsNewBeta := false

    /**
     * Initialise class with loaded settings
     * @returns {Integer} False if settings fail to load
     */
    Init() {
        global CheckForUpdatesEnable, CheckForUpdatesReleaseOnly,
            CheckForUpdatesLastCheck, CheckForUpdatesInterval
        global settings

        if (!settings) {
            global settings := cSettings()

            if (!settings.initSettings()) {
                return false
            }
        }

        this.Enabled := CheckForUpdatesEnable
        this.ReleasesOnly := CheckForUpdatesReleaseOnly
        this.LastCheckTime := CheckForUpdatesLastCheck
        this.CheckInterval := CheckForUpdatesInterval
    }

    Check() {
        if (!this.Enabled || !this.isUpdateCheckTimePassed()) {
            return
        }
        localjson := this.GetLocalJson()
        if (!localjson) {
            return false
        }
        webjson := this.GetWebJson()
        if (!webjson) {
            return false
        }
        localVer := ScriptVersion()
        localVer.SetByJson(localjson)
        webVer := ScriptVersion()
        webVer.SetByJson(webjson)
        comparison := CompareScriptVersions(localVer, webVer, this.ReleasesOnly
        )
        if (this.ReleasesOnly && comparison = -1) {
            this.IsNewRelease := true
        }
        if (!this.ReleasesOnly && comparison = -1) {
            this.IsNewBeta := true
        }
    }

    GetLocalJson() {
        try {
            if (FileExist(this.CurrentJsonFile)) {
                filecontents := FileRead(this.CurrentJsonFile)
            } else {
                Log("Error: Version file not found at " this.CurrentJsonFile "`r`n"
                )
                MsgBox("Error: Version file not found at " this.CurrentJsonFile
                )
                return false
            }
        } catch as exc {
            Log("Error: Error opening version file " this.CurrentJsonFile " - " exc
                .Message "`r`n")
            MsgBox("Error: Error opening version file " this.CurrentJsonFile " - " exc
                .Message)
            return false
        }
        if (!filecontents) {
            Log("Error: No version file found in " this.CurrentJsonFile)
            return false
        }

        Log("Local:`r`n" filecontents)
        return jsongo.Parse(filecontents)
    }

    GetWebJson() {
        try {
            whr := ComObject("WinHttp.WinHttpRequest.5.1")
            whr.Open("GET",
                "https://raw.githubusercontent.com/nobodyscripts/LeafBlowerScript/main/Version.json",
                true)
            whr.Send()
            ; Using 'true' above and the call below allows the script to remain responsive.
            whr.WaitForResponse()
            Log("Remote:`r`n" whr.ResponseText)
            return jsongo.Parse(whr.ResponseText)
        } catch as exc {
            Log("CheckForUpdates: GetWebJson, Error fetching version.json - " exc
                .Message "`r`n")
            MsgBox(
                "CheckForUpdates: GetWebJson, Error fetching version.json:`n" exc
                .Message)
            return false
        }
    }

    isUpdateCheckTimePassed() {
        global CheckForUpdatesLastCheck, CheckForUpdatesLimiter
        if (this.LastCheckTime = 0 || DateDiff(this.LastCheckTime, A_Now,
            "Hours") >= CheckForUpdatesLimiter) {
            CheckForUpdatesLastCheck := this.LastCheckTime := A_Now

            this.SaveCheckTime()
            return true
        }
        return false
    }

    SaveCheckTime() {
        global settings
        settings.SaveCurrentSettings()
    }
}