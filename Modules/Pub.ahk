#Requires AutoHotkey v2.0

/**
 * Pub module for function collection
 * @module Pub
 * @method TradeForCheese250 
 * @method TradeForCheese2500 
 */
Class Pub {
    ;@region TradeForCheese250()
    /**
     * Description
     */
    TradeForCheese250() {
        UlcWindow()
        Out.D("PubTradeForCheese250")
        Travel.TheCheesePub.GoTo()
        Sleep(150)
        If (!Travel.TheCheesePub.IsZoneColour()) {
            Out.I("Didn't travel to cheese pub successfully, aborting.")
            Global ULCStageExit := true
            Return
        }
        BartenderBtn := cLBRButton(241, 741)
        Out.D("Clicking bartender")
        BartenderBtn.Click()
        Sleep(250)
        QuestsBtn := cLBRButton(1091, 380)
        QuestsBtn.WaitUntilActiveButtonS(5)
        Out.D("Clicking quest")
        If (!QuestsBtn.ClickButtonActive()) {
            Out.I("Didn't find quest button, aborting.")
            Global ULCStageExit := true
            Return
        }
        If (QuestsBtn.IsButtonActive()) {
            If (!QuestsBtn.ClickButtonActive()) {
                Out.I("Didn't find quest button, aborting.")
                Global ULCStageExit := true
                Return
            }
        }
        QuestCheese250Btn := cLBRButton(1702, 312)
        QuestCheese250Btn.WaitUntilActiveButtonS(5)
        Out.D("Clicking cheese quest")
        If (!QuestCheese250Btn.ClickButtonActive()) {
            Out.I("Didn't find cheese quest button, aborting.")
            Global ULCStageExit := true
            Return
        }
        QuestCheese250Btn.WaitUntilActiveButtonS(5)
        Out.D("Clicking cheese quest")
        If (!QuestCheese250Btn.ClickButtonActive()) {
            Out.I("Didn't find cheese quest button, aborting.")
            Global ULCStageExit := true
        }
    }
    ;@endregion

    ;@region TradeForCheese2500()
    /**
     * Description
     */
    TradeForCheese2500() {
        UlcWindow()
        Out.D("Trade For 2500 Cheese")
        Travel.TheCheesePub.GoTo()
        Sleep(150)
        If (!Travel.TheCheesePub.IsZoneColour()) {
            Out.I("Didn't travel to cheese pub successfully, aborting.")
            Global ULCStageExit := true
            Return
        }
        BartenderBtn := cLBRButton(241, 741)
        Out.D("Clicking bartender")
        BartenderBtn.Click()
        Sleep(250)
        QuestsBtn := cLBRButton(1091, 380)
        QuestsBtn.WaitUntilActiveButtonS(3)
        Out.D("Clicking quest")
        If (!QuestsBtn.ClickButtonActive()) {
            Out.I("Didn't find quest button, aborting.")
            Global ULCStageExit := true
            Return
        }
        QuestCheese2500Btn := cLBRButton(1695, 696)
        QuestCheese2500Btn.WaitUntilActiveButtonS(3)
        Out.D("Clicking cheese quest")
        If (!QuestCheese2500Btn.ClickButtonActive()) {
            Out.I("Didn't find cheese quest button, aborting.")
            Global ULCStageExit := true
            Return
        }
        QuestCheese2500Btn.WaitUntilActiveButtonS(3)
        Out.D("Clicking cheese quest")
        If (!QuestCheese2500Btn.ClickButtonActive()) {
            Out.I("Didn't find cheese quest button, aborting.")
            Global ULCStageExit := true
        }
    }
    ;@endregion
}
