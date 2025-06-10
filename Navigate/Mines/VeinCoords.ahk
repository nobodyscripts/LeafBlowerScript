#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine Vein points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} Search Mine Vein search button
 * @property {cLBRButton} AutoMine Mine Vein Auto Mine button
 * @property {cLBRButton} Upgrade Mine Vein Upgrade button
 * @property {cLBRButton} CancelConfirm Mine Vein Cancel confirm button
 * @property {cVeinSlot1Points} Slot1 Top left vein
 * @property {cVeinSlot2Points} Slot2 Top right vein
 * @property {cVeinSlot3Points} Slot3 Mid left vein
 * @property {cVeinSlot4Points} Slot4 Mid right vein
 * @property {cVeinSlot5Points} Slot5 Bottom left vein
 * @property {cVeinSlot6Points} Slot6 Bottom right vein
 */
Class cVeinPoints {
    /** @type {cLBRButton} */
    Search := cLBRButton(327, 353)
    /** @type {cLBRButton} */
    AutoMine := cLBRButton(1495, 288)
    /** @type {cLBRButton} */
    Upgrade := cLBRButton(840, 370)
    /** @type {cLBRButton} */
    CancelConfirm := cLBRButton(1211, 566)
    /** @type {cVeinSlot1Points} */
    Slot1 := cVeinSlot1Points()
    /** @type {cVeinSlot2Points} */
    Slot2 := cVeinSlot2Points()
    /** @type {cVeinSlot3Points} */
    Slot3 := cVeinSlot3Points()
    /** @type {cVeinSlot4Points} */
    Slot4 := cVeinSlot4Points()
    /** @type {cVeinSlot5Points} */
    Slot5 := cVeinSlot5Points()
    /** @type {cVeinSlot6Points} */
    Slot6 := cVeinSlot6Points()
}

;@region cVeinSlot1Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot1.Cancel Top left
 * @property {cLBRButton} Slot1.Colour Top left
 * @property {cLBRButton} Slot1.Enhance Top left
 * @property {cLBRButton} Slot1.Icon Top left
 */
Class cVeinSlot1Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1016, 575)
    /** @type {cLBRButton} */
    Colour := cLBRButton(410, 575)
    /** @type {cLBRButton} */
    Icon := cLBRButton(829, 561)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(1140, 575)
}
;@endregion

;@region cVeinSlot2Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot2.Cancel Top right
 * @property {cLBRButton} Slot2.Colour Top right
 * @property {cLBRButton} Slot2.Enhance Top right
 * @property {cLBRButton} Slot2.Icon Top right
 */
Class cVeinSlot2Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1980, 575)
    /** @type {cLBRButton} */
    Colour := cLBRButton(1368, 575)
    /** @type {cLBRButton} */
    Icon := cLBRButton(1789, 561)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(2100, 575)
}
;@endregion

;@region cVeinSlot3Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot3.Cancel Mid left
 * @property {cLBRButton} Slot3.Colour Mid left
 * @property {cLBRButton} Slot3.Enhance Mid left
 * @property {cLBRButton} Slot3.Icon Mid left
 */
Class cVeinSlot3Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1016, 725)
    /** @type {cLBRButton} */
    Colour := cLBRButton(410, 720)
    /** @type {cLBRButton} */
    Icon := cLBRButton(829, 711)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(1140, 723)
}
;@endregion

;@region cVeinSlot4Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot4.Cancel Mid right
 * @property {cLBRButton} Slot4.Colour Mid right
 * @property {cLBRButton} Slot4.Enhance Mid right
 * @property {cLBRButton} Slot4.Icon Mid right
 */
Class cVeinSlot4Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1980, 725)
    /** @type {cLBRButton} */
    Colour := cLBRButton(1368, 720)
    /** @type {cLBRButton} */
    Icon := cLBRButton(1789, 711)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(2100, 723)
}
;@endregion

;@region cVeinSlot5Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot5.Cancel Bottom left
 * @property {cLBRButton} Slot5.Colour Bottom left
 * @property {cLBRButton} Slot5.Enhance Bottom left
 * @property {cLBRButton} Slot5.Icon Bottom left
 */
Class cVeinSlot5Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1016, 870)
    /** @type {cLBRButton} */
    Colour := cLBRButton(410, 870)
    /** @type {cLBRButton} */
    Icon := cLBRButton(829, 860)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(1140, 874)
}
;@endregion

;@region cVeinSlot6Points
/**
 * @memberof module:cVeinPoints
 * @property {cLBRButton} Slot6.Cancel Bottom right
 * @property {cLBRButton} Slot6.Colour Bottom right
 * @property {cLBRButton} Slot6.Enhance Bottom right
 * @property {cLBRButton} Slot6.Icon Bottom right
 */
Class cVeinSlot6Points {
    /** @type {cLBRButton} */
    Enhance := cLBRButton(1980, 870)
    /** @type {cLBRButton} */
    Colour := cLBRButton(1368, 870)
    /** @type {cLBRButton} */
    Icon := cLBRButton(1789, 860)
    /** @type {cLBRButton} */
    Cancel := cLBRButton(2100, 874)
}
;@endregion
