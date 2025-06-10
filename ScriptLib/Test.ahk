#Requires AutoHotkey v2.0

/** @type {cLog} */
Out := cLog(A_ScriptDir "\Test.log", true, 3, false)

/** @type {cGameWindow} */
Window := cGameWindow("Notepad.exe", 1278, 664)

#Include cLogging.ahk
#Include cGameWindow.ahk
#Include cPoint.ahk
#Include cButton.ahk
#Include cGameStage.ahk
#Include cGUI.ahk
#Include cHotkey.ahk
#Include cHotkeys.ahk
#Include cMousePattern.ahk
#Include cRect.ahk
#Include cSettings.ahk
#Include cSpammers.ahk
#Include cTask.ahk
#Include cTimer.ahk
#Include cToolTip.ahk
#Include cUpdateChecker.ahk
#Include Misc.ahk


S.AddSetting("TestSection", "TestVar", "true, array, test", "Array")
S.initSettings()
S.Set("EnableLogging", true)
S.Set("DebugAll", true)
S.SaveCurrentSettings()

SArrTest := S.Get("TestVar")[2]

If (SArrTest = "array") {
    Out.I("Settings loading correctly")
} Else {
    Out.E("Settings failure; 'array' loaded as " SArrTest)
}
If (window.Exist()) {
    Out.I("Notepad currently loaded")
} Else {
    Out.I("Notepad currently is not found")
}

Out.I("Successful")