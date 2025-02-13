#Requires AutoHotkey v2.0

Global ULCStageExit := false

GetDailyReward(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    cPoint(710, 139).Click()
    Sleep(100)
    cPoint(664, 420).ClickButtonActive()
    cPoint(664, 420).ClickButtonActive()
}

WaitForFloor100(*) {
    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownM(2, &isactive)
    text := cPoint(1144, 609)
    text.TextTipAtCoord("Waiting for blc portal to be active")
    While (!Rects.Misc.FloorAmount100.PixelSearch() && isactive) {
        Sleep(100)
    }
    If (!Rects.Misc.FloorAmount100.PixelSearch()) {
        Out.I("Timed out checking for floor 100, aborting.")
        Global ULCStageExit := true
    }
    ToolTip(, , , 15)
}

TriggerBLC(*) {
    UlcWindow()
    Out.D("TriggerBLC")
    Shops.OpenRedPortal()
    crunchbtn := cPoint(1109, 553)
    confirmbtn := cPoint(1131, 525)
    crunchbtn.WaitUntilActiveButton()
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find blc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    Sleep(17)
    crunchbtn.ClickButtonActive()
    Sleep(150)
    If (!confirmbtn.IsButtonActive()) {
        Out.I("Didn't find blc confirm button, aborting.")
        Global ULCStageExit := true
    }
    confirmbtn.ClickButtonActive()
    Sleep(17)
    confirmbtn.ClickButtonActive()
}

TriggerMLC(*) {
    UlcWindow()
    crunchbtn := cPoint(1111, 549)
    confirmbtn := cPoint(1111, 524)
    Out.D("TriggerMLC")
    Shops.OpenGreenPortal()
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find mlc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    Sleep(17)
    crunchbtn.ClickButtonActive()
    Sleep(150)
    If (!confirmbtn.IsButtonActive()) {
        Out.I("Didn't find mlc confirm button, aborting.")
        Global ULCStageExit := true
    }
    confirmbtn.ClickButtonActive()
    Sleep(17)
    confirmbtn.ClickButtonActive()
}

TriggerMLCConverters(*) {
    TriggerMLC()
    Out.D("TriggerMLCConverters")
    WaitForPortalAnimation()
    Shops.OpenConverters()
    /** @type {cPoint} */
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButton(100,50)
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Out.I("Didn't find converter start button, aborting.")
        Global ULCStageExit := true
    }
}

ActivateConverters(*) {
    UlcWindow()
    Out.D("ActivateConverters")
    GameKeys.OpenConverters()
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButton()
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Out.I("Didn't find converter start button, exiting.")
        Global ULCStageExit := true
    }
}

WaitForPortalAnimation(*) {
    UlcWindow()
    Out.D("WaitForPortalAnimation")
    Sleep(500)
    Points.Misc.NotifArrowExist.WaitUntilActiveButton(300, 100) ; 20s
    Sleep(500)
    If (!Points.Misc.NotifArrowExist.IsButtonActive()) {
        Out.I("Failed to see ui after portal animation")
        Global ULCStageExit := true
    }
}

WaitForBLCPortal(*) {
    ; wait for blc to be available after second mlc
    UlcWindow()
    ; TODO Speed this up by waiting in black flask and buying blc portal
    Out.D("WaitForBLCPortal")
    /** @type {cPoint} */
    text := cPoint(1144, 609)
    text.TextTipAtCoord("Waiting for blc portal to be active")

    /** @type {cPoint} */
    BLCBtn := cPoint(1063, 1220)
    colour := "0xFFC2B3"
    BLCBtn.WaitWhileNotColour(colour, 2400, 100) ; 120s
    If (BLCBtn.GetColour() != colour) {
        Out.I("Timed out waiting for blc portal, aborting.")
        Global ULCStageExit := true
    }
    Out.I("Blc Portal found")
    Tooltip(, , , 15)
}

WaitTillPyramidReset(*) {
    UlcWindow()
    Out.D("WaitTillPyramidReset")
    text := cPoint(1144, 609)
    text.TextTipAtCoord("Waiting for pyramid to reset zone")
    colour := Colours().GetColourByZone("The Inner Cursed Pyramid")
    Points.Misc.ZoneSample.WaitWhileNotColour(colour, 600, 50) ; 30s
    if (Points.Misc.ZoneSample.IsColour(colour)) {
        Out.I("Timed out waiting for pyramid to clear, "
    "taxi may have already been bought.")
    }
    ToolTip(, , , 15)
}

PubTradeForCheese25000(*) {
    UlcWindow()
    Out.D("PubTradeForCheese25000")
    Travel.TheCheesePub.GoTo()
    Sleep(150)
    If (!Travel.TheCheesePub.IsZoneColour()) {
        Out.I("Didn't travel to cheese pub successfully, aborting.")
        Global ULCStageExit := true
        Return
    }
    BartenderBtn := cPoint(241, 741)
    Out.D("Clicking bartender")
    BartenderBtn.Click()
    Sleep(250)
    QuestsBtn := cPoint(1091, 380)
    QuestsBtn.WaitUntilActiveButton()
        Out.D("Clicking quest")
    If (!QuestsBtn.ClickButtonActive()) {
        Out.I("Didn't find quest button, aborting.")
        Global ULCStageExit := true
        Return
    }
    QuestCheese250Btn := cPoint(1702, 312)
    QuestCheese250Btn.WaitUntilActiveButton()
    Out.D("Clicking cheese quest")
    If (!QuestCheese250Btn.ClickButtonActive()) {
        Out.I("Didn't find cheese quest button, aborting.")
        Global ULCStageExit := true
        Return
    }
    QuestCheese250Btn.WaitUntilActiveButton()
    Out.D("Clicking cheese quest")
    If (!QuestCheese250Btn.ClickButtonActive()) {
        Out.I("Didn't find cheese quest button, aborting.")
        Global ULCStageExit := true
    }
}

Use30minTimeWarp(*) {
    UlcWindow()
    Out.D("Use30minTimeWarp")
    TTtab := cPoint(1810, 1177)
    BuyTW := cPoint(1592, 306)
    AvailableTW := cPoint(1744, 306)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    BuyTW.WaitUntilActiveButton()

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive()

        AvailableTW.WaitUntilActiveButton()

        AvailableTW.ClickButtonActive()
        Sleep(100)
    } Else {
        AvailableTW.ClickButtonActive()
        Sleep(100)
    }
}

Use6hTimeWarp(*) {
    UlcWindow()
    Out.D("Use6hTimeWarp")
    TTtab := cPoint(1810, 1177)
    BuyTW := cPoint(1592, 420)
    AvailableTW := cPoint(1744, 420)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    BuyTW.WaitUntilActiveButton()

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive()

        AvailableTW.WaitUntilActiveButton()

        AvailableTW.ClickButtonActive()
        Sleep(100)
    } Else {
        AvailableTW.ClickButtonActive()
        Sleep(100)
    }
}

Use24hTimeWarp(*) {
    UlcWindow()
    Out.D("Use24hTimeWarp")
    TTtab := cPoint(1810, 1177)
    BuyTW := cPoint(1592, 530)
    AvailableTW := cPoint(1744, 530)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    BuyTW.WaitUntilActiveButton()

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive()

        AvailableTW.WaitUntilActiveButton()

        AvailableTW.ClickButtonActive()
        Sleep(100)
    } Else {
        AvailableTW.ClickButtonActive()
        Sleep(100)
    }
}

Use72hTimeWarp(*) {
    UlcWindow()
    Out.D("Use72hTimeWarp")
    TTtab := cPoint(1810, 1177)
    BuyTW := cPoint(1592, 645)
    AvailableTW := cPoint(1744, 645)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    BuyTW.WaitUntilActiveButton()

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive()

        AvailableTW.WaitUntilActiveButton()

        AvailableTW.ClickButtonActive()
        Sleep(100)
    } Else {
        AvailableTW.ClickButtonActive()
        Sleep(100)
    }
}

TradeForPyramid(*) {
    UlcWindow()
    Out.D("TODO TradeForPyramid")
    MsgBox("Trade for borbs, beer, cheese, mulch, then close this")
}

IsULCCraftSaved() {
    Out.D("TODO IsULCCraftSaved")
    ; can be grabbed from profiles.def.objects.o_game.data.ulc_settings
}

WaitForAncients(*) {
    UlcWindow()
    Out.D("TODO WaitForAncients")

}

CraftMoonLeafsAndPreset() {
    UlcWindow()
    Out.D("TODO CraftMoonLeafsAndPreset")

}
