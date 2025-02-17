#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Dice points for buttons
 * @memberof module:cPoints
 * @property {cPoint} OpenCommon Open common Dices button
 * @property {cPoint} OpenRare Open rare Dices button
 * @property {cPoint} OpenLegend Open legendary Dices button
 * @property {cPoint} BuyCommon Buy common Dices button
 * @property {cPoint} BuyRare Buy rare Dices button
 * @property {cPoint} BuyLegend Buy legendary Dices button
 * @property {cPoint} OddsButton Odds button (Used to check, IsOnDicesFirstPanel)
 * @property {cDiceTabs} Tab Dice panel tabs
 */
Class cDicePoints {

    /** @type {cPoint} Show Count (Used to check, IsOnDicesFirstPanel) */
    ShowCount := cPoint(658, 1104)

    /** @type {cDiceTabs} Dice panel tabs */
    Tab := cDiceTabs()
}

/**
 * cDiceTabs cpoints for tabs of the Dices panel
 * @module cDiceTabs
 * @memberof module:cDicePoints
 * @property {cPoint} DiceBag DiceBag tab button
 * @property {cPoint} Battlefield Battlefield tab button
 * @property {cPoint} CursedDice CursedDice tab button
 * @property {cPoint} Shop Shop tab button
 * @property {cPoint} Codex Codex tab button
 * @property {cPoint} Enemies Enemies tab button
 * @property {cPoint} Options Options tab button
 */
Class cDiceTabs {
    /** @type {cPoint} DiceBag tab button */
    DiceBag := cPoint(293, 1178)

    /** @type {cPoint} Battlefield tab button */
    Battlefield := cPoint(575, 1177)

    /** @type {cPoint} CursedDice tab button */
    CursedDice := cPoint(856, 1181)

    /** @type {cPoint} Shop tab button */
    Shop := cPoint(1134, 1179)

    /** @type {cPoint} Codex tab button */
    Codex := cPoint(1416, 1182)

    /** @type {cPoint} Enemies tab button */
    Enemies := cPoint(1694, 1178)

    /** @type {cPoint} Options tab button */
    Options := cPoint(2226, 1173)
}
