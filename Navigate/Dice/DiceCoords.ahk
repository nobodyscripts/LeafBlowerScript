#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Dice points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} OpenCommon Open common Dices button
 * @property {cLBRButton} OpenRare Open rare Dices button
 * @property {cLBRButton} OpenLegend Open legendary Dices button
 * @property {cLBRButton} BuyCommon Buy common Dices button
 * @property {cLBRButton} BuyRare Buy rare Dices button
 * @property {cLBRButton} BuyLegend Buy legendary Dices button
 * @property {cLBRButton} OddsButton Odds button (Used to check, IsOnDicesFirstPanel)
 * @property {cDiceTabs} Tab Dice panel tabs
 */
Class cDicePoints {

    /** @type {cLBRButton} Show Count (Used to check, IsOnDicesFirstPanel) */
    ShowCount := cLBRButton(658, 1104)

    /** @type {cDiceTabs} Dice panel tabs */
    Tab := cDiceTabs()
}

/**
 * cDiceTabs cLBRButtons for tabs of the Dices panel
 * @module cDiceTabs
 * @memberof module:cDicePoints
 * @property {cLBRButton} DiceBag DiceBag tab button
 * @property {cLBRButton} Battlefield Battlefield tab button
 * @property {cLBRButton} CursedDice CursedDice tab button
 * @property {cLBRButton} Shop Shop tab button
 * @property {cLBRButton} Codex Codex tab button
 * @property {cLBRButton} Enemies Enemies tab button
 * @property {cLBRButton} Options Options tab button
 */
Class cDiceTabs {
    /** @type {cLBRButton} DiceBag tab button */
    DiceBag := cLBRButton(293, 1178)

    /** @type {cLBRButton} Battlefield tab button */
    Battlefield := cLBRButton(575, 1177)

    /** @type {cLBRButton} CursedDice tab button */
    CursedDice := cLBRButton(856, 1181)

    /** @type {cLBRButton} Shop tab button */
    Shop := cLBRButton(1134, 1179)

    /** @type {cLBRButton} Codex tab button */
    Codex := cLBRButton(1416, 1182)

    /** @type {cLBRButton} Enemies tab button */
    Enemies := cLBRButton(1694, 1178)

    /** @type {cLBRButton} Options tab button */
    Options := cLBRButton(2226, 1173)
}
