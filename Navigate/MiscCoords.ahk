#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk

/**
 * Misc points for buttons
 * @memberof module:cPoints
 * @property {cPoint} ZoneSample Top left corner used for zone background
 * samples
 * @property {cPoint} ScrollArrow Top scroll arrow in a scrollable panel
 * @property {cPoint} ScrollHandle Scroll handle in a scrollable panel
 * @property {cPoint} NotifArrow Notification arrow, left point of 
 * arrow when facing down
 * @property {cPoint} PanelClose Panel close button
 * @property {cPoint} PanelBG Panel colour check
 * @property {Object} Settings
 * @property {cPoint} Settings.MiscTab Misc tab in settings
 */
Class cMiscPoints {
    ; Top left corner used for zone background samples
    ZoneSample := cPoint(0, 0)
    ; Top scroll arrow in a scrollable panel
    ScrollArrow := cPoint(2220, 258)
    ; Scroll handle in a scrollable panel
    ScrollHandle := cPoint(2220, 320)
    ; Notification arrow, left point of arrow when facing down
    NotifArrow := cPoint(69, 1212)
    ; Panel close button
    PanelClose := cPoint(2223, 193)
    ; Panel colour check
    PanelBG := cPoint(2183, 220)
    ; Aspect ratio check point lower left hide button
    AspectRatio1 := cPoint(58, 1323)
    ; Aspect ratio check point top right hide button
    AspectRatio2 := cPoint(2425, 51)
    ; Settings object to hold points for game settings panel
    Settings := {}
    ; Misc tab on settings (tab 6)
    Settings.MiscTab := cPoint(1776, 1179)
    ; Graphics tab on settings (tab )
    Settings.GraphicsTab := cPoint(887, 1179)
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