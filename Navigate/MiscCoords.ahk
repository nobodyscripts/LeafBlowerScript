#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cRects.ahk

/**
 * Misc points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} ZoneSample Top left corner used for zone background
 * samples
 * @property {cLBRButton} BlankBG Top left corner blank spot to remove afk
 * @property {cLBRButton} ScrollArrow Top scroll arrow in a scrollable panel
 * @property {cLBRButton} ScrollHandle Scroll handle in a scrollable panel
 * @property {cLBRButton} NotifArrow Notification arrow, left point of 
 * arrow when facing down
 * @property {cLBRButton} PanelClose Panel close button
 * @property {cLBRButton} PanelBG Panel colour check
 * @property {cLBRButton} PanelBG2 Panel colour check (smoothed)
 * @property {cLBRButton} PanelBG3 Panel colour check (smoothed)
 * @property {cLBRButton} AspectRatio1 Aspect ratio check point lower left hide
 * button
 * @property {cLBRButton} AspectRatio2 Aspect ratio check point top right hide
 * button
 * @property {cMiscSettingPoints} Settings Points for the game settings panel
 * @property {cMiscPetPoints} Pets Points for the Pets panel
 */
Class cMiscPoints {
    /** @type {cLBRButton} Top left corner used for zone background samples */
    ZoneSample := cLBRButton(0, 0)
    /** @type {cLBRButton} Top left corner blank spot to remove afk */
    BlankBG := cLBRButton(10, 10)
    /** @type {cLBRButton} Top scroll arrow in a scrollable panel */
    ScrollArrow := cLBRButton(2220, 258)
    /** @type {cLBRButton} Scroll handle in a scrollable panel */
    ScrollHandle := cLBRButton(2220, 320)
    /** @type {cLBRButton} Notification arrow, left point of arrow when facing down */
    NotifArrow := cLBRButton(69, 1212)
    /** @type {cLBRButton} Notification arrow, blank area */
    NotifArrowExist := cLBRButton(61, 1235)
    /** @type {cLBRButton} Panel close button */
    PanelClose := cLBRButton(2223, 193)
    /** @type {cLBRButton} Panel colour check */
    PanelBG := cLBRButton(2183, 220)
    /** @type {cLBRButton} Panel colour check (smoothed) */
    PanelBG2 := cLBRButton(2193, 193)
    /** @type {cLBRButton} Panel colour check (smoothed) */
    PanelBG3 := cLBRButton(2193, 185)
    /** @type {cLBRButton} Aspect ratio check point lower left hide button */
    AspectRatio1 := cLBRButton(58, 1323)
    /** @type {cLBRButton} Aspect ratio check point top right hide button */
    AspectRatio2 := cLBRButton(2425, 51)
    /** @type {cMiscSettingPoints} Points for game settings panel */
    Settings := cMiscSettingPoints()
    /** @type {cMiscPetPoints} Points for Pets panel */
    Pets := cMiscPetPoints()
}

;@region cMiscSettingPoints
/**
 * Settings panel points
 * @memberof module:cMiscLBRButtons
 * @property {cLBRButton} MiscTab Misc tab on settings (tab 6)
 * @property {cLBRButton} GraphicsTab Graphics tab on settings (tab 3)
 */
Class cMiscSettingPoints {
    /** @type {cLBRButton} Misc tab on settings (tab 6) */
    MiscTab := cLBRButton(1776, 1179)
    /** @type {cLBRButton} Graphics tab on settings (tab 3) */
    GraphicsTab := cLBRButton(887, 1179)
}
;@endregion

;@region cMiscPetPoints
/**
 * Pet panel points
 * @memberof module:cMiscLBRButtons
 * @property {cLBRButton} PetsTab Pets tab on Pets Panel (tab 1)
 * @property {cLBRButton} TeamsTab Teams tab on Pets Panel (tab 2)
 */
Class cMiscPetPoints {
    /** @type {cLBRButton} Pets tab on Pets Panel (tab 1) */
    PetsTab := cLBRButton(550, 1165)
    /** @type {cLBRButton} Teams tab on Pets Panel (tab 2) */
    TeamsTab := cLBRButton(828, 1165)
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
