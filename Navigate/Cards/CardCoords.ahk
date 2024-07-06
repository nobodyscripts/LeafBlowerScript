#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Card points for buttons
 * @memberof module:cPoints
 * @property {cPoint} PacksTab Point for first panel tab Packs
 * @property {cPoint} TranscendTab Point for second panel tab Transcend
 * @property {cPoint} OpenCommon Open common cards button
 * @property {cPoint} OpenRare Open rare cards button
 * @property {cPoint} OpenLegend Open legendary cards button
 * @property {cPoint} BuyCommon Buy common cards button
 * @property {cPoint} BuyRare Buy rare cards button
 * @property {cPoint} BuyLegend Buy legendary cards button
 */
Class cCardPoints {
    ; Point for first panel tab Packs
    PacksTab := cPoint(404, 1167)
    ; Point for second panel tab Transcend
    TranscendTab := cPoint(526, 1167)
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
}