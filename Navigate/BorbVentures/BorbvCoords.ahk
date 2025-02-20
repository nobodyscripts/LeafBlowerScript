#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Borbventures points for buttons
 * @memberof module:cPoints
 * @property {cPoint} BVTab First tab (Borbventures)
 * @property {cPoint} BorbsTab Second tab (Borbs)
 * @property {cPoint} InvTabs Third tab (Inventory)
 * @property {cPoint} PacksTab Fifth tab (Packs)
 * @property {cPoint} AutoStartFont0 Point for checking autostart status
 * with font size 0
 * @property {cPoint} AutoStartFont1 Point for checking autostart status
 * with font size 1
 * @property {cPoint} Detailed Detailed mode button for checks
 * @property {cPoint} ScaleMin Scale minimum button for checks
 * @property {cPoint} FinishAll Finish all completed quests button
 * @property {cPoint} PacksBuyCommon Buy Common pack with tokens button
 * @property {cPoint} PacksBuyRare Buy Rare pack with tokens button
 * @property {cPoint} PacksBuyLegendary Buy legendary pack with tokens button
 */
Class cBorbventuresPoints {
    /** @type {cPoint} First tab (Borbventures) */
    BVTab := cPoint(400, 1167)

    /** @type {cPoint} Second tab (Borbs) */
    BorbsTab := cPoint(630, 1167)

    /** @type {cPoint} Third tab (Inventory) */
    InvTab := cPoint(882, 1182)

    /** @type {cPoint} Packs tab */
    PacksTab := cPoint(1457, 1176)

    /** @type {cPoint} Point for checking autostart status with font size 0 */
    AutoStartFont0 := cPoint(586, 1097)

    /** @type {cPoint} Point for checking autostart status with font size 1 */
    AutoStartFont1 := cPoint(597, 1097)

    /** @type {cPoint} Detailed mode button for checks */
    Detailed := cPoint(1100, 314)

    /** @type {cPoint} Scale minimum button for checks */
    ScaleMin := cPoint(1574, 314)

    /** @type {cPoint} Finish all button */
    FinishAll := cPoint(1847, 1085)

    /** @type {cPoint} Buy Common pack with tokens button */
    PacksBuyCommon := cPoint(472, 952)

    /** @type {cPoint} Buy Rare pack with tokens button */
    PacksBuyRare := cPoint(1154, 952)

    /** @type {cPoint} Buy legendary pack with tokens button */
    PacksBuyLegendary := cPoint(1592, 952)
}