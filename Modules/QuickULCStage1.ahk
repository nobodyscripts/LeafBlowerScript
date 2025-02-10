#Requires AutoHotkey v2.0

Global ULCStage1Exit := false

GetDailyReward(*) {
    UlcWindow()
    Travel.ClosePanelIfActive()
    cPoint(710, 139).Click()
    Sleep(100)
    cPoint(664, 420).ClickButtonActive()
}

WaitForFloor100(*) {
    /** @type {Timer} */
    Limiter := Timer()
    Limiter.CoolDownM(2, &isactive)
    While (!Rects.Misc.FloorAmount100.PixelSearch() && isactive) {
        Sleep(100)
    }
    If (!Rects.Misc.FloorAmount100.PixelSearch()) {
        Global ULCStage1Exit := true
    }
}

TriggerBLC(*) {
    UlcWindow()
    Out.D("TriggerBLC")
    Shops.OpenRedPortal()
    crunchbtn := cPoint(1109, 553)
    crunchbtn.WaitUntilActiveButton()
    If (!crunchbtn.ClickButtonActive()) {
        Global ULCStage1Exit := true
        Return
    }
    Sleep(150)
    If (!cPoint(1131, 525).ClickButtonActive()) {
        Global ULCStage1Exit := true
    }
}

TriggerMLC(*) {
    UlcWindow()
    Out.D("TriggerMLC")
    Shops.OpenGreenPortal()
    If (!cPoint(1111, 549).ClickButtonActive()) {
        Global ULCStage1Exit := true
        Return
    }
    Sleep(150)
    If (!cPoint(1111, 524).ClickButtonActive()) {
        Global ULCStage1Exit := true
    }
}

TriggerMLCConverters(*) {
    TriggerMLC()
    Out.D("TriggerMLCConverters")
    WaitForPortalAnimation()
    Shops.OpenConverters()
    /** @type {cPoint} */
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButton()
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Global ULCStage1Exit := true
    }
}

ActivateConverters(*) {
    UlcWindow()
    Out.D("ActivateConverters")
    GameKeys.OpenConverters()
    StartConvertorsBtn := cPoint(1075, 1102)
    StartConvertorsBtn.WaitUntilActiveButton()
    If (!StartConvertorsBtn.ClickButtonActive()) {
        Global ULCStage1Exit := true
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
        Global ULCStage1Exit := true
    }
}

WaitForBLCPortal(*) {
    ; wait for blc to be available after second mlc
    UlcWindow()

    Out.D("WaitForBLCPortal")
    /** @type {cPoint} */
    text := cPoint(1144, 609)
    text.TextTipAtCoord("Waiting for blc portal to be active")

    /** @type {cPoint} */
    BLCBtn := cPoint(1065, 1220)
    BLCBtn.WaitWhileColour("0xFFFFF6", 2400, 100) ; 120s
    If (BLCBtn.GetColour() = "0xFFFFF6") {
        Global ULCStage1Exit := true
    }
    Tooltip(, , , 15)
}

WaitTillPyramidReset(*) {
    UlcWindow()
    Out.D("WaitTillPyramidReset")
    colour := Colours().GetColourByZone("The Inner Cursed Pyramid")
    Points.Misc.ZoneSample.WaitUntilColour(colour, 600, 50) ; 30s
}

PubTradeForCheese25000(*) {
    UlcWindow()
    Out.D("PubTradeForCheese25000")
    Travel.TheCheesePub.GoTo()
    If (!Travel.TheCheesePub.IsZoneColour()) {
        Global ULCStage1Exit := true
        Return
    }
    Sleep(150)
    BartenderBtn := cPoint(241, 741)
    BartenderBtn.Click()
    Sleep(250)
    QuestsBtn := cPoint(1091, 380)
    QuestsBtn.WaitUntilActiveButton()
    If (!QuestsBtn.ClickButtonActive()) {
        Global ULCStage1Exit := true
        Return
    }
    QuestCheese250Btn := cPoint(1702, 312)
    QuestCheese250Btn.WaitUntilActiveButton()
    If (!QuestCheese250Btn.ClickButtonActive()) {
        Global ULCStage1Exit := true
        Return
    }
    QuestCheese250Btn.WaitUntilActiveButton()
    If (!QuestCheese250Btn.ClickButtonActive()) {
        Global ULCStage1Exit := true
    }
}

Use30minTimeWarp(*) {
    UlcWindow()
    Out.D("Use30minTimeWarp")
    TTtab := cPoint(1810, 1177)
    Buy30mins := cPoint(1592, 306)
    Available30mins := cPoint(1744, 306)
    Shops.OpenGemShop()
    TTtab.WaitUntilActiveButton()
    If (!TTtab.IsButtonActive()) {
        Out.I("Found no time travel button, exiting.")
        Global ULCStage1Exit := true
        Return
    }
    ; Navigate to Time Travel tab
    TTtab.Click()

    Buy30mins.WaitUntilActiveButton()

    If (!Available30mins.IsButtonActive()) {
        Buy30mins.ClickButtonActive()

        Available30mins.WaitUntilActiveButton()

        Available30mins.ClickButtonActive()
        Sleep(100)
    } Else {
        Available30mins.ClickButtonActive()
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

}

WaitForAncients(*) {
    UlcWindow()
    Out.D("TODO WaitForAncients")

}

CraftMoonLeafsAndPreset() {
    UlcWindow()
    Out.D("TODO CraftMoonLeafsAndPreset")

}
