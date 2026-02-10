#Requires AutoHotkey v2.0

#include ..\ScriptLib\cToolTip.ahk

Global ULCStageExit := false

ulctest(*) {
    UlcWindow()
    Travel.TerrorGraveyard.GoTo()
}

/**
 * GUI Handle
 */
GetDailyReward(*) {
    Out.V("Get Daily Reward")

    DailyGems().CollectAll()
}

/**
 * GUI Handle
 */
TriggerBLC(*) {
    Return Prestiges().ActivateRedPortal()
}

/**
 * GUI Handle
 */
TriggerMLC(*) {
    Return Prestiges().ActivateGreenPortal()
}

/**
 * GUI Handle
 */
TriggerULC(*) {
    Return Prestiges().ActivateBluePortal()
}

/**
 * GUI Handle
 */
TriggerMLCConverters(*) {
    Prestiges().ActivateGreenPortal()
    Prestiges().WaitForPortalAnimation()
    Converters().Activate()
}

/**
 * GUI Handle
 */
ActivateConverters(*) {
    Converters().Activate()
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

PubTradeForCheese250(*) { 
    Pub().TradeForCheese250()
}

PubTradeForCheese2500(*) {
    Pub().TradeForCheese2500()
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
