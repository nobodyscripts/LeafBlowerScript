#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine Vein points for buttons
 * @memberof module:cPoints
 * @property {cPoint} Search Mine Vein search button
 * @property {cPoint} AutoMine Mine Vein Auto Mine button
 * @property {cPoint} Upgrade Mine Vein Upgrade button
 * @property {cPoint} CancelConfirm Mine Vein Cancel confirm button
 * @property {cVeinSlot1Points} Slot1 Top left vein
 * @property {cVeinSlot2Points} Slot2 Top right vein
 * @property {cVeinSlot3Points} Slot3 Mid left vein
 * @property {cVeinSlot4Points} Slot4 Mid right vein
 * @property {cVeinSlot5Points} Slot5 Bottom left vein
 * @property {cVeinSlot6Points} Slot6 Bottom right vein
 */
Class cVeinPoints {
    /** @type {cPoint} */
    Search := cPoint(327, 353)
    /** @type {cPoint} */
    AutoMine := cPoint(1495, 288)
    /** @type {cPoint} */
    Upgrade := cPoint(840, 370)
    /** @type {cPoint} */
    CancelConfirm := cPoint(1190, 520) ; Formerly 1247 527, 1063, 505
    Slot1 := cVeinSlot1Points()
    Slot2 := cVeinSlot2Points()
    Slot3 := cVeinSlot3Points()
    Slot4 := cVeinSlot4Points()
    Slot5 := cVeinSlot5Points()
    Slot6 := cVeinSlot6Points()
}

;@region cVeinSlot1Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot1.Cancel Top left
 * @property {cPoint} Slot1.Colour Top left
 * @property {cPoint} Slot1.Enhance Top left
 * @property {cPoint} Slot1.Icon Top left
 */
Class cVeinSlot1Points {
    /** @type {cPoint} */
    Enhance := cPoint(1016, 575)
    /** @type {cPoint} */
    Colour := cPoint(410, 575)
    /** @type {cPoint} */
    Icon := cPoint(829, 561)
    /** @type {cPoint} */
    Cancel := cPoint(1140, 575)
}
;@endregion

;@region cVeinSlot2Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot2.Cancel Top right
 * @property {cPoint} Slot2.Colour Top right
 * @property {cPoint} Slot2.Enhance Top right
 * @property {cPoint} Slot2.Icon Top right
 */
Class cVeinSlot2Points {
    /** @type {cPoint} */
    Enhance := cPoint(1980, 575)
    /** @type {cPoint} */
    Colour := cPoint(1368, 575)
    /** @type {cPoint} */
    Icon := cPoint(1789, 561)
    /** @type {cPoint} */
    Cancel := cPoint(2100, 575)
}
;@endregion

;@region cVeinSlot3Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot3.Cancel Mid left
 * @property {cPoint} Slot3.Colour Mid left
 * @property {cPoint} Slot3.Enhance Mid left
 * @property {cPoint} Slot3.Icon Mid left
 */
Class cVeinSlot3Points {
    /** @type {cPoint} */
    Enhance := cPoint(1016, 725)
    /** @type {cPoint} */
    Colour := cPoint(410, 720)
    /** @type {cPoint} */
    Icon := cPoint(829, 711)
    /** @type {cPoint} */
    Cancel := cPoint(1140, 723)
}
;@endregion

;@region cVeinSlot4Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot4.Cancel Mid right
 * @property {cPoint} Slot4.Colour Mid right
 * @property {cPoint} Slot4.Enhance Mid right
 * @property {cPoint} Slot4.Icon Mid right
 */
Class cVeinSlot4Points {
    /** @type {cPoint} */
    Enhance := cPoint(1980, 725)
    /** @type {cPoint} */
    Colour := cPoint(1368, 720)
    /** @type {cPoint} */
    Icon := cPoint(1789, 711)
    /** @type {cPoint} */
    Cancel := cPoint(2100, 723)
}
;@endregion

;@region cVeinSlot5Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot5.Cancel Bottom left
 * @property {cPoint} Slot5.Colour Bottom left
 * @property {cPoint} Slot5.Enhance Bottom left
 * @property {cPoint} Slot5.Icon Bottom left
 */
Class cVeinSlot5Points {
    /** @type {cPoint} */
    Enhance := cPoint(1016, 870)
    /** @type {cPoint} */
    Colour := cPoint(410, 870)
    /** @type {cPoint} */
    Icon := cPoint(829, 860)
    /** @type {cPoint} */
    Cancel := cPoint(1140, 874)
}
;@endregion

;@region cVeinSlot6Points
/**
 * @memberof module:cVeinPoints
 * @property {cPoint} Slot6.Cancel Bottom right
 * @property {cPoint} Slot6.Colour Bottom right
 * @property {cPoint} Slot6.Enhance Bottom right
 * @property {cPoint} Slot6.Icon Bottom right
 */
Class cVeinSlot6Points {
    /** @type {cPoint} */
    Enhance := cPoint(1980, 870)
    /** @type {cPoint} */
    Colour := cPoint(1368, 870)
    /** @type {cPoint} */
    Icon := cPoint(1789, 860)
    /** @type {cPoint} */
    Cancel := cPoint(2100, 874)
}
;@endregion
