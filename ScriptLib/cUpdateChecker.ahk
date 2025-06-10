#Requires AutoHotkey v2.0

#Include ExtLibs\jsongo_AHKv2-main\src\jsongo.v2.ahk
#Include cSettings.ahk
#Include cLogging.ahk

S.AddSetting("Updates", "CheckForUpdatesEnable", true, "bool")
S.AddSetting("Updates", "CheckForUpdatesReleaseOnly", true, "bool")
S.AddSetting("Updates", "CheckForUpdatesLastCheck", 0, "int")
S.AddSetting("Updates", "CheckForUpdatesInterval", 24, "int")

If (!IsSet(Updater)) {
    /** Update checking class, checks version against github in a low bandwidth approach
     * @type {UpdateChecker} */
    Global Updater := UpdateChecker()
}

/**
 * Version object for comparison and serialization
 */
Class ScriptVersion {
    Raw := ""
    Major := 0
    Minor := 0
    Patch := 0
    Release := ""
    Build := 0
    Full := ""

    /**
     * 
     * @param {string} var Json string of format 
     */
    SetByJson(var) {
        this.Raw := var["Version"]
        If (!var.Has("Major")) {
            split := StrSplit(var["Version"], ".", "vV") ; "3.1.2-Alpha"
            splitPatch := StrSplit(split[3], "-") ; "2-Alpha"

            this.Major := split[1]
            this.Minor := split[2]
            this.Patch := splitPatch[1]
            this.Release := splitPatch[2]
            this.Build := var["Build"]
            this.Full := var["Version"] " - Build " var["Build"]
            Return
        }
        this.Major := var["Major"]
        this.Minor := var["Minor"]
        this.Patch := var["Patch"]
        this.Release := var["Release"]
        this.Build := var["Build"]
        this.Full := var["Version"] " - Build " var["Build"]
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
    /** @type {ScriptVersion} */
    CurrentVersion := ScriptVersion()
    CurrentJsonFile := A_ScriptDir "\Version.json"
    IsNewRelease := false
    IsNewBeta := false
    localjson := ""
    /** @example "https://github.com/nobodyscripts/LeafBlowerScript/archive/refs/heads/main.zip" */
    ZipDownload := ""
    /** @example "LeafBlowerScript-main"*/
    ZipFolder := ""
    /** @example "https://raw.githubusercontent.com/nobodyscripts/LeafBlowerScript/main/Version.json" */
    RemoteJson := ""
    /** @example "LBR NobodyScript" */
    ScriptName := ""

    /**
     * Initialise class with loaded settings
     * @returns {Integer} False if settings fail to load
     */
    Init() {
        If (!IsSet(S)) {
            Return false
        }

        this.Enabled := S.Get("CheckForUpdatesEnable")
        this.ReleasesOnly := S.Get("CheckForUpdatesReleaseOnly")
        this.LastCheckTime := S.Get("CheckForUpdatesLastCheck")
        this.CheckInterval := S.Get("CheckForUpdatesInterval")
        this.localjson := this.GetLocalJson()
        /** @type {ScriptVersion} */
        localVer := ScriptVersion()
        If (!this.localjson) {
            Return false
        }
        localVer.SetByJson(this.localjson)
        this.CurrentVersion := localVer
        Out.I(this.Scriptname " Version " localVer.Full)
    }

    Check() {
        If (!this.Enabled || !this.isUpdateCheckTimePassed()) {
            Return
        }
        webjson := this.GetWebJson()
        If (!webjson) {
            Return false
        }
        /** @type {ScriptVersion} */
        webVer := ScriptVersion()
        webVer.SetByJson(webjson)
        comparison := CompareScriptVersions(this.CurrentVersion, webVer, this.ReleasesOnly
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
                Out.E("Version file not found at " this.CurrentJsonFile)
                MsgBox("Error: Version file not found at " this.CurrentJsonFile)
                Return false
            }
        } Catch As exc {
            Out.E("Could not open version file " this.CurrentJsonFile
                " - " exc.Message)
            MsgBox("Error: Error opening version file " this.CurrentJsonFile " - " exc.Message)
            Return false
        }
        If (!filecontents) {
            Out.E("No version file found in " this.CurrentJsonFile)
            Return false
        }
        Return jsongo.Parse(filecontents)
    }

    GetWebJson() {
        Try {
            whr := ComObject("WinHttp.WinHttpRequest.5.1")
            whr.Open("GET", this.RemoteJson, true)
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
        If (this.LastCheckTime = 0 || DateDiff(this.LastCheckTime, A_Now,
            "Hours") <= S.Get("CheckForUpdatesInterval") * -1) {
            this.LastCheckTime := A_Now
            S.Set("CheckForUpdatesLastCheck", this.LastCheckTime)
            S.SaveCurrentSettings()
            Return true
        }
        Return false
    }

    /**
     * Update script to new version based on settings in class, suggest close
     * gui windows during process
     * @param Dialog Gui window for progress display
     */
    UpdateScriptToNewDev(Dialog) {
        Dialog.Show()
        Try {
            If (FileExist("Install.zip")) {
                FileDelete("Install.zip")
                Out.I("Removed old Install.zip")
            }
            Download(this.ZipDownload, "Install.zip")
        } Catch Error As uperr {
            Dialog.Hide()
            MsgBox("Error occured during update download:`r`n" uperr.Message)
            Out.E("Install.zip download failed with error.")
            Out.E(uperr)
            Reload()
        }
        If (!FileExist("Install.zip")) {
            Dialog.Hide()
            Out.E("Install.zip failed to download.")
            MsgBox("Error: Zip failed to download.")
            Reload()
        }
        Try {
            Out.I("Install.zip downloaded. Unpacking.")
            DirCopy("Install.zip", A_ScriptDir, 1)
            DirCopy(A_ScriptDir "\" this.ZipFolder, A_ScriptDir, 2)
            DirDelete(A_ScriptDir "\" this.ZipFolder, 1)
            FileDelete(A_ScriptDir "\Install.zip")
        } Catch Error As unpackerr {
            Dialog.Hide()
            MsgBox("Error occured during update:`r`n" unpackerr.Message " " unpackerr.Extra)
            Out.E("Update failed to extract with error.")
            Out.E(unpackerr)
            Reload()
        }
        Dialog.Hide()
        MsgBox(this.ScriptName " Update Completed.")
        Reload()
    }
}
