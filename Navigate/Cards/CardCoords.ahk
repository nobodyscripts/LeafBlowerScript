#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Card points for buttons
 * @memberof module:cPoints
 * @property {cPoint} OpenCommon Open common cards button
 * @property {cPoint} OpenRare Open rare cards button
 * @property {cPoint} OpenLegend Open legendary cards button
 * @property {cPoint} BuyCommon Buy common cards button
 * @property {cPoint} BuyRare Buy rare cards button
 * @property {cPoint} BuyLegend Buy legendary cards button
 */
Class cCardPoints {
    ; Open common cards button
    OpenCommon := cPoint(548, 807)
    ; Open rare cards button
    OpenRare := cPoint(1108, 807)
    ; Open legendary cards button
    OpenLegend := cPoint(1668, 807)
    ; Buy common cards button
    BuyCommon := cPoint(456, 935)
    ; Buy rare cards button
    BuyRare := cPoint(1016, 935)
    ; Buy legendary cards button
    BuyLegend := cPoint(1576, 935)
    ; Odds button (Used to check, IsOnCardsFirstPanel)
    OddsButton := cPoint(2129, 420)
    ; Card panel tabs
    Tab := cCardTabs()
}

/**
 * cCardTabs cpoints for tabs of the cards panel
 * @module cCardTabs
 * @memberof module:cCardPoints
 * @property {cPoint} property Desc
 */
Class cCardTabs {
    /** @type {cPoint} Packs tab button */
    Packs := cPoint(404, 1167)
    /** @type {cPoint} Transcend tab button */
    Transcend := cPoint(526, 1167)
    /** @type {cPoint} Common tab button */
    Common := cPoint(730, 1167)
    /** @type {cPoint} Uncommon tab button */
    Uncommon := cPoint(950, 1167)
    /** @type {cPoint} Rare tab button */
    Rare := cPoint(1170, 1167)
    /** @type {cPoint} Epic tab button */
    Epic := cPoint(1381, 1167)
    /** @type {cPoint} Mythical tab button */
    Mythical := cPoint(1605, 1167)
    /** @type {cPoint} Legendary tab button */
    Legendary := cPoint(1820, 1167)
    /** @type {cPoint} Options tab button */
    Options := cPoint(2040, 1167)
}