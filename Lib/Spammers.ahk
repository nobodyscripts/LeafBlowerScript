#Requires AutoHotkey v2.0

global WindSpammerPID := 0
global TowerPassiveSpammerPID := 0

NormalBossSpammerStart() {
    global SpammerPID
    if (IsWindowActive()) {
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
    if (SpammerPID && ProcessExist(SpammerPID)) {
        ProcessClose(SpammerPID)
        Log("Closed NormalBoss.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey")
            Log("Closed NormalBoss.ahk using filename.")
        }
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


GFSSBossSpammerStart() {
    global GFSSSpammerPID
    if (IsWindowActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\GFSSBoss.ahk"',
            , , &OutPid)
            GFSSSpammerPID := OutPid
    }
}

IsGFSSSpammerActive() {
    if ((GFSSSpammerPID && ProcessExist(GFSSSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey")) {
        return true
    }
    return false
}

KillGFSSSpammer() {
    if (GFSSSpammerPID && ProcessExist(GFSSSpammerPID)) {
        ProcessClose(GFSSSpammerPID)
        Log("Closed GFSSBoss.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey")
            Log("Closed GFSSBoss.ahk using filename.")
        }
    }
}

KillAllSpammers() {
    if (IsSpammerActive()) {
        KillSpammer()
    }
    if (IsGFSSSpammerActive()) {
        KillGFSSSpammer()
    }
    if (IsLeaftonSpammerActive()) {
        KillLeaftonSpammer()
    }
    if (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
}