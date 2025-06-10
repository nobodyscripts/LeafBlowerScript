#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Borbventures points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} BVTab First tab (Borbventures)
 * @property {cLBRButton} BorbsTab Second tab (Borbs)
 * @property {cLBRButton} InvTabs Third tab (Inventory)
 * @property {cLBRButton} PacksTab Fifth tab (Packs)
 * @property {cLBRButton} AutoStartFont0 Point for checking autostart status
 * with font size 0
 * @property {cLBRButton} AutoStartFont1 Point for checking autostart status
 * with font size 1
 * @property {cLBRButton} Detailed Detailed mode button for checks
 * @property {cLBRButton} ScaleMin Scale minimum button for checks
 * @property {cLBRButton} FinishAll Finish all completed quests button
 * @property {cLBRButton} PacksBuyCommon Buy Common pack with tokens button
 * @property {cLBRButton} PacksBuyRare Buy Rare pack with tokens button
 * @property {cLBRButton} PacksBuyLegendary Buy legendary pack with tokens button
 */
Class cBorbventuresPoints {
    /** @type {cLBRButton} First tab (Borbventures) */
    BVTab := cLBRButton(400, 1167)

    /** @type {cLBRButton} Second tab (Borbs) */
    BorbsTab := cLBRButton(630, 1167)

    /** @type {cLBRButton} Third tab (Inventory) */
    InvTab := cLBRButton(882, 1182)

    /** @type {cLBRButton} Packs tab */
    PacksTab := cLBRButton(1457, 1176)

    /** @type {cLBRButton} Point for checking autostart status with font size 0 */
    AutoStartFont0 := cLBRButton(586, 1097)

    /** @type {cLBRButton} Point for checking autostart status with font size 1 */
    AutoStartFont1 := cLBRButton(597, 1097)

    /** @type {cLBRButton} Detailed mode button for checks */
    Detailed := cLBRButton(1100, 314)

    /** @type {cLBRButton} Scale minimum button for checks */
    ScaleMin := cLBRButton(1574, 314)

    /** @type {cLBRButton} Finish all button */
    FinishAll := cLBRButton(1847, 1085)

    /** @type {cLBRButton} Buy Common pack with tokens button */
    PacksBuyCommon := cLBRButton(472, 952)

    /** @type {cLBRButton} Buy Rare pack with tokens button */
    PacksBuyRare := cLBRButton(1154, 952)

    /** @type {cLBRButton} Buy legendary pack with tokens button */
    PacksBuyLegendary := cLBRButton(1592, 952)
}
