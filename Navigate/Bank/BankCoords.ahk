#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Bank points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} DepositRESS Point for depositing refined soul 
 * stone button
 * @property {cLBRButton} UpgradeStorage Point for Upgrade Storage button
 * @property {cLBRButton} TabLG Point for tab LG
 * @property {cLBRButton} TabSN Point for tab SN
 * @property {cLBRButton} TabEB Point for tab EB
 * @property {cLBRButton} TabFF Point for tab FF
 * @property {cLBRButton} TabSR Point for tab SR
 * @property {cLBRButton} TabQA Point for tab QA
 */
Class cBankPoints {
    DepositRESS := cLBRButton(1920, 460)
    UpgradeStorage := cLBRButton(1970, 555)
    TabLG := cLBRButton(600, 315)
    TabSN := cLBRButton(600, 375)
    TabEB := cLBRButton(600, 445)
    TabFF := cLBRButton(600, 510)
    TabSR := cLBRButton(600, 575)
    TabQA := cLBRButton(600, 635)
}
