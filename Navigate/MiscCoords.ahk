#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk

/**
 * Misc points for buttons
 * @memberof module:cPoints
 * @property {cPoint} ScrollArrow Top scroll arrow in a scrollable panel
 * @property {cPoint} ScrollHandle Scroll handle in a scrollable panel
 * @property {cPoint} NotifArrow Notification arrow, left point of 
 * arrow when facing down
 */
Class cMiscPoints {
    ; Top scroll arrow in a scrollable panel
    ScrollArrow := cPoint(2220, 258)
    ; Scroll handle in a scrollable panel
    ScrollHandle := cPoint(2220, 320)
    ; Notification arrow, left point of arrow when facing down
    NotifArrow := cPoint(69, 1212)
    ; Panel close button
    PanelClose := cPoint(2223, 193)
}

/**
 * Misc areas
 * @memberof module:cRects
 * @property {cRect} BossTimer Area boss timer text is displayed
 * @property {cRect} BossTimerLong Area extended boss timer text is 
 * displayed
 */
Class cMiscRects {
    BossTimer := cRect(1240, 5, 1280, 40)
    BossTimerLong := cRect(1050, 5, 1100, 40)
}