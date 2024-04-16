#Requires AutoHotkey v2.0

global WindSpammerPID := 0
global TowerPassiveSpammerPID := 0

NormalBossSpammerStart() {
    global SpammerPID
    if (IsWindowActive()) {
        ;TriggerViolin()
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\NormalBoss.ahk"',
            , , &OutPid)
        SpammerPID := OutPid
    }
}

IsSpammerActive() {
    if ((SpammerPID && ProcessExist(SpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")) {
            return true
    }
    return false
}

KillSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\NormalBoss.ahk - AutoHotkey v2.0.4
    if (SpammerPID && ProcessExist(SpammerPID)) {
        ProcessClose(SpammerPID)
        Log("Closed NormalBoss.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")
            Log("Closed NormalBoss.ahk using filename.")
        }
        /* if (WinExist("NormalBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")) {
            WinClose("NormalBoss.ahk - AutoHotkey (Workspace) - Visual Studio Code")
        } */
    }
}

LeaftonSpammerStart() {
    global WindSpammerPID
    if (IsWindowActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\LeaftonSpammer.ahk"',
            , , &OutPid)
        WindSpammerPID := OutPid
    }
}

IsLeaftonSpammerActive() {
    if ((WindSpammerPID && ProcessExist(WindSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey")) {
            return true
    }
    return false
}

KillLeaftonSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\JustWindSpammer.ahk - AutoHotkey v2.0.4
    if (WindSpammerPID && ProcessExist(WindSpammerPID)) {
        ProcessClose(WindSpammerPID)
        Log("Closed JustWindSpammer.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey")
            Log("Closed JustWindSpammer.ahk using filename.")
        }
    }
}

TowerPassiveSpammerStart() {
    global TowerPassiveSpammerPID
    if (IsWindowActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\TowerPassiveSpammer.ahk"',
            , , &OutPid)
        TowerPassiveSpammerPID := OutPid
    }
}

IsTowerPassiveSpammerActive() {
    if ((TowerPassiveSpammerPID && ProcessExist(TowerPassiveSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")) {
            return true
    }
    return false
}

KillTowerPassiveSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\TowerPassiveSpammer.ahk - AutoHotkey v2.0.4
    if (TowerPassiveSpammerPID && ProcessExist(TowerPassiveSpammerPID)) {
        ProcessClose(TowerPassiveSpammerPID)
        Log("Closed TowerPassiveSpammer.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")
            Log("Closed TowerPassiveSpammer.ahk using filename.")
        }
    }
}

KillAllSpammers() {
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsLeaftonSpammerActive()) {
        KillLeaftonSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
}