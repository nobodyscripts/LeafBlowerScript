#Requires AutoHotkey v2.0

#Include ..\Navigate\Header.ahk
#Include cZone.ahk

; {cTravel} Travel object
global Travel := cTravel()

/**
 * Travel class, contains functions and sub classes for travel to areas, tabs
 * or windows in lbr.
 * @property {Desert} Desert Travel class for Desert
 */
Class cTravel {

    /**
     * Private func, used as base of Open* funcs to add redundancy
     * @param {Func} action Function to run to 'open' and redundantly attempt
     * @param {Func} test Function to test if 'open' was successful
     * @param {Integer} reset Reset area panel scroll state at end
     * @param {Integer} delay Extra delay to apply to NavigateTime
     */
    _OpenAny(action, test, reset := true, delay := 0) {
        NavTime := NavigateTime + delay
        if (NavTime < 72) {
            NavTime := 72
        }
        this.ClosePanelIfActive()
        action() ; Open location in func
        sleep(NavTime)
        i := 0
        while (!test() && i <= 4) {
            action() ; Open location in func
            sleep(NavTime)
            i++
        }
        if (reset) {
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
        this._OpenAny(() => GameKeys.OpenAreas, IsPanelActive, reset, delay)
    }

    ; Open Gem shop panel, closes others first
    OpenGemShop(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenGemShop, IsPanelActive, reset, delay)
    }

    ; Open Trades panel, closes others first
    OpenTrades(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenTrades, IsPanelActive, reset, delay)
    }

    ; Open Pets panel, closes others first
    OpenPets(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenPets, IsPanelActive, reset, delay)
    }

    ; Open Bank panel, closes others first
    OpenBank(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenBank, IsPanelActive, reset, delay)
    }

    ; Open Borbventures panel, closes others first
    OpenBorbVentures(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenBorbVentures, IsPanelActive, reset, delay)
    }

    ; Open Cards panel, closes others first
    OpenCards(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenCards, IsPanelActive, reset, delay)
    }

    ; Open Alchemy panel, closes others first
    OpenAlchemy(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenAlchemy, IsPanelActive, reset, delay)
    }

    ; Open Crafting panel, closes others first
    OpenCrafting(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenCrafting, IsPanelActive, reset, delay)
    }

    ; Open Mining panel, closes others first
    OpenMining(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenMining, IsPanelActive, reset, delay)
    }

    ; Open Gold portal (prestige 1) panel, closes others first
    OpenGoldPortal(reset := true, delay := 0) {
        this._OpenAny(() => GameKeys.OpenGoldPortal, IsPanelActive, reset, delay)
    }

    ; Closes open panels or opens settings if non open
    ClosePanel(reset := true, delay := 0) {
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }

    ; Closes open panels if one is open
    ClosePanelIfActive(reset := true, delay := 0) {
        if (IsPanelActive()) {
            this.ClosePanel()
            Sleep(NavigateTime)
        }
    }

    ; Opens settings panel, closes others first
    OpenSettings(reset := true, delay := 0) {
        this.ClosePanelIfActive()
        GameKeys.ClosePanel()
        Sleep(NavigateTime)
    }

    ; Travel class for Desert
    Desert := Desert()

    ; Travel class for Cursed Halloween
    CursedHalloween := CursedHalloween()
}