#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk

/**
 * Misc points for buttons
 * @memberof module:cPoints
 * @property {cPoint} ZoneSample Top left corner used for zone background
 * samples
 * @property {cPoint} BlankBG Top left corner blank spot to remove afk
 * @property {cPoint} ScrollArrow Top scroll arrow in a scrollable panel
 * @property {cPoint} ScrollHandle Scroll handle in a scrollable panel
 * @property {cPoint} NotifArrow Notification arrow, left point of 
 * arrow when facing down
 * @property {cPoint} PanelClose Panel close button
 * @property {cPoint} PanelBG Panel colour check
 * @property {cPoint} PanelBG2 Panel colour check (smoothed)
 * @property {cPoint} PanelBG3 Panel colour check (smoothed)
 * @property {cPoint} AspectRatio1 Aspect ratio check point lower left hide
 * button
 * @property {cPoint} AspectRatio2 Aspect ratio check point top right hide
 * button
 * @property {cMiscSettingPoints} Settings Points for the game settings panel
 * @property {cMiscPetPoints} Pets Points for the Pets panel
 */
Class cMiscPoints {
    ; Top left corner used for zone background samples
    ZoneSample := cPoint(0, 0)
    ; Top left corner blank spot to remove afk
    BlankBG := cPoint(10, 10)
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
    ; Panel colour check (smoothed)
    PanelBG2 := cPoint(2193, 193)
    ; Panel colour check (smoothed)
    PanelBG3 := cPoint(2193, 185)
    ; Aspect ratio check point lower left hide button
    AspectRatio1 := cPoint(58, 1323)
    ; Aspect ratio check point top right hide button
    AspectRatio2 := cPoint(2425, 51)
    ; Points for game settings panel
    Settings := cMiscSettingPoints()
    ; Points for Pets panel
    Pets := cMiscPetPoints()
}

;@region cMiscSettingPoints
/**
 * Settings panel points
 * @memberof module:cMiscPoints
 * @property {cPoint} MiscTab Misc tab on settings (tab 6)
 * @property {cPoint} GraphicsTab Graphics tab on settings (tab 3)
 */
Class cMiscSettingPoints {
    ; Misc tab on settings (tab 6)
    MiscTab := cPoint(1776, 1179)
    ; Graphics tab on settings (tab 3)
    GraphicsTab := cPoint(887, 1179)
}
;@endregion

;@region cMiscPetPoints
/**
 * Pet panel points
 * @memberof module:cMiscPoints
 * @property {cPoint} PetsTab Pets tab on Pets Panel (tab 1)
 * @property {cPoint} TeamsTab Teams tab on Pets Panel (tab 2)
 */
Class cMiscPetPoints {
    ; Pets tab on Pets Panel (tab 1)
    PetsTab := cPoint(550, 1165)
    ; Teams tab on Pets Panel (tab 2)
    TeamsTab := cPoint(828, 1165)
}
;@endregion

/**
 * Misc areas
 * @memberof module:cRects
 * @property {cRect} BossTimer Area boss timer text is displayed
 * @property {cRect} BossTimerLong Area extended boss timer text is 
 * displayed
 */
Class cMiscRects {
    ; Area boss timer text is displayed
    BossTimer := cRect(1240, 5, 1280, 40)
    ; Area extended boss timer text is  displayed
    BossTimerLong := cRect(1050, 5, 1100, 40)
}