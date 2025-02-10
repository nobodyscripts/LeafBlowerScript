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
    /** @type {cPoint} Top left corner used for zone background samples */
    ZoneSample := cPoint(0, 0)
    /** @type {cPoint} Top left corner blank spot to remove afk */
    BlankBG := cPoint(10, 10)
    /** @type {cPoint} Top scroll arrow in a scrollable panel */
    ScrollArrow := cPoint(2220, 258)
    /** @type {cPoint} Scroll handle in a scrollable panel */
    ScrollHandle := cPoint(2220, 320)
    /** @type {cPoint} Notification arrow, left point of arrow when facing down */
    NotifArrow := cPoint(69, 1212)
    /** @type {cPoint} Notification arrow, blank area */
    NotifArrowExist := cPoint(61, 1235)
    /** @type {cPoint} Panel close button */
    PanelClose := cPoint(2223, 193)
    /** @type {cPoint} Panel colour check */
    PanelBG := cPoint(2183, 220)
    /** @type {cPoint} Panel colour check (smoothed) */
    PanelBG2 := cPoint(2193, 193)
    /** @type {cPoint} Panel colour check (smoothed) */
    PanelBG3 := cPoint(2193, 185)
    /** @type {cPoint} Aspect ratio check point lower left hide button */
    AspectRatio1 := cPoint(58, 1323)
    /** @type {cPoint} Aspect ratio check point top right hide button */
    AspectRatio2 := cPoint(2425, 51)
    /** @type {cMiscSettingPoints} Points for game settings panel */
    Settings := cMiscSettingPoints()
    /** @type {cMiscPetPoints} Points for Pets panel */
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
    /** @type {cPoint} Misc tab on settings (tab 6) */
    MiscTab := cPoint(1776, 1179)
    /** @type {cPoint} Graphics tab on settings (tab 3) */
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
    /** @type {cPoint} Pets tab on Pets Panel (tab 1) */
    PetsTab := cPoint(550, 1165)
    /** @type {cPoint} Teams tab on Pets Panel (tab 2) */
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
    /** @type {cRect} Area boss timer text is displayed */
    BossTimer := cRect(1240, 5, 1280, 40)
    /** @type {cRect} Area extended boss timer text is  displayed */
    BossTimerLong := cRect(1050, 5, 1100, 40)
    /** @type {cRect} Area to the right of the current floor, blank when <100 */
    FloorAmount100 := cRect(1383, 149, 1409, 173)
}

/**
 * Shop areas
 * @memberof module:cMiscRects
 * @property {cRect} AutoFacts Area covering (bought) text
 */
Class cMLCShopRects {
    /** @type {cRect} */
    AutoFacts := cRect(531, 864, 654, 887)

    /** @type {cRect} */
    CrunchySeeds := cRect(656, 640, 775, 661)

    /** @type {cRect} */
    PoweredALB := cRect(664, 978, 777, 999)
}
