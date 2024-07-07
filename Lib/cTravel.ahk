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
    _OpenAny(action, test, delay := 0) {
        NavTime := NavigateTime + delay
        if (NavTime < 72) {
            NavTime := 72
        }
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
        return IsPanelActive()
    }

    ;@region ResetScroll()
    /**
     * Swap tabs to reset scroll state in areas panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetScroll(Button1, Button2, delay := 0) {
        NavTime := NavigateTime + delay
        if (NavTime < 72) {
            NavTime := 72
        }
        VerboseLog("Resetting panel scroll")
        ; Click tab
        if (Button1.IsButtonActive()) {
            Button1.ClickOffset(, , NavTime)
            Sleep(NavTime)
        } else {
            DebugLog("Reset panel scroll did not find an active button.")
            VerboseLog(Button1.toStringWColour())
            StackLog()
            return false
        }
        ; Click Back to reset the scroll
        if (Button2.IsButtonActive()) {
            Button2.ClickOffset(, , NavTime)
            Sleep(NavTime)
            ; Double click for redundancy
            Button2.ClickOffset(, , NavTime)
            Sleep(NavTime)
            return true
        } else {
            DebugLog("Button 2 inactive on resetscroll")
            VerboseLog(Button2.toStringWColour())
        }
        return false
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

    ;@region OpenAreas()
    /**
     * Open Areas panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAreas(reset := false, delay := 0) {
        VerboseLog("Openareas")
        active := this._OpenAny(GameKeys.OpenAreas.Bind(GameKeys),
            IsPanelActive, delay)
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
        return this.ResetScroll(Points.Areas.Favs.Tab, Points.Areas.LeafG.Tab,
            delay)
    }
    ;@endregion
    ;@endregion

    ;@region OpenAreasEvents()
    /**
     * Opens the areas panel, events tab
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    OpenAreasEvents(extraDelay := 0) {
        if (this.OpenAreas(false, extraDelay)) {
            return this.ResetScroll(Points.Areas.Favs.Tab, ;
                Points.Areas.Events.Tab, extraDelay)
        }
        return false
    }
    ;@endregion

    ;@region OpenAreasQuark()
    /**
     * Opens the quark panel
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    OpenAreasQuark(extraDelay := 0) {
        if (this.OpenAreas(false, extraDelay)) {
            state := this.ResetScroll(Points.Areas.Favs.Tab, ;
                Points.Areas.QuarkA.Tab, extraDelay)
            if (state) {
                this.ScrollAmountUp(2)
                Sleep(NavigateTime + extraDelay)
            }
        }
        return false
    }
    ;@endregion

    ;@region OpenGemShop()
    /**
     * Open Gem panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGemShop(reset := false, delay := 0) {
        VerboseLog("OpenGemShop")
        active := this._OpenAny(GameKeys.OpenGemShop.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            this.ResetGemShopScroll(delay)
        }
        return active
    }

    ;@region ResetGemShopScroll()
    /**
     * Swap tabs to reset scroll state in GemShop panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetGemShopScroll(delay := 0) {
        return this.ResetScroll(Points.Areas.LeafG.Tab, Points.Areas.Favs.Tab,
            delay)
    }
    ;@endregion
    ;@endregion

    ;@region OpenTrades()
    /**
     * Open Trades panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenTrades(delay := 0) {
        ; No tabs so no reset
        VerboseLog("OpenTrades")
        return this._OpenAny(GameKeys.OpenTrades.Bind(GameKeys), IsPanelActive,
            delay)
    }
    ;@endregion

    ;@region OpenPets()
    /**
     * Open Pets panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenPets(reset := false, delay := 0) {
        VerboseLog("OpenPets")
        active := this._OpenAny(GameKeys.OpenPets.Bind(GameKeys), IsPanelActive,
            delay)
        if (reset && active) {
            this.ResetPetScroll(delay)
        }
        return active
    }
    ;@region ResetPetScroll()
    /**
     * Swap tabs to reset scroll state in Pet panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetPetScroll(delay := 0) {
        return this.ResetScroll(Points.Misc.Pets.TeamsTab, Points.Misc.Pets.PetsTab,
            delay)
    }
    ;@endregion
    ;@endregion

    ;@region OpenBank()
    /**
     * Open Bank panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBank(delay := 0) {
        VerboseLog("OpenBank")
        return this._OpenAny(GameKeys.OpenBank.Bind(GameKeys), IsPanelActive,
            delay)
    }
    ;@endregion

    ;@region OpenBorbVentures()
    ;TODO split borbv to class
    /**
     * Open Borbventures panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBorbVentures(reset := false, delay := 0) {
        VerboseLog("OpenBorbVentures")
        active := this._OpenAny(GameKeys.OpenBorbVentures.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            this.ResetBorbVScroll(delay)
        }
        return active
    }

    ;@region ResetBorbVScroll()
    /**
     * Swap tabs to reset scroll state in BorbV panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetBorbVScroll(delay := 0) {
        log(Points.Borbventures.BorbsTab.toStringWColour())
        log(Points.Borbventures.BVTab.toStringWColour())
        return this.ResetScroll(Points.Borbventures.BorbsTab, Points.Borbventures
            .BVTab, delay)
    }
    ;@endregion
    ;@endregion

    ;@region GotoBorbVFirstTab()
    /**
     * Travel to Borbventures first tab
     * @returns {Boolean} 
     */
    GotoBorbVFirstTab() {
        Travel.OpenBorbVentures(true)
        i := 0
        while (!this.IsBorbVFirstTab() && i <= 4) {
            Travel.OpenBorbVentures(true)
            i++
        }
        if (this.IsBorbVFirstTab()) {
            DebugLog("Travel success to Borbventures First Tab.")
            return true
        }
        Log("Failed to travel to borbventures first tab")
        return false
    }

    IsBorbVFirstTab() {
        return Points.Borbventures.Detailed.IsButtonActive() && Points.Borbventures
            .ScaleMin.IsButtonActive()
    }
    ;@endregion

    /**
     * Open Cards panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCards(reset := false, delay := 0) {
        VerboseLog("OpenCards")
        active := this._OpenAny(GameKeys.OpenCards.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            ; TODO this one needs a custom reset
            this.ResetAreaScroll(delay)
        }
        return active
    }

    /**
     * Open Alchemy panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemy(reset := false, delay := 0) {
        VerboseLog("OpenAlchemy")
        active := this._OpenAny(GameKeys.OpenAlchemy.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            this.ResetAreaScroll(delay)
        }
        return active
    }

    /**
     * Open Alchemy panel first tab, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemyGeneral(reset := false, delay := 0) {
        i := 1
        while (!this.IsAlchGeneralTab() && i <= 4) {
            if (this.OpenAlchemy(reset, delay)) {
                Sleep(NavigateTime)
                if (Points.Brew.Tab1.Nav.IsButtonActive()) {
                    VerboseLog("Clicking alchemy general tab")
                    Points.Brew.Tab1.Nav.Click(NavigateTime)
                    Sleep(NavigateTime)
                }
            }
            i++
        }
        return this.IsAlchGeneralTab()
    }

    IsAlchGeneralTab() {
        if (!IsPanelActive()) {
            return false
        }
        Artifacts := Points.Brew.Tab1.Artifacts
        Equipment := Points.Brew.Tab1.Equipment
        Materials := Points.Brew.Tab1.Materials
        If (Artifacts.IsButton() || Equipment.IsButton() || Materials.IsButton()
        ) {
            return true
        }
        return false
    }

    /**
     * Open Crafting panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCrafting(reset := false, delay := 0) {
        VerboseLog("OpenCrafting")
        active := this._OpenAny(GameKeys.OpenCrafting.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            this.ResetAreaScroll(delay)
        }
        return active
    }

    /**
     * Open Mining panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenMining(reset := false, delay := 0) {
        VerboseLog("OpenMining")
        active := this._OpenAny(GameKeys.OpenMining.Bind(GameKeys),
            IsPanelActive, delay)
        if (reset && active) {
            this.ResetAreaScroll(delay)
        }
        return active
    }

    ;@region OpenGoldPortal()
    /**
     * Open Gold portal (prestige 1) panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGoldPortal(delay := 0) {
        VerboseLog("OpenGoldPortal")
        active := this._OpenAny(GameKeys.OpenGoldPortal.Bind(GameKeys),
            IsPanelActive, delay)
        return active
    }
    ;@endregion

    /**
     * Open settings panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenSettings(reset := false) {
        VerboseLog("OpenSettings")
        this.ClosePanelIfActive()
        GameKeys.ClosePanel()
        if (reset) {
            this.ResetAreaScroll()
        }
        Sleep(NavigateTime)
        return IsPanelActive()
    }

    ;@region Close panel
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
    ;@endregion

}