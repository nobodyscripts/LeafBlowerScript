#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cAreas.ahk

/**
 * Misc points for buttons
 * @property {cPoint} ScrollArrow Top scroll arrow in a scrollable panel
 * @property {cPoint} ScrollHandle Scroll handle in a scrollable panel
 * @property {cPoint} NotifArrow Notification arrow, left point of 
 * arrow when facing down
 */
Class cMiscPoints {
    ScrollArrow := cPoint(2220, 258)
    ScrollHandle := cPoint(2220, 320)
    NotifArrow := cPoint(69, 1212)   
}

/**
 * Misc areas
 * @property {cArea} BossTimer Area boss timer text is displayed
 * @property {cArea} BossTimerLong Area extended boss timer text is 
 * displayed
 */
Class cMiscAreas {
    BossTimer := cArea(1240, 5, 1280, 40)
    BossTimerLong := cArea(1050, 5, 1100, 40)
}