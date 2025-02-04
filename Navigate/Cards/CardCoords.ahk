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
 * @property {cPoint} OddsButton Odds button (Used to check, IsOnCardsFirstPanel)
 * @property {cCardTabs} Tab Card panel tabs
 */
Class cCardPoints {
    /** @type {cPoint} Open common cards button */ 
    OpenCommon := cPoint(548, 807)
    
    /** @type {cPoint} Open rare cards button */ 
    OpenRare := cPoint(1108, 807)

    /** @type {cPoint} Open legendary cards button */ 
    OpenLegend := cPoint(1668, 807)

    /** @type {cPoint} Buy common cards button */ 
    BuyCommon := cPoint(456, 935)

    /** @type {cPoint} Buy rare cards button */ 
    BuyRare := cPoint(1016, 935)

    /** @type {cPoint} Buy legendary cards button */ 
    BuyLegend := cPoint(1576, 935)

    /** @type {cPoint} Odds button (Used to check, IsOnCardsFirstPanel) */ 
    OddsButton := cPoint(2129, 420)

    /** @type {cCardTabs} Card panel tabs */ 
    Tab := cCardTabs()
}

/**
 * cCardTabs cpoints for tabs of the cards panel
 * @module cCardTabs
 * @memberof module:cCardPoints
 * @property {cPoint} Packs Packs tab button
 * @property {cPoint} Transcend Transcend tab button
 * @property {cPoint} Common Common tab button
 * @property {cPoint} Uncommon Uncommon tab button
 * @property {cPoint} Rare Rare tab button
 * @property {cPoint} Epic Epic tab button
 * @property {cPoint} Mythical Mythical tab button
 * @property {cPoint} Legendary Legendary tab button
 * @property {cPoint} Options Options tab button
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