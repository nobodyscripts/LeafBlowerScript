#Requires AutoHotkey v2.0

#include ..\ScriptLib\cToolTip.ahk

Global ULCStageExit := false

GetDailyReward(*) {
    UlcWindow()
    Out.D("Get Daily Reward")
    Travel.ClosePanelIfActive()
    cLBRButton(710, 139).Click()
    Sleep(100)
    cLBRButton(664, 420).ClickButtonActive()
    cLBRButton(664, 420).ClickButtonActive()
}

WaitForFloor100(*) {
    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownM(2, &isactive)
    gToolTip.Center("Waiting for floor 100 to be reached")
    Out.D("Waiting for floor 100 to be reached")
    While (!Rects.Misc.FloorAmount100.PixelSearch() && isactive &&
    Window.IsActive()) {
        Sleep(100)
    }
    If (!Rects.Misc.FloorAmount100.PixelSearch()) {
        Out.I("Timed out checking for floor 100, aborting.")
        Global ULCStageExit := true
    }
    gToolTip.CenterDel()
}

TriggerLC(*) {
    prestigeButton := cLBRButton(1393, 551)
    UlcWindow()
    Out.D("TriggerLC")
    Shops.OpenGoldPortal()
    prestigeButton.WaitUntilActiveButtonS(3)
    If (!prestigeButton.IsButtonActive()) {
        Out.I("Didn't find lc crunch button, aborting.")
        Global ULCStageExit := true
        Return false
    }
    prestigeButton.ClickButtonActive()
    prestigeButton.ClickButtonActive()
    Sleep(150)
    Return true
}

TriggerBLC(*) {
    UlcWindow()
    Out.D("TriggerBLC")
    Shops.OpenRedPortal()
    /** @type {cLBRButton} */
    crunchbtn := cLBRButton(1337, 558)
    crunchbtn.WaitUntilActiveButtonS(3)
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find blc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    crunchbtn.WaitUntilActiveButtonS(2)
    crunchbtn.ClickButtonActive()
    Sleep(34)
    crunchbtn.ClickButtonActive()
    Sleep(150)
}

TriggerMLC(*) {
    UlcWindow()
    crunchbtn := cLBRButton(1329, 563)
    Out.D("TriggerMLC")
    Shops.OpenGreenPortal()
    crunchbtn.WaitUntilActiveButtonS(3)
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find mlc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    crunchbtn.WaitUntilActiveButtonS(2)
    crunchbtn.ClickButtonActive()
    Sleep(34)
    crunchbtn.ClickButtonActive()
    Sleep(150)
}

TriggerMLCConverters(*) {
    TriggerMLC()
    Out.D("TriggerMLCConverters")
    WaitForPortalAnimation()
    Shops.OpenConverters()
    Sleep(50)
    /** @type {cLBRButton} */
    StartConvertorsBtn := cLBRButton(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButtonS(5)
    Sleep(17)
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Out.I("Didn't find converter start button, aborting.")
        Global ULCStageExit := true
    }
}

ActivateConverters(*) {
    UlcWindow()
    Out.D("ActivateConverters")
    GameKeys.OpenConverters()
    StartConvertorsBtn := cLBRButton(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButtonS(3)
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Out.I("Didn't find converter start button, exiting.")
        Global ULCStageExit := true
    }
}

WaitForPortalAnimation(*) {
    UlcWindow()
    Out.D("WaitForPortalAnimation")
    gToolTip.Center("Waiting for portal animation to finish")
    Points.Misc.NotifArrowExist.WaitUntilActiveButtonS(20)
    Sleep(200)
    If (!Points.Misc.NotifArrowExist.IsButtonActive()) {
        Out.I("Failed to see ui after portal animation")
        Global ULCStageExit := true
    }
    gToolTip.CenterDel()
}

WaitForBLCPortal(*) {
    ; wait for blc to be available after second mlc
    UlcWindow()
    Travel.ClosePanelIfActive()
    Out.D("WaitForBLCPortal")
    /** @type {cLBRButton} */
    BlackFlaskStoreBtn := cLBRButton(828, 1225)
    /** @type {cLBRButton} */
    BuyBLCBtn := cLBRButton(1700, 304)
    /** @type {cLBRButton} */
    BLCBtn := cLBRButton(1063, 1220)

    Out.D("Waiting for flask button")
    gToolTip.Center("Waiting for black flask shop to be active")
    ; Out.D("Black flask button colour " BlackFlaskStoreBtn.GetColour())
    BlackFlaskStoreBtn.WaitUntilActiveButtonS(90)
    If (BlackFlaskStoreBtn.GetColour() = "0xFEF1D2" || BlackFlaskStoreBtn.IsButtonActive()) {
        BlackFlaskStoreBtn.ClickOffset(, , 50)
        Sleep(72)
        If (!Window.IsPanel()) {
            BlackFlaskStoreBtn.ClickOffset(, , 50)
            Sleep(72)
        }
    }
    gToolTip.CenterDel()
    gToolTip.Center("Waiting for buy blc to be active")
    Out.D("Waiting for buy blc button")
    If (!BuyBLCBtn.IsBackground()) {
        BuyBLCBtn.WaitUntilActiveButtonS(10)
        If (!BuyBLCBtn.IsButtonActive()) {
            BlackFlaskStoreBtn.ClickOffset(, , 50)
            BuyBLCBtn.WaitUntilActiveButtonS(2)
        }
        BuyBLCBtn.ClickButtonActive(, , 50, 34)
        BuyBLCBtn.ClickButtonActive(, , 50, 34)
    }

    colour := "0xFFC2B3"
    gToolTip.CenterDel()
    gToolTip.Center("Waiting for blc portal to be active")
    Out.D("Waiting for blc portal button")
    BLCBtn.WaitWhileNotColour(colour, 4800, 17) ; 120s
    If (BLCBtn.GetColour() != colour) {
        Out.I("Timed out waiting for blc portal, aborting.")
        Global ULCStageExit := true
    }
    Out.I("Blc Portal found")
    gToolTip.CenterDel()
}

WaitTillPyramidReset(*) {
    UlcWindow()
    Out.D("WaitTillPyramidReset")
    gToolTip.Center("Waiting for pyramid to reset zone")
    colour := Colours().GetColourByZone("The Cursed Pyramid")
    Points.Misc.ZoneSample.WaitWhileNotColour(colour, 1200, 50) ; 60s
    If (Points.Misc.ZoneSample.IsColour(colour)) {
        Out.I("Timed out waiting for pyramid to clear, "
            "taxi may have already been bought.")
    }
    gToolTip.CenterDel()
}

PubTradeForCheese250(*) { ; TODO add option to use 250 instead of 2500 cheese
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

PubTradeForCheese2500(*) {
    UlcWindow()
    Out.D("PubTradeForCheese2500")
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

IsULCCraftSaved() {
    ; TODO
    Out.D("TODO IsULCCraftSaved")
    ; can be grabbed from profiles.def.objects.o_game.data.ulc_settings
}

WaitForAncients(*) {
    UlcWindow()
    ; TODO
    Out.D("TODO WaitForAncients")

}

CraftMoonLeafsAndPreset() {
    UlcWindow()
    ; TODO
    Out.D("TODO CraftMoonLeafsAndPreset")

}
