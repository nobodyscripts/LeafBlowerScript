#Requires AutoHotkey v2.0

Global ULCStageExit := false

GetDailyReward(*) {
    UlcWindow()
    Out.D("Get Daily Reward")
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
    text.TextTipAtCoord("Waiting for floor 100 to be reached")
    Out.D("Waiting for floor 100 to be reached")
    While (!Rects.Misc.FloorAmount100.PixelSearch() && isactive &&
    Window.IsActive()) {
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
    /** @type {cPoint} */
    crunchbtn := cPoint(1354, 532)
    crunchbtn.WaitUntilActiveButton(100, 30)
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find blc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    crunchbtn.WaitUntilActiveButton(100, 20)
    crunchbtn.ClickButtonActive()
    Sleep(34)
    crunchbtn.ClickButtonActive()
    Sleep(150)
}

TriggerMLC(*) {
    UlcWindow()
    crunchbtn := cPoint(1354, 532)
    Out.D("TriggerMLC")
    Shops.OpenGreenPortal()
    crunchbtn.WaitUntilActiveButton(100, 30)
    If (!crunchbtn.IsButtonActive()) {
        Out.I("Didn't find mlc crunch button, aborting.")
        Global ULCStageExit := true
        Return
    }
    crunchbtn.ClickButtonActive()
    crunchbtn.WaitUntilActiveButton(100, 20)
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
    /** @type {cPoint} */
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButton(100, 50)
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
    Points.Misc.NotifArrowExist.WaitUntilActiveButton(1000, 20) ; 20s
    Sleep(500)
    If (!Points.Misc.NotifArrowExist.IsButtonActive()) {
        Out.I("Failed to see ui after portal animation")
        Global ULCStageExit := true
    }
}

WaitForBLCPortal(*) {
    ; wait for blc to be available after second mlc
    UlcWindow()
    Travel.ClosePanelIfActive()
    Out.D("WaitForBLCPortal")
    /** @type {cPoint} */
    text := cPoint(1144, 609)

    /** @type {cPoint} */
    BlackFlaskStoreBtn := cPoint(828, 1225)
    /** @type {cPoint} */
    BuyBLCBtn := cPoint(1700, 304)
    /** @type {cPoint} */
    BLCBtn := cPoint(1063, 1220)

    Out.D("Waiting for flask button")
    text.TextTipAtCoord("Waiting for black flask shop to be active")
    ; Out.D("Black flask button colour " BlackFlaskStoreBtn.GetColour())
    BlackFlaskStoreBtn.WaitUntilActiveButton(4800, 17)
    If (BlackFlaskStoreBtn.GetColour() = "0xFEF1D2" || BlackFlaskStoreBtn.IsButtonActive()) {
        BlackFlaskStoreBtn.ClickOffset(, , 50)
        Sleep(72)
        If (!Window.IsPanel()) {
            BlackFlaskStoreBtn.ClickOffset(, , 50)
            Sleep(72)
        }
    }
    Tooltip(, , , 15)
    text.TextTipAtCoord("Waiting for buy blc to be active")
    Out.D("Waiting for buy blc button")
    If (!BuyBLCBtn.IsBackground()) {
        BuyBLCBtn.WaitUntilActiveButton(200, 50) ; 5s
        If (!BuyBLCBtn.IsButtonActive()) {
            BlackFlaskStoreBtn.ClickOffset(, , 50)
            BuyBLCBtn.WaitUntilActiveButton(120, 17)
        }
        BuyBLCBtn.ClickButtonActive(, , 50, 34)
        BuyBLCBtn.ClickButtonActive(, , 50, 34)
    }

    colour := "0xFFC2B3"
    Tooltip(, , , 15)
    text.TextTipAtCoord("Waiting for blc portal to be active")
    Out.D("Waiting for blc portal button")
    BLCBtn.WaitWhileNotColour(colour, 4800, 17) ; 120s
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
    colour := Colours().GetColourByZone("The Cursed Pyramid")
    Points.Misc.ZoneSample.WaitWhileNotColour(colour, 1200, 50) ; 60s
    If (Points.Misc.ZoneSample.IsColour(colour)) {
        Out.I("Timed out waiting for pyramid to clear, "
            "taxi may have already been bought.")
    }
    ToolTip(, , , 15)
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
    QuestCheese2500Btn := cPoint(1695, 696)
    QuestCheese2500Btn.WaitUntilActiveButton()
    Out.D("Clicking cheese quest")
    If (!QuestCheese2500Btn.ClickButtonActive()) {
        Out.I("Didn't find cheese quest button, aborting.")
        Global ULCStageExit := true
        Return
    }
    QuestCheese2500Btn.WaitUntilActiveButton()
    Out.D("Clicking cheese quest")
    If (!QuestCheese2500Btn.ClickButtonActive()) {
        Out.I("Didn't find cheese quest button, aborting.")
        Global ULCStageExit := true
    }
}

Use30minTimeWarp(*) {
    UlcWindow()
    Out.D("Use30minTimeWarp")
    /** @type {cPoint} */
    TTtab := cPoint(1761, 1163)
    /** @type {cPoint} */
    BuyTW := cPoint(1592, 306)
    /** @type {cPoint} */
    AvailableTW := cPoint(1744, 306)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton(400, 20)
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStageExit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    BuyTW.WaitUntilActiveButton(400, 20)

    If (!AvailableTW.IsButtonActive()) {
        BuyTW.ClickButtonActive()

        AvailableTW.WaitUntilActiveButton(400, 20)

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
    TTtab := cPoint(1761, 1163)
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
    TTtab := cPoint(1761, 1163)
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
    TTtab := cPoint(1761, 1163)
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
