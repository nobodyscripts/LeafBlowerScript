#Requires AutoHotkey v2.0

Global SpammerPID := 0
Global WindSpammerPID := 0
Global TowerPassiveSpammerPID := 0
Global GFSSSpammerPID := 0

/**
 * Spammer control spammers/secondary scripts which run in the background or 
 * perform alt tasks as if multithreaded
 * @module Spammer
 * @method KillAllSpammers Kill all secondary/spammer processes
 * @method NormalBossStart Start normal boss spammer
 * @method IsNormalBossActive Is Normal boss spammer active
 * @method KillNormalBoss Kill process of normal boss spammer
 * @method LeaftonStart Start leafton spammer
 * @method IsLeaftonActive Is leafton spammer active
 * @method KillLeafton Kill process of leafton spammer
 * @method TowerPassiveStart Start tower passive spammer
 * @method IsTowerPassiveActive Is tower passive spammer active
 * @method KillTowerPassive Kill process of tower passive spammer
 * @method GFSSBossStart Start green flame and spectralseeker boss spammer
 * @method IsGFSSActive Is green flame and spectralseeker spammer active
 * @method KillGFSS Kill process of green flame and spectralseeker spammer
 */
Class Spammer {

    ;@region KillAllSpammers()
    /**
     * Kill all secondary/spammer processes
     */
    KillAllSpammers() {
        If (this.IsNormalBossActive()) {
            this.KillNormalBoss()
        }
        If (this.IsGFSSActive()) {
            this.KillGFSS()
        }
        If (this.IsLeaftonActive()) {
            this.KillLeafton()
        }
        If (this.IsTowerPassiveActive()) {
            this.KillTowerPassive()
        }
    }
    ;@endregion

    ;@region NormalBossStart()
    /**
     * Start normal boss spammer
     */
    NormalBossStart() {
        If (Window.IsActive()) {
            Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\NormalBoss.ahk"', , , &
                OutPid)
            this.NormalBossPID := OutPid
        }
    }
    ;@endregion

    ;@region IsNormalBossActive()
    /**
     * Is Normal boss spammer active
     * @returns {Boolean} 
     */
    IsNormalBossActive() {
        If ((this.NormalBossPID && ProcessExist(this.NormalBossPID)) ||
            WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey"
            )) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region KillNormalBoss()
    /**
     * Kill process of normal boss spammer
     */
    KillNormalBoss() {
        If (this.NormalBossPID && ProcessExist(this.NormalBossPID)) {
            ProcessClose(this.NormalBossPID)
            Log("Closed NormalBoss.ahk using pid.")
        } Else {
            If (WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey"
            )) {
                WinClose(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey"
                )
                Log("Closed NormalBoss.ahk using filename.")
            }
        }
    }
    ;@endregion

    ;@region LeaftonStart()
    /**
     * Start leafton spammer
     */
    LeaftonStart() {
        If (Window.IsActive()) {
            Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\LeaftonSpammer.ahk"', , , &
                OutPid)
            this.WindPID := OutPid
        }
    }
    ;@endregion

    ;@region IsLeaftonActive()
    /**
     * Is leafton spammer active
     * @returns {Boolean}  
     */
    IsLeaftonActive() {
        If ((this.WindPID && ProcessExist(this.WindPID)) || WinExist(
            A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey")
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region KillLeafton()
    /**
     * Kill process of leafton spammer
     */
    KillLeafton() {
        If (this.WindPID && ProcessExist(this.WindPID)) {
            ProcessClose(this.WindPID)
            Log("Closed JustWindSpammer.ahk using pid.")
        } Else {
            If (WinExist(A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey"
            )) {
                WinClose(A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey"
                )
                Log("Closed JustWindSpammer.ahk using filename.")
            }
        }
    }
    ;@endregion

    ;@region TowerPassiveStart()
    /**
     * Start tower passive spammer
     */
    TowerPassiveStart() {
        If (Window.IsActive()) {
            Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\TowerPassiveSpammer.ahk"', , , &
                OutPid)
            this.TowerPassivePID := OutPid
        }
    }
    ;@endregion

    ;@region IsTowerPassiveActive()
    /**
     * Is tower passive spammer active
     * @returns {Boolean} 
     */
    IsTowerPassiveActive() {
        If ((this.TowerPassivePID && ProcessExist(this.TowerPassivePID)) ||
            WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey"
            )) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region KillTowerPassive()
    /**
     * Kill process of tower passive spammer
     */
    KillTowerPassive() {
        If (this.TowerPassivePID && ProcessExist(this.TowerPassivePID)) {
            ProcessClose(this.TowerPassivePID)
            Log("Closed TowerPassiveSpammer.ahk using pid.")
        } Else {
            If (WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey"
            )) {
                WinClose(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey"
                )
                Log("Closed TowerPassiveSpammer.ahk using filename.")
            }
        }
    }
    ;@endregion

    ;@region GFSSBossStart()
    /**
     * Start green flame and spectralseeker boss spammer
     */
    GFSSBossStart() {
        If (Window.IsActive()) {
            Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\GFSSBoss.ahk"', , , &
                OutPid)
            this.GFSSPID := OutPid
        }
    }
    ;@endregion

    ;@region IsGFSSActive()
    /**
     * Is green flame and spectralseeker spammer active
     * @returns {Boolean} 
     */
    IsGFSSActive() {
        If ((this.GFSSPID && ProcessExist(this.GFSSPID)) || WinExist(
            A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey")) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region KillGFSS()
    /**
     * Kill process of green flame and spectralseeker spammer
     */
    KillGFSS() {
        If (this.GFSSPID && ProcessExist(this.GFSSPID)) {
            ProcessClose(this.GFSSPID)
            Log("Closed GFSSBoss.ahk using pid.")
        } Else {
            If (WinExist(A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey"
            )) {
                WinClose(A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey"
                )
                Log("Closed GFSSBoss.ahk using filename.")
            }
        }
    }
    ;@endregion
}