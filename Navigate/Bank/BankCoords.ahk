#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

;
/**
 * Bank points for buttons
 * @memberof module:cPoints
 * @property {cPoint} DepositRESS Point for depositing refined soul 
 * stone button
 * @property {cPoint} UpgradeStorage Point for Upgrade Storage button
 * @property {cPoint} TabLG Point for tab LG
 * @property {cPoint} TabSN Point for tab SN
 * @property {cPoint} TabEB Point for tab EB
 * @property {cPoint} TabFF Point for tab FF
 * @property {cPoint} TabSR Point for tab SR
 * @property {cPoint} TabQA Point for tab QA
 */
Class cBankPoints {
    DepositRESS := cPoint(1920, 460)
    UpgradeStorage := cPoint(1970, 555)
    TabLG := cPoint(600, 315)
    TabSN := cPoint(600, 375)
    TabEB := cPoint(600, 445)
    TabFF := cPoint(600, 510)
    TabSR := cPoint(600, 575)
    TabQA := cPoint(600, 635)
}