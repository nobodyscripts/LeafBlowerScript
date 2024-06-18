#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine Vein points for buttons
 * @property {cPoint} Search Mine Vein search button
 * @property {cPoint} AutoMine Mine Vein Auto Mine button
 * @property {cPoint} Upgrade Mine Vein Upgrade button
 * @property {cPoint} CancelConfirm Mine Vein Cancel confirm button
 * @property {cPoint} Slot1.Cancel Top left
 * @property {cPoint} Slot1.Colour Top left
 * @property {cPoint} Slot1.Enhance Top left
 * @property {cPoint} Slot1.Icon Top left
 * @property {cPoint} Slot2.Cancel Top right
 * @property {cPoint} Slot2.Colour Top right
 * @property {cPoint} Slot2.Enhance Top right
 * @property {cPoint} Slot2.Icon Top right
 * @property {cPoint} Slot3.Cancel Mid left
 * @property {cPoint} Slot3.Colour Mid left
 * @property {cPoint} Slot3.Enhance Mid left
 * @property {cPoint} Slot3.Icon Mid left
 * @property {cPoint} Slot4.Cancel Mid right
 * @property {cPoint} Slot4.Colour Mid right
 * @property {cPoint} Slot4.Enhance Mid right
 * @property {cPoint} Slot4.Icon Mid right
 * @property {cPoint} Slot5.Cancel Bottom left
 * @property {cPoint} Slot5.Colour Bottom left
 * @property {cPoint} Slot5.Enhance Bottom left
 * @property {cPoint} Slot5.Icon Bottom left
 * @property {cPoint} Slot6.Cancel Bottom right
 * @property {cPoint} Slot6.Colour Bottom right
 * @property {cPoint} Slot6.Enhance Bottom right
 * @property {cPoint} Slot6.Icon Bottom right
 */
Class cVeinPoints {
    Search := cPoint(327, 353)
    AutoMine := cPoint(1495, 288)
    Upgrade := cPoint(840, 370)
    CancelConfirm := cPoint(1190, 520) ; Formerly 1247 527, 1063, 505
    Slot1 := {}
    Slot2 := {}
    Slot3 := {}
    Slot4 := {}
    Slot5 := {}
    Slot6 := {}
    Slot1.Enhance := cPoint(1016, 575)
    Slot2.Enhance := cPoint(1980, 575)
    Slot3.Enhance := cPoint(1016, 725)
    Slot4.Enhance := cPoint(1980, 725)
    Slot5.Enhance := cPoint(1016, 870)
    Slot6.Enhance := cPoint(1980, 870)
    Slot1.Colour := cPoint(410, 575)
    Slot2.Colour := cPoint(1368, 575)
    Slot3.Colour := cPoint(410, 720)
    Slot4.Colour := cPoint(1368, 720)
    Slot5.Colour := cPoint(410, 870)
    Slot6.Colour := cPoint(1368, 870)
    Slot1.Icon := cPoint(829, 561)
    Slot2.Icon := cPoint(1789, 561)
    Slot3.Icon := cPoint(829, 711)
    Slot4.Icon := cPoint(1789, 711)
    Slot5.Icon := cPoint(829, 860)
    Slot6.Icon := cPoint(1789, 860)
    Slot1.Cancel := cPoint(1140, 575)
    Slot2.Cancel := cPoint(2100, 575)
    Slot3.Cancel := cPoint(1140, 723)
    Slot4.Cancel := cPoint(2100, 723)
    Slot5.Cancel := cPoint(1140, 874)
    Slot6.Cancel := cPoint(2100, 874)
}