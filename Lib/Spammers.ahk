#Requires AutoHotkey v2.0


SpamJustWind() {
    global WindSpammerPID
    if (IsWindowActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\JustWindSpammer.ahk"',
            , , &OutPid)
        WindSpammerPID := OutPid
    }
}

IsWindSpammerActive() {
    if ((WindSpammerPID && ProcessExist(WindSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\JustWindSpammer.ahk ahk_class AutoHotkey")) {
            return true
    }
    return false
}

KillWindSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\JustWindSpammer.ahk - AutoHotkey v2.0.4
    if (WindSpammerPID && ProcessExist(WindSpammerPID)) {
        ProcessClose(WindSpammerPID)
        Log("Closed JustWindSpammer.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\JustWindSpammer.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\JustWindSpammer.ahk ahk_class AutoHotkey")
            Log("Closed JustWindSpammer.ahk using filename.")
        }
    }
}

SpamTowerPassive() {
    global WindSpammerPID
    if (IsWindowActive()) {
        Run('"' A_AhkPath '" /restart "' A_ScriptDir '\Secondaries\TowerPassiveSpammer.ahk"',
            , , &OutPid)
        WindSpammerPID := OutPid
    }
}

IsTowerPassiveSpammerActive() {
    if ((WindSpammerPID && ProcessExist(WindSpammerPID)) ||
        WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")) {
            return true
    }
    return false
}

KillTowerPassiveSpammer() {
    ;F:\Documents\AutoHotkey\LeafBlowerV3\Secondaries\TowerPassiveSpammer.ahk - AutoHotkey v2.0.4
    if (WindSpammerPID && ProcessExist(WindSpammerPID)) {
        ProcessClose(WindSpammerPID)
        Log("Closed TowerPassiveSpammer.ahk using pid.")
    } else {
        if (WinExist(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")) {
            WinClose(A_ScriptDir "\Secondaries\TowerPassiveSpammer.ahk ahk_class AutoHotkey")
            Log("Closed TowerPassiveSpammer.ahk using filename.")
        }
    }
}