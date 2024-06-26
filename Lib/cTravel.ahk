#Requires AutoHotkey v2.0

#Include ..\Navigate\Header.ahk
#Include cZone.ahk
#Include Functions.ahk

/** @type {cTravel} */
global Travel := cTravel()

/**
 * Travel class, contains functions and sub classes for travel to areas, tabs
 * or windows in lbr.
 * @module cTravel
 * @property {Desert} Desert Travel class for Desert
 * @property {CursedHalloween} CursedHalloween Travel class for Cursed Halloween
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
 */
Class cTravel {
    ; Travel class for Desert
    Desert := Desert()

    ; Travel class for Cursed Halloween
    CursedHalloween := CursedHalloween()

    ; Travel class for Mine
    Mine := Mine()

    /**
     * Private func, used as base of Open* funcs to add redundancy
     * @param {Func} action Function to run to 'open' and redundantly attempt
     * @param {Func} test Function to test if 'open' was successful
     * @param {Bool} reset Reset area panel scroll state at end
     * @param {Integer} delay Extra delay to apply to NavigateTime
     */
    _OpenAny(action, test, reset := true, delay := 0) {
        NavTime := NavigateTime + delay
        ; TODO remove this manual limit and tweak individual usage
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
        if (reset && IsPanelActive()) {
            this.ResetAreaScroll(delay)
        }
    }

    /**
     * Swap tabs to reset scroll state in areas panel
     * @param {Integer} delay Extra delay to apply to NavigateTime
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

    /**
     * Cannot pass object properties directly so use fat arrow funcs
     */

    ; Open Areas panel, closes others first
    OpenAreas(reset := true, delay := 0) {
        VerboseLog("Openareas")
        this._OpenAny(GameKeys.OpenAreas.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Gem shop panel, closes others first
    OpenGemShop(reset := true, delay := 0) {
        VerboseLog("OpenGemShop")
        this._OpenAny(GameKeys.OpenGemShop.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Trades panel, closes others first
    OpenTrades(reset := true, delay := 0) {
        VerboseLog("OpenTrades")
        this._OpenAny(GameKeys.OpenTrades.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Pets panel, closes others first
    OpenPets(reset := true, delay := 0) {
        VerboseLog("OpenPets")
        this._OpenAny(GameKeys.OpenPets.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Bank panel, closes others first
    OpenBank(reset := true, delay := 0) {
        VerboseLog("OpenBank")
        this._OpenAny(GameKeys.OpenBank.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Borbventures panel, closes others first
    OpenBorbVentures(reset := true, delay := 0) {
        VerboseLog("OpenBorbVentures")
        this._OpenAny(GameKeys.OpenBorbVentures.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Cards panel, closes others first
    OpenCards(reset := true, delay := 0) {
        VerboseLog("OpenCards")
        this._OpenAny(GameKeys.OpenCards.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Alchemy panel, closes others first
    OpenAlchemy(reset := true, delay := 0) {
        VerboseLog("OpenAlchemy")
        this._OpenAny(GameKeys.OpenAlchemy.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Crafting panel, closes others first
    OpenCrafting(reset := true, delay := 0) {
        VerboseLog("OpenCrafting")
        this._OpenAny(GameKeys.OpenCrafting.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Mining panel, closes others first
    OpenMining(reset := true, delay := 0) {
        VerboseLog("OpenMining")
        this._OpenAny(GameKeys.OpenMining.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Open Gold portal (prestige 1) panel, closes others first
    OpenGoldPortal(reset := true, delay := 0) {
        VerboseLog("OpenGoldPortal")
        this._OpenAny(GameKeys.OpenGoldPortal.Bind(GameKeys), IsPanelActive, reset, delay)
    }

    ; Opens settings panel, closes others first
    OpenSettings(reset := true, delay := 0) {
        VerboseLog("OpenSettings")
        this.ClosePanelIfActive()
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }

    ; Closes open panels or opens settings if non open
    ClosePanel(reset := true, delay := 0) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
        VerboseLog("Panel closed manually")
    }

    ; Closes open panels if one is open
    ClosePanelIfActive(reset := true, delay := 0) {
        if (IsPanelActive()) {
            this.ClosePanel()
            Sleep(NavigateTime)
        }
        VerboseLog("Panel closed is " BinaryToStr(IsPanelActive()))
    }

}