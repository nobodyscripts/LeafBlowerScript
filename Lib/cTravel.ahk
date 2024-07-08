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
 * @property {AstralOasis} AstralOasis Travel class for Astral Oasis
 * @property {BiotiteForest} BiotiteForest Travel class for Biotite Forest
 * @property {BlackLeafHole} BlackLeafHole Travel class for Black Leaf Hole
 * @property {BlackPlanetEdge} BlackPlanetEdge Travel class for Black Planet Edge
 * @property {BluePlanetEdge} BluePlanetEdge Travel class for Blue Planet Edge
 * @property {ButterflyField} ButterflyField Travel class for Butterfly Field
 * @property {CursedKokkaupunki} CursedKokkaupunki Travel class for Cursed Kokkaupunki
 * @property {DiceyMeadows} DiceyMeadows Travel class for Dicey Meadows
 * @property {DimensionalTapestry} DimensionalTapestry Travel class for Dimensional Tapestry
 * @property {EnergyShrine} EnergyShrine Travel class for Energy Shrine
 * @property {EnergySingularity} EnergySingularity Travel class for Energy Singularity
 * @property {FarmField} FarmField Travel class for Farm Field
 * @property {FireFieldsPortal} FireFieldsPortal Travel class for Fire Fields Portal
 * @property {FireUniverse} FireUniverse Travel class for Fire Universe
 * @property {FlameBrazier} FlameBrazier Travel class for Flame Brazier
 * @property {GlintingThicket} GlintingThicket Travel class for Glinting Thicket
 * @property {GreenPlanetEdge} GreenPlanetEdge Travel class for Green Planet Edge
 * @property {HomeGarden} HomeGarden Travel class for Home Garden
 * @property {Kokkaupunki} Kokkaupunki Travel class for Kokkaupunki
 * @property {LeafsinkHarbor} LeafsinkHarbor Travel class for Leafsink Harbor
 * @property {MountMoltenfurty} MountMoltenfurty Travel class for Mount Moltenfurty
 * @property {Mountain} Mountain Travel class for Mountain
 * @property {NeighborsGarden} NeighborsGarden Travel class for Neighbors' Garden
 * @property {PlanckScope} PlanckScope Travel class for Planck Scope
 * @property {PlasmaForest} PlasmaForest Travel class for Plasma Forest
 * @property {PrimordialEthos} PrimordialEthos Travel class for Primordial Ethos
 * @property {PurplePlanetEdge} PurplePlanetEdge Travel class for Purple Planet Edge
 * @property {QuantumAether} QuantumAether Travel class for Quantum Aether
 * @property {QuarkNexus} QuarkNexus Travel class for Quark Nexus
 * @property {QuarkPortal} QuarkPortal Travel class for Quark Portal
 * @property {RedPlanetEdge} RedPlanetEdge Travel class for Red Planet Edge
 * @property {SoulCrypt} SoulCrypt Travel class for Soul Crypt
 * @property {SoulForge} SoulForge Travel class for Soul Forge
 * @property {SoulPortal} SoulPortal Travel class for Soul Portal
 * @property {SoulTemple} SoulTemple Travel class for Soul Temple
 * @property {Space} Space Travel class for Space
 * @property {SparkBubble} SparkBubble Travel class for Spark Bubble
 * @property {SparkPortal} SparkPortal Travel class for Spark Portal
 * @property {SparkRange} SparkRange Travel class for Spark Range
 * @property {THEVOID} THEVOID Travel class for THE VOID
 * @property {TerrorGraveyard} TerrorGraveyard Travel class for Terror Graveyard
 * @property {TheAbandonedResearchStation} TheAbandonedResearchStation Travel class for The Abandoned Research Station
 * @property {TheAbyss} TheAbyss Travel class for The Abyss
 * @property {TheAncientSanctum} TheAncientSanctum Travel class for The Ancient Sanctum
 * @property {TheCelestialPlane} TheCelestialPlane Travel class for The Celestial Plane
 * @property {TheCheesePub} TheCheesePub Travel class for The Cheese Pub
 * @property {TheCoalMine} TheCoalMine Travel class for The Coal Mine
 * @property {TheCursedPyramid} TheCursedPyramid Travel class for The Cursed Pyramid
 * @property {TheDarkGlade} TheDarkGlade Travel class for The Dark Glade
 * @property {TheDoomedTree} TheDoomedTree Travel class for The Doomed Tree
 * @property {TheExaltedBridge} TheExaltedBridge Travel class for The Exalted Bridge
 * @property {TheFabricoftheLeafverse} TheFabricoftheLeafverse Travel class for The Fabric of the Leafverse
 * @property {TheFireTemple} TheFireTemple Travel class for The Fire Temple
 * @property {TheHiddenSea} TheHiddenSea Travel class for The Hidden Sea
 * @property {TheHollow} TheHollow Travel class for The Hollow
 * @property {TheInnerCursedPyramid} TheInnerCursedPyramid Travel class for The Inner Cursed Pyramid
 * @property {TheLeafTower} TheLeafTower Travel class for The Leaf Tower
 * @property {TheLoneTree} TheLoneTree Travel class for The Lone Tree
 * @property {TheMoon} TheMoon Travel class for The Moon
 * @property {TheMythicalGarden} TheMythicalGarden Travel class for The Mythical Garden
 * @property {TheShadowCavern} TheShadowCavern Travel class for The Shadow Cavern
 * @property {TheVolcano} TheVolcano Travel class for The Volcano
 * @property {VialofLife} VialofLife Travel class for Vial of Life
 * @property {VilewoodCemetery} VilewoodCemetery Travel class for Vilewood Cemetery
 * @property {YourHouse} YourHouse Travel class for Your House
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

    
    /**
     * Travel class for AstralOasis
     * @type {AstralOasis}
     */
    AstralOasis := AstralOasis()

    
    /**
     * Travel class for BiotiteForest
     * @type {BiotiteForest}
     */
    BiotiteForest := BiotiteForest()

    
    /**
     * Travel class for BlackLeafHole
     * @type {BlackLeafHole}
     */
    BlackLeafHole := BlackLeafHole()

    
    /**
     * Travel class for BlackPlanetEdge
     * @type {BlackPlanetEdge}
     */
    BlackPlanetEdge := BlackPlanetEdge()

    
    /**
     * Travel class for BluePlanetEdge
     * @type {BluePlanetEdge}
     */
    BluePlanetEdge := BluePlanetEdge()

    
    /**
     * Travel class for ButterflyField
     * @type {ButterflyField}
     */
    ButterflyField := ButterflyField()

    
    /**
     * Travel class for CursedKokkaupunki
     * @type {CursedKokkaupunki}
     */
    CursedKokkaupunki := CursedKokkaupunki()

    
    /**
     * Travel class for DiceyMeadows
     * @type {DiceyMeadows}
     */
    DiceyMeadows := DiceyMeadows()

    
    /**
     * Travel class for DimensionalTapestry
     * @type {DimensionalTapestry}
     */
    DimensionalTapestry := DimensionalTapestry()

    
    /**
     * Travel class for EnergyShrine
     * @type {EnergyShrine}
     */
    EnergyShrine := EnergyShrine()

    
    /**
     * Travel class for EnergySingularity
     * @type {EnergySingularity}
     */
    EnergySingularity := EnergySingularity()

    
    /**
     * Travel class for FarmField
     * @type {FarmField}
     */
    FarmField := FarmField()

    
    /**
     * Travel class for FireFieldsPortal
     * @type {FireFieldsPortal}
     */
    FireFieldsPortal := FireFieldsPortal()

    
    /**
     * Travel class for FireUniverse
     * @type {FireUniverse}
     */
    FireUniverse := FireUniverse()

    
    /**
     * Travel class for FlameBrazier
     * @type {FlameBrazier}
     */
    FlameBrazier := FlameBrazier()

    
    /**
     * Travel class for GlintingThicket
     * @type {GlintingThicket}
     */
    GlintingThicket := GlintingThicket()

    
    /**
     * Travel class for GreenPlanetEdge
     * @type {GreenPlanetEdge}
     */
    GreenPlanetEdge := GreenPlanetEdge()

    
    /**
     * Travel class for HomeGarden
     * @type {HomeGarden}
     */
    HomeGarden := HomeGarden()

    
    /**
     * Travel class for Kokkaupunki
     * @type {Kokkaupunki}
     */
    Kokkaupunki := Kokkaupunki()

    
    /**
     * Travel class for LeafsinkHarbor
     * @type {LeafsinkHarbor}
     */
    LeafsinkHarbor := LeafsinkHarbor()

    
    /**
     * Travel class for MountMoltenfurty
     * @type {MountMoltenfurty}
     */
    MountMoltenfurty := MountMoltenfurty()

    
    /**
     * Travel class for Mountain
     * @type {Mountain}
     */
    Mountain := Mountain()

    
    /**
     * Travel class for NeighborsGarden
     * @type {NeighborsGarden}
     */
    NeighborsGarden := NeighborsGarden()

    
    /**
     * Travel class for PlanckScope
     * @type {PlanckScope}
     */
    PlanckScope := PlanckScope()

    
    /**
     * Travel class for PlasmaForest
     * @type {PlasmaForest}
     */
    PlasmaForest := PlasmaForest()

    
    /**
     * Travel class for PrimordialEthos
     * @type {PrimordialEthos}
     */
    PrimordialEthos := PrimordialEthos()

    
    /**
     * Travel class for PurplePlanetEdge
     * @type {PurplePlanetEdge}
     */
    PurplePlanetEdge := PurplePlanetEdge()

    
    /**
     * Travel class for QuantumAether
     * @type {QuantumAether}
     */
    QuantumAether := QuantumAether()

    
    /**
     * Travel class for QuarkNexus
     * @type {QuarkNexus}
     */
    QuarkNexus := QuarkNexus()

    
    /**
     * Travel class for QuarkPortal
     * @type {QuarkPortal}
     */
    QuarkPortal := QuarkPortal()

    
    /**
     * Travel class for RedPlanetEdge
     * @type {RedPlanetEdge}
     */
    RedPlanetEdge := RedPlanetEdge()

    
    /**
     * Travel class for SoulCrypt
     * @type {SoulCrypt}
     */
    SoulCrypt := SoulCrypt()

    
    /**
     * Travel class for SoulForge
     * @type {SoulForge}
     */
    SoulForge := SoulForge()

    
    /**
     * Travel class for SoulPortal
     * @type {SoulPortal}
     */
    SoulPortal := SoulPortal()

    
    /**
     * Travel class for SoulTemple
     * @type {SoulTemple}
     */
    SoulTemple := SoulTemple()

    
    /**
     * Travel class for Space
     * @type {Space}
     */
    Space := Space()

    
    /**
     * Travel class for SparkBubble
     * @type {SparkBubble}
     */
    SparkBubble := SparkBubble()

    
    /**
     * Travel class for SparkPortal
     * @type {SparkPortal}
     */
    SparkPortal := SparkPortal()

    
    /**
     * Travel class for SparkRange
     * @type {SparkRange}
     */
    SparkRange := SparkRange()

    
    /**
     * Travel class for THEVOID
     * @type {THEVOID}
     */
    THEVOID := THEVOID()

    
    /**
     * Travel class for TerrorGraveyard
     * @type {TerrorGraveyard}
     */
    TerrorGraveyard := TerrorGraveyard()

    
    /**
     * Travel class for TheAbandonedResearchStation
     * @type {TheAbandonedResearchStation}
     */
    TheAbandonedResearchStation := TheAbandonedResearchStation()

    
    /**
     * Travel class for TheAbyss
     * @type {TheAbyss}
     */
    TheAbyss := TheAbyss()

    
    /**
     * Travel class for TheAncientSanctum
     * @type {TheAncientSanctum}
     */
    TheAncientSanctum := TheAncientSanctum()

    
    /**
     * Travel class for TheCelestialPlane
     * @type {TheCelestialPlane}
     */
    TheCelestialPlane := TheCelestialPlane()

    
    /**
     * Travel class for TheCheesePub
     * @type {TheCheesePub}
     */
    TheCheesePub := TheCheesePub()

    
    /**
     * Travel class for TheCoalMine
     * @type {TheCoalMine}
     */
    TheCoalMine := TheCoalMine()

    
    /**
     * Travel class for TheCursedPyramid
     * @type {TheCursedPyramid}
     */
    TheCursedPyramid := TheCursedPyramid()

    
    /**
     * Travel class for TheDarkGlade
     * @type {TheDarkGlade}
     */
    TheDarkGlade := TheDarkGlade()

    
    /**
     * Travel class for TheDoomedTree
     * @type {TheDoomedTree}
     */
    TheDoomedTree := TheDoomedTree()

    
    /**
     * Travel class for TheExaltedBridge
     * @type {TheExaltedBridge}
     */
    TheExaltedBridge := TheExaltedBridge()

    
    /**
     * Travel class for TheFabricoftheLeafverse
     * @type {TheFabricoftheLeafverse}
     */
    TheFabricoftheLeafverse := TheFabricoftheLeafverse()

    
    /**
     * Travel class for TheFireTemple
     * @type {TheFireTemple}
     */
    TheFireTemple := TheFireTemple()

    
    /**
     * Travel class for TheHiddenSea
     * @type {TheHiddenSea}
     */
    TheHiddenSea := TheHiddenSea()

    
    /**
     * Travel class for TheHollow
     * @type {TheHollow}
     */
    TheHollow := TheHollow()

    
    /**
     * Travel class for TheInnerCursedPyramid
     * @type {TheInnerCursedPyramid}
     */
    TheInnerCursedPyramid := TheInnerCursedPyramid()

    
    /**
     * Travel class for TheLeafTower
     * @type {TheLeafTower}
     */
    TheLeafTower := TheLeafTower()

    
    /**
     * Travel class for TheLoneTree
     * @type {TheLoneTree}
     */
    TheLoneTree := TheLoneTree()

    
    /**
     * Travel class for TheMoon
     * @type {TheMoon}
     */
    TheMoon := TheMoon()

    
    /**
     * Travel class for TheMythicalGarden
     * @type {TheMythicalGarden}
     */
    TheMythicalGarden := TheMythicalGarden()

    
    /**
     * Travel class for TheShadowCavern
     * @type {TheShadowCavern}
     */
    TheShadowCavern := TheShadowCavern()

    
    /**
     * Travel class for TheVolcano
     * @type {TheVolcano}
     */
    TheVolcano := TheVolcano()

    
    /**
     * Travel class for VialofLife
     * @type {VialofLife}
     */
    VialofLife := VialofLife()

    
    /**
     * Travel class for VilewoodCemetery
     * @type {VilewoodCemetery}
     */
    VilewoodCemetery := VilewoodCemetery()

    
    /**
     * Travel class for YourHouse
     * @type {YourHouse}
     */
    YourHouse := YourHouse()

    /* <classmarker> */
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