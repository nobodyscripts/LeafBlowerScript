#Requires AutoHotkey v2.0

#Include Header.ahk

/** Shops class, contains shop related functions and travel
 * @type {cShops}
 */
Global Shops := cShops()

/**
 * @module cShops
 * @property {sBiotite} Biotite Biotite shop class
 * @property {sCards} Cards Cards shop class
 * @property {sCoal} Coal Coal shop class
 * @property {sDice} Dice Dice shop class
 * @property {sElectric} Electric Electric shop class
 * @property {sHematite} Hematite Hematite shop class
 * @property {sMalachite} Malachite Malachite shop class
 * @property {sMine} Mine Mine shop class
 * @property {sMLC} MLC MLC shop class
 * @property {sMoonstone} Moonstone Moonstone shop class
 * @property {sMulch} Mulch Mulch shop class
 * @property {sPlasma} Plasma Plasma shop class
 * @property {sPyramid} Pyramid Pyramid shop class
 * @property {sSacred} Sacred Sacred shop class
 * @property {sSand} Sand Sand shop class
 * @property {sSoulForge} SoulForge SoulForge shop class
 * @property {sSoulTemple} SoulTemple SoulTemple shop class
 * @property {sSoulShop} SoulShop SoulShop shop class
 * 
 * @method OpenGemShop Open gem shop panel
 * @method OpenTrades Open trades panel
 * @method OpenPets Open pets panel
 * @method OpenBank Open bank panel
 * @method OpenBorbVentures Open borbventures panel
 * @method GotoBorbVFirstTab
 * @method OpenCards Open cards panel
 * @method OpenAlchemy Open alchemy panel
 * @method OpenAlchemyGeneral
 * @method IsAlchGeneralTab
 * @method OpenCrafting Open crafting panel
 * @method OpenMining Open mining panel
 * @method OpenGoldPortal Open gold portal (prestige) panel
 * @method OpenRedPortal Open red portal (prestige) panel
 * @method OpenGreenPortal Open green portal (prestige) panel
 * @method OpenBluePortal Open blue portal (prestige) panel
 * @method OpenConverters Open converters panel
 */
Class cShops {
    ;@region OpenGemShop()
    /**
     * Open Gem panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGemShop(reset := false, delay := 0) {
        Out.V("OpenGemShop")
        active := Travel._OpenAny(GameKeys.OpenGemShop.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            Travel.ResetGemShopScroll(delay)
        }
        Return active
    }

    ;@region ResetGemShopScroll()
    /**
     * Swap tabs to reset scroll state in GemShop panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetGemShopScroll(delay := 0) {
        Return Travel.ResetScroll(Points.Areas.LeafGalaxy.Tab, Points.Areas.Favs.Tab,
            delay)
    }
    ;@endregion
    ;@endregion

    ;@region OpenTrades()
    /**
     * Open Trades panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenTrades(delay := 0) {
        ; No tabs so no reset
        Out.V("OpenTrades")
        Return Travel._OpenAny(GameKeys.OpenTrades.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
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
        Out.V("OpenPets")
        active := Travel._OpenAny(GameKeys.OpenPets.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            Travel.ResetPetScroll(delay)
        }
        Return active
    }
    ;@region ResetPetScroll()
    /**
     * Swap tabs to reset scroll state in Pet panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetPetScroll(delay := 0) {
        Return Travel.ResetScroll(Points.Misc.Pets.TeamsTab, Points.Misc.Pets.PetsTab,
            delay)
    }
    ;@endregion
    ;@endregion

    ;@region OpenBank()
    /**
     * Open Bank panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBank(delay := 0) {
        Out.V("OpenBank")
        Return Travel._OpenAny(GameKeys.OpenBank.Bind(GameKeys), Window.IsPanel.Bind(
            Window), delay)
    }
    ;@endregion

    ;@region OpenBorbVentures()
    /**
     * Open Borbventures panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBorbVentures(reset := false, delay := 0) {
        Out.V("OpenBorbVentures")
        active := Travel._OpenAny(GameKeys.OpenBorbVentures.Bind(GameKeys),
        Window.IsPanel.Bind(Window), delay)
        If (reset && active) {
            Shops.ResetBorbVScroll(delay)
        }
        Return active
    }

    ;@region ResetBorbVScroll()
    /**
     * Swap tabs to reset scroll state in BorbV panel
     * @param {Integer} [delay=0] Extra delay to apply to NavigateTime
     */
    ResetBorbVScroll(delay := 0) {
        Out.I(Points.Borbventures.BorbsTab.toStringWColour())
        Out.I(Points.Borbventures.BVTab.toStringWColour())
        Return Travel.ResetScroll(Points.Borbventures.BorbsTab, Points.Borbventures
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
        Shops.OpenBorbVentures(true)
        i := 0
        While (!this.IsBorbVFirstTab() && i <= 4) {
            Shops.OpenBorbVentures(true)
            i++
        }
        If (this.IsBorbVFirstTab()) {
            Out.D("Travel success to Borbventures First Tab.")
            Return true
        }
        Out.I("Failed to travel to borbventures first tab")
        Return false
    }

    IsBorbVFirstTab() {
        Return Points.Borbventures.Detailed.IsButtonActive() && Points.Borbventures
        .ScaleMin.IsButtonActive()
    }
    ;@endregion

    ;@region OpenCards()
    /**
     * Open Cards panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCards(reset := false, delay := 0) {
        Out.V("OpenCards")
        active := Travel._OpenAny(GameKeys.OpenCards.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            ; TODO this one needs a custom reset
            Travel.ResetAreaScroll(delay)
        }
        Return active
    }
    ;@endregion

    ;@region OpenAlchemy()
    /**
     * Open Alchemy panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemy(reset := false, delay := 0) {
        Out.V("OpenAlchemy")
        active := Travel._OpenAny(GameKeys.OpenAlchemy.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            Travel.ResetAreaScroll(delay)
        }
        Return active
    }
    ;@endregion

    ;@region OpenAlchemyGeneral()
    /**
     * Open Alchemy panel first tab, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenAlchemyGeneral(reset := false, delay := 0) {
        i := 1
        NavigateTime := S.Get("NavigateTime")
        While (!this.IsAlchGeneralTab() && i <= 4) {
            If (this.OpenAlchemy(reset, delay)) {
                Sleep(NavigateTime)
                If (Points.Brew.Tab1.Nav.IsButtonActive()) {
                    Out.V("Clicking alchemy general tab")
                    Points.Brew.Tab1.Nav.Click(NavigateTime)
                    Sleep(NavigateTime)
                }
            }
            i++
        }
        Return this.IsAlchGeneralTab()
    }
    ;@endregion

    ;@region IsAlchGeneralTab()
    IsAlchGeneralTab() {
        If (!Window.IsPanel()) {
            Return false
        }
        Artifacts := Points.Brew.Tab1.Artifacts
        Equipment := Points.Brew.Tab1.Equipment
        Materials := Points.Brew.Tab1.Materials
        Scrolls := Points.Brew.Tab1.Scrolls
        If (Artifacts.IsButton() && Equipment.IsButton() && Materials.IsButton() &&
        Scrolls.IsButton()) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region OpenCrafting()
    /**
     * Open Crafting panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenCrafting(reset := false, delay := 0) {
        Out.V("OpenCrafting")
        active := Travel._OpenAny(GameKeys.OpenCrafting.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            Travel.ResetAreaScroll(delay)
        }
        Return active
    }
    ;@endregion

    ;@region OpenMining()
    /**
     * Open Mining panel, closes others first
     * @param {Integer} reset Use ResetAreaScroll or not to swap tabs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenMining(reset := false, delay := 0) {
        Out.V("OpenMining")
        active := Travel._OpenAny(GameKeys.OpenMining.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        If (reset && active) {
            Travel.ResetAreaScroll(delay)
        }
        Return active
    }
    ;@endregion

    ;@region OpenGoldPortal()
    /**
     * Open Gold portal (prestige 1) panel, closes others firs
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGoldPortal(delay := 0) {
        Out.V("OpenGoldPortal")
        active := Travel._OpenAny(GameKeys.OpenGoldPortal.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        Return active
    }
    ;@endregion

    ;@region OpenRedPortal()
    /**
     * Open Red portal (prestige 2) panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenRedPortal(delay := 0) {
        Out.V("OpenRedPortal")
        active := Travel._OpenAny(GameKeys.OpenRedPortal.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        Return active
    }
    ;@endregion

    ;@region OpenGreenPortal()
    /**
     * Open Green portal (prestige 3) panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenGreenPortal(delay := 0) {
        Out.V("OpenGreenPortal")
        active := Travel._OpenAny(GameKeys.OpenGreenPortal.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        Return active
    }
    ;@endregion

    ;@region OpenBluePortal()
    /**
     * Open Blue portal (prestige 1) panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenBluePortal(delay := 0) {
        Out.V("OpenBluePortal")
        active := Travel._OpenAny(GameKeys.OpenBluePortal.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        Return active
    }
    ;@endregion

    ;@region OpenConverters()
    /**
     * Open Converters panel, closes others first
     * @param {Integer} delay Additional delay to NavigateTime for slow points
     * @returns {Boolean} Is panel active
     */
    OpenConverters(delay := 0) {
        Out.V("OpenConverters")
        active := Travel._OpenAny(GameKeys.OpenConverters.Bind(GameKeys), Window.IsPanel
        .Bind(Window), delay)
        Return active
    }
    ;@endregion

    /**
     * Shop class for Cards
     * @type {sCards}
     */
    Cards := sCards()

    /**
     * Shop class for Dice
     * @type {sDice}
     */
    Dice := sDice()

    /**
     * Shop class for Mines
     * @type {sMine} Shop class for Mine 
     * */
    Mine := sMine()

    /**
     * Shop class for Relics
     * @type {sRelics} Shop class for Relics 
     * */
    Relics := sRelics()

    /**
     * Shop class for Sacred
     * @type {sSacred} 
     */
    Sacred := sSacred()

    /**
     * Shop class for Biotite
     * @type {sBiotite}
     */
    Biotite := sBiotite()

    /**
     * Shop class for Malachite
     * @type {sMalachite}
     */
    Malachite := sMalachite()

    /**
     * Shop class for Hematite
     * @type {sHematite}
     */
    Hematite := sHematite()

    /**
     * Shop class for Plasma
     * @type {sPlasma} 
     */
    Plasma := sPlasma()

    /**
     * Shop class for Plasma
     * @type {sPlasma} 
     */
    Electric := sElectric()

    /**
     * Shop class for Coal
     * @type {sCoal}
     */
    Coal := sCoal()

    /**
     * Shop class for Sand
     * @type {sSand}
     */
    Sand := sSand()

    /**
     * Shop class for Moonstone
     * @type {sMoonstone}
     */
    Moonstone := sMoonstone()

    /**
     * Shop class for SoulForge
     * @type {sSoulForge}
     */
    SoulForge := sSoulForge()

    /**
     * Shop class for SoulTemple
     * @type {sSoulTemple}
     */
    SoulTemple := sSoulTemple()

    /**
     * Shop class for Soul
     * @type {sSoulShop}
     */
    SoulShop := sSoulShop()

    /**
     * Shop class for MLC
     * @type {sMLC}
     */
    MLC := sMLC()

    /**
     * Shop class for Mulch
     * @type {sMulch}
     */
    Mulch := sMulch()

    /**
     * Shop class for Pyramid
     * @type {sPyramid}
     */
    Pyramid := sPyramid()
}
