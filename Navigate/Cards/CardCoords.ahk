#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Card points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} OpenCommon Open common cards button
 * @property {cLBRButton} OpenRare Open rare cards button
 * @property {cLBRButton} OpenLegend Open legendary cards button
 * @property {cLBRButton} BuyCommon Buy common cards button
 * @property {cLBRButton} BuyRare Buy rare cards button
 * @property {cLBRButton} BuyLegend Buy legendary cards button
 * @property {cLBRButton} OddsButton Odds button (Used to check, IsOnCardsFirstPanel)
 * @property {cCardTabs} Tab Card panel tabs
 */
Class cCardPoints {
    /** @type {cLBRButton} Open common cards button */
    OpenCommon := cLBRButton(548, 807)

    /** @type {cLBRButton} Open rare cards button */
    OpenRare := cLBRButton(1108, 807)

    /** @type {cLBRButton} Open legendary cards button */
    OpenLegend := cLBRButton(1668, 807)

    /** @type {cLBRButton} Buy common cards button */
    BuyCommon := cLBRButton(456, 935)

    /** @type {cLBRButton} Buy rare cards button */
    BuyRare := cLBRButton(1016, 935)

    /** @type {cLBRButton} Buy legendary cards button */
    BuyLegend := cLBRButton(1576, 935)

    /** @type {cLBRButton} Odds button (Used to check, IsOnCardsFirstPanel) */
    OddsButton := cLBRButton(2129, 420)

    /** @type {cCardTabs} Card panel tabs */
    Tab := cCardTabs()
}

/**
 * cCardTabs cLBRButtons for tabs of the cards panel
 * @module cCardTabs
 * @memberof module:cCardPoints
 * @property {cLBRButton} Packs Packs tab button
 * @property {cLBRButton} Transcend Transcend tab button
 * @property {cLBRButton} Common Common tab button
 * @property {cLBRButton} Uncommon Uncommon tab button
 * @property {cLBRButton} Rare Rare tab button
 * @property {cLBRButton} Epic Epic tab button
 * @property {cLBRButton} Mythical Mythical tab button
 * @property {cLBRButton} Legendary Legendary tab button
 * @property {cLBRButton} Options Options tab button
 */
Class cCardTabs {
    /** @type {cLBRButton} Packs tab button */
    Packs := cLBRButton(404, 1167)

    /** @type {cLBRButton} Transcend tab button */
    Transcend := cLBRButton(526, 1167)

    /** @type {cLBRButton} Common tab button */
    Common := cLBRButton(730, 1167)

    /** @type {cLBRButton} Uncommon tab button */
    Uncommon := cLBRButton(950, 1167)

    /** @type {cLBRButton} Rare tab button */
    Rare := cLBRButton(1170, 1167)

    /** @type {cLBRButton} Epic tab button */
    Epic := cLBRButton(1381, 1167)

    /** @type {cLBRButton} Mythical tab button */
    Mythical := cLBRButton(1605, 1167)

    /** @type {cLBRButton} Legendary tab button */
    Legendary := cLBRButton(1820, 1167)

    /** @type {cLBRButton} Options tab button */
    Options := cLBRButton(2040, 1167)
}
