#Requires AutoHotkey v2.0

#Include ..\ExtLIbs\jsongo_AHKv2-main\src\jsongo.v2.ahk
#Include ScriptSettings.ahk
#Include Logging.ahk

/** @type {Boolean} */
Global CheckForUpdatesEnable := true
/** @type {Boolean} */
Global CheckForUpdatesReleaseOnly := true
/** @type {DateTime} */
Global CheckForUpdatesLastCheck := 0
/**
 * 30 mins in ms, check time (unused)
 * @type {Integer}
 */
Global CheckForUpdatesInterval := 30 * 60 * 60 * 1000
/**
 * Limit to check once every 24 hours
 * @type {Integer} "24"
 */
Global CheckForUpdatesLimiter := 24
/** @type {UpdateChecker} */
Global Updater := UpdateChecker()

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

Class ScriptVersion {
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
        If (!var.Has("Major")) {
            split := StrSplit(var["Version"], ".", "vV") ; "3.1.2-Alpha"
            splitPatch := StrSplit(split[3], "-") ; "2-Alpha"

            this.Major := split[1]
            this.Minor := split[2]
            this.Patch := splitPatch[1]
            this.Release := splitPatch[2]
            this.Build := var["Build"]
            Return
        }
        this.raw := var
        this.Major := var["Major"]
        this.Minor := var["Minor"]
        this.Patch := var["Patch"]
        this.Release := var["Release"]
        this.Build := var["Build"]
    }

    ReleaseToVal(var := this.Release) {
        Switch var {
        Case "Test":
            Return 0
        Case "Alpha":
            Return 1
        Case "Beta":
            Return 2
        Case "Pre-Release":
            Return 3
        default:
            Return 99
        }
    }
}

CompareScriptVersions(obj, obj2, ReleasesOnly) {
    If (!ReleasesOnly) {
        ; if not just releases check if build is newer first
        If (obj.Build > obj2.Build) {
            Return 1
        }
        If (obj.Build < obj2.Build) {
            Return -1
        }
    }
    ; Major x.0.0
    If (obj.Major > obj2.Major) {
        Return 1
    }
    If (obj.Major < obj2.Major) {
        Return -1
    }
    ; Minor 0.x.0
    If (obj.Minor > obj2.Minor) {
        Return 1
    }
    If (obj.Minor < obj2.Minor) {
        Return -1
    }
    ; Patch 0.0.x
    If (obj.Patch > obj2.Patch) {
        Return 1
    }
    If (obj.Patch < obj2.Patch) {
        Return -1
    }
    If (!ReleasesOnly) {
        ; Release
        thisRelease := obj.ReleaseToVal()
        thatRelease := obj2.ReleaseToVal()

        If (thisRelease > thatRelease) {
            Return 1
        }
        If (thisRelease < thatRelease) {
            Return -1
        }
    } Else {
        ; If only releases and one of them has a flag, favour the other
        If (obj2.Release != "" && obj.Release = "") {
            Return -1
        }
        If (obj.Release != "" && obj2.Release = "") {
            Return 1
        }
    }
    Return 0
}

Class UpdateChecker {
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
        Global CheckForUpdatesEnable, CheckForUpdatesReleaseOnly,
            CheckForUpdatesLastCheck, CheckForUpdatesInterval
        Global settings

        If (!settings) {
            Global settings := cSettings()

            If (!settings.initSettings()) {
                Return false
            }
        }

        this.Enabled := CheckForUpdatesEnable
        this.ReleasesOnly := CheckForUpdatesReleaseOnly
        this.LastCheckTime := CheckForUpdatesLastCheck
        this.CheckInterval := CheckForUpdatesInterval
    }

    Check() {
        If (!this.Enabled || !this.isUpdateCheckTimePassed()) {
            Return
        }
        localjson := this.GetLocalJson()
        If (!localjson) {
            Return false
        }
        webjson := this.GetWebJson()
        If (!webjson) {
            Return false
        }
        localVer := ScriptVersion()
        localVer.SetByJson(localjson)
        webVer := ScriptVersion()
        webVer.SetByJson(webjson)
        comparison := CompareScriptVersions(localVer, webVer, this.ReleasesOnly
        )
        If (this.ReleasesOnly && comparison = -1) {
            this.IsNewRelease := true
        }
        If (!this.ReleasesOnly && comparison = -1) {
            this.IsNewBeta := true
        }
    }

    GetLocalJson() {
        Try {
            If (FileExist(this.CurrentJsonFile)) {
                filecontents := FileRead(this.CurrentJsonFile)
            } Else {
                Out.I("Error: Version file not found at " this.CurrentJsonFile)
                MsgBox("Error: Version file not found at " this.CurrentJsonFile)
                Return false
            }
        } Catch As exc {
            Out.I("Error: Error opening version file " this.CurrentJsonFile
                " - " exc.Message)
            MsgBox("Error: Error opening version file " this.CurrentJsonFile " - " exc.Message)
            Return false
        }
        If (!filecontents) {
            Out.I("Error: No version file found in " this.CurrentJsonFile)
            Return false
        }

        Out.I("Local:`r`n" filecontents)
        Return jsongo.Parse(filecontents)
    }

    GetWebJson() {
        Try {
            whr := ComObject("WinHttp.WinHttpRequest.5.1")
            whr.Open("GET",
                "https://raw.githubusercontent.com/nobodyscripts/LeafBlowerScript/main/Version.json",
                true)
            whr.Send()
            ; Using 'true' above and the call below allows the script to remain responsive.
            whr.WaitForResponse()
            Out.I("Remote:`r`n" whr.ResponseText)
            Return jsongo.Parse(whr.ResponseText)
        } Catch As exc {
            Out.I("CheckForUpdates: GetWebJson, Error fetching version.json - "
                exc.Message)
            MsgBox(
                "CheckForUpdates: GetWebJson, Error fetching version.json:`r`n"
                exc.Message)
            Return false
        }
    }

    isUpdateCheckTimePassed() {
        Global CheckForUpdatesLastCheck, CheckForUpdatesLimiter
        If (this.LastCheckTime = 0 || DateDiff(this.LastCheckTime, A_Now,
            "Hours") <= CheckForUpdatesLimiter * -1) {
            CheckForUpdatesLastCheck := this.LastCheckTime := A_Now

            this.SaveCheckTime()
            Return true
        }
        Return false
    }

    SaveCheckTime() {
        Global settings
        settings.SaveCurrentSettings()
    }
}
