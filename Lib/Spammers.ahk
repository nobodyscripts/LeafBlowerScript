#Requires AutoHotkey v2.0

Global SpammerPID := 0
Global WindSpammerPID := 0
Global TowerPassiveSpammerPID := 0
Global GFSSSpammerPID := 0

NormalBossSpammerStart() {
    Global SpammerPID
    If (Window.IsActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\NormalBoss.ahk"', , , &
            OutPid)
        SpammerPID := OutPid
    }
}

IsSpammerActive() {
    If ((SpammerPID && ProcessExist(SpammerPID)) || WinExist(A_ScriptDir "\Secondaries\NormalBoss.ahk ahk_class AutoHotkey"
    )) {
        Return true
    }
    Return false
}

KillSpammer() {
    If (SpammerPID && ProcessExist(SpammerPID)) {
        ProcessClose(SpammerPID)
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

LeaftonSpammerStart() {
    Global WindSpammerPID
    If (Window.IsActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\LeaftonSpammer.ahk"', , , &
            OutPid)
        WindSpammerPID := OutPid
    }
}

IsLeaftonSpammerActive() {
    If ((WindSpammerPID && ProcessExist(WindSpammerPID)) || WinExist(
        A_ScriptDir "\Secondaries\LeaftonSpammer.ahk ahk_class AutoHotkey")) {
        Return true
    }
    Return false
}

KillLeaftonSpammer() {
    If (WindSpammerPID && ProcessExist(WindSpammerPID)) {
        ProcessClose(WindSpammerPID)
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

TowerPassiveSpammerStart() {
    Global TowerPassiveSpammerPID
    If (Window.IsActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\TowerPassiveSpammer.ahk"', , , &
            OutPid)
        TowerPassiveSpammerPID := OutPid
    }
}

IsTowerPassiveSpammerActive() {
    If ((TowerPassiveSpammerPID && ProcessExist(TowerPassiveSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey"
        )) {
        Return true
    }
    Return false
}

KillTowerPassiveSpammer() {
    If (TowerPassiveSpammerPID && ProcessExist(TowerPassiveSpammerPID)) {
        ProcessClose(TowerPassiveSpammerPID)
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


GFSSBossSpammerStart() {
    Global GFSSSpammerPID
    If (Window.IsActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\GFSSBoss.ahk"', , , &
            OutPid)
        GFSSSpammerPID := OutPid
    }
}

IsGFSSSpammerActive() {
    If ((GFSSSpammerPID && ProcessExist(GFSSSpammerPID)) || WinExist(
        A_ScriptDir "\Secondaries\GFSSBoss.ahk ahk_class AutoHotkey")) {
        Return true
    }
    Return false
}

KillGFSSSpammer() {
    If (GFSSSpammerPID && ProcessExist(GFSSSpammerPID)) {
        ProcessClose(GFSSSpammerPID)
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

KillAllSpammers() {
    If (IsSpammerActive()) {
        KillSpammer()
    }
    If (IsGFSSSpammerActive()) {
        KillGFSSSpammer()
    }
    If (IsLeaftonSpammerActive()) {
        KillLeaftonSpammer()
    }
    If (IsTowerPassiveSpammerActive()) {
        KillTowerPassiveSpammer()
    }
}