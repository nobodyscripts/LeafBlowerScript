#Requires AutoHotkey v2.0

#Include Navigate.ahk
#Include cZone.ahk
#Include Functions.ahk

/** @type {cTravel} */
global Travel := cTravel()

/**
 * Travel class, contains functions and sub classes for travel to areas, tabs
 * or windows in lbr.
 * @module cTravel
 * @Private _OpenAny Takes functions and provides the logic for the
 * .Open methods
 * @method ResetAreaScroll Reset scroll state in open panel
 * @method OpenAreas Open areas panel
 * @method OpenGemShop Open gem shop panel
 * @method OpenTrades Open trades panel
 * @method OpenPets Open pets panel
 * @method OpenBank Open bank panel
 * @method OpenBorbVentures Open borbventures panel
 * @method OpenCards Open cards panel
 * @method OpenAlchemy Open alchemy panel
 * @method OpenCrafting Open crafting panel
 * @method OpenMining Open mining panel
 * @method OpenGoldPortal Open gold portal (prestige) panel
 * @method ClosePanel Closes open panel or open settings
 * @method ClosePanelIfActive Closes open panel only if open
 * @method OpenSettings Open settings panel
 * 
 * @property {TheInfernalDesert} TheInfernalDesert Travel class for 
 * TheInfernalDesert
 * @property {CursedHalloween} CursedHalloween Travel class for Cursed Halloween
 * <jsdocmarker>
 */
Class cTravel {
    ;@region Travel classes definition
    ; Travel class for TheInfernalDesert
    TheInfernalDesert := TheInfernalDesert()

    ; Travel class for Cursed Halloween
    CursedHalloween := CursedHalloween()

    ; Travel class for Mine
    Mine := Mine()

    ; <classmarker>
    ;@endregion

    /**
     * Private func, used as base of Open* funcs to add redundancy
     * @param {Func} action Function to run to 'open' and redundantly attempt
     * @param {Func} test Function to test if 'open' was successful
     * @param {Bool} reset Reset area panel scroll state at end
     * @param {Integer} delay Extra delay to apply to NavigateTime
     */
    _OpenAny(action, test, reset := true, delay := 0) {
        NavTime := NavigateTime + delay
        this.ClosePanelIfActive()
        action() ; Open location in func
        sleep(NavTime)
        VerboseLog("Panel opened " BinaryToStr(IsPanelActive()))
        i := 0
        while (!test() && i <= 4) {
            action() ; Open location in func
            sleep(NavTime)
            i++
        }
        active := IsPanelActive()
        if (reset && active) {
            this.ResetAreaScroll(delay)
        }
        return active
    }

    ;@region ResetAreaScroll()
    /**
     * Swap tabs to reset scroll state in areas panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetAreaScroll(delay := 0) {
        NavTime := NavigateTime + delay
        if (NavTime < 72) {
            NavTime := 72
        }
        ; Click Favourites
        Points.Areas.Favs.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
        ; Click Back to default page to reset the scroll
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
        ; Double click for redundancy
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
    }
    ;@endregion

    ;@region ScrollAmountDown()
    /**
     * Scroll downwards in a panel by ticks
     * @param {number} [amount=1] Amount to scroll in ticks of mousewheel
     * @param {number} [extraDelay=0] Add ms to the sleep timers
     */
    ScrollAmountDown(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelDown")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }
    ;@endregion

    ;@region ScrollAmountUp()
    /**
     * Scroll upwards in a panel by ticks
     * @param {number} [amount=1] Amount to scroll in ticks of mousewheel
     * @param {number} [extraDelay=0] Add ms to the sleep timers
     */
    ScrollAmountUp(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelUp")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }
    ;@endregion

    /**
     * Open Areas panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAreas(reset := true, delay := 0) {
        VerboseLog("Openareas")
        return this._OpenAny(GameKeys.OpenAreas.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Gem panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGemShop(reset := false, delay := 0) {
        VerboseLog("OpenGemShop")
        return this._OpenAny(GameKeys.OpenGemShop.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Trades panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenTrades(reset := false, delay := 0) {
        VerboseLog("OpenTrades")
        return this._OpenAny(GameKeys.OpenTrades.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Pets panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenPets(reset := false, delay := 0) {
        VerboseLog("OpenPets")
        return this._OpenAny(GameKeys.OpenPets.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Bank panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBank(reset := false, delay := 0) {
        VerboseLog("OpenBank")
        return this._OpenAny(GameKeys.OpenBank.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Borbventures panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBorbVentures(reset := true, delay := 0) {
        VerboseLog("OpenBorbVentures")
        return this._OpenAny(GameKeys.OpenBorbVentures.Bind(GameKeys),
            IsPanelActive, reset, delay)
    }

    /**
     * Open Cards panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCards(reset := true, delay := 0) {
        VerboseLog("OpenCards")
        return this._OpenAny(GameKeys.OpenCards.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Alchemy panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemy(reset := true, delay := 0) {
        VerboseLog("OpenAlchemy")
        return this._OpenAny(GameKeys.OpenAlchemy.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Alchemy panel first tab, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemyGeneral(reset := false, delay := 0) {
        if (this.OpenAlchemy(reset, delay)) {
            Sleep(NavigateTime)
            Points.Brew.Tab1.Nav.Click(NavigateTime)
            Sleep(NavigateTime)
        } else {
            return false
        }
        return true
    }

    /**
     * Open Crafting panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCrafting(reset := true, delay := 0) {
        VerboseLog("OpenCrafting")
        return this._OpenAny(GameKeys.OpenCrafting.Bind(GameKeys),
            IsPanelActive, reset, delay)
    }

    /**
     * Open Mining panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenMining(reset := true, delay := 0) {
        VerboseLog("OpenMining")
        return this._OpenAny(GameKeys.OpenMining.Bind(GameKeys), IsPanelActive,
            reset, delay)
    }

    /**
     * Open Gold portal (prestige 1) panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGoldPortal(reset := false, delay := 0) {
        VerboseLog("OpenGoldPortal")
        return this._OpenAny(GameKeys.OpenGoldPortal.Bind(GameKeys),
            IsPanelActive, reset, delay)
    }

    /**
     * Open settings panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenSettings(reset := true) {
        VerboseLog("OpenSettings")
        this.ClosePanelIfActive()
        GameKeys.ClosePanel()
        if (reset) {
            this.ResetAreaScroll()
        }
        Sleep(NavigateTime)
        return IsPanelActive()
    }

    /**
     * Closes open panels or opens settings if non open
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    ClosePanel() {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
        return IsPanelActive()
    }

    /**
     * Closes open panels if one is open
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    ClosePanelIfActive() {
        if (IsPanelActive()) {
            this.ClosePanel()
            Sleep(NavigateTime)
        }
        return IsPanelActive()
    }

}