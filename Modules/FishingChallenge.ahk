#Requires AutoHotkey v2.0

S.AddSetting("FishChallenge", "FishChlCatchingDelay", 8, "int")
S.AddSetting("FishChallenge", "FishChlCatchingSearch", true, "bool")
S.AddSetting("FishChallenge", "FishChlEnableShopUpgrade", true, "bool")
S.AddSetting("FishChallenge", "FishChlEnableUpgradeRods", true, "bool")
S.AddSetting("FishChallenge", "FishChlEnableTransmute", true, "bool")
S.AddSetting("FishChallenge", "FishChlEnableJourneyCollect", true, "bool")
S.AddSetting("FishChallenge", "FishChlTimerShopUpgrade", 60, "int")
S.AddSetting("FishChallenge", "FishChlTimerUpgradeRods", 60, "int")
S.AddSetting("FishChallenge", "FishChlTimerTransmute", 60, "int")
S.AddSetting("FishChallenge", "FishChlTimerJourneyCollect", 60, "int")
S.AddSetting("FishChallenge", "FishChlTransmuteTtoFC", true, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteFCtoCry", false, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteCrytoA", false, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteFCtoA", false, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteFCtoT", false, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteCrytoFC", true, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteAtoCry", true, "bool")
S.AddSetting("FishChallenge", "FishChlTransmuteAtoFC", false, "bool")
S.AddSetting("FishChallenge", "FishChlAmount", 5, "int")

/**
 * FishingChallenge class to handle the functions, singlepass and loop of completing the fishing challenge
 * @module FishingChallenge
 * @method StartSingle Desc
 * @method StartLoop Desc
 * @method StartAmount Desc
 */
Class FishingChallenge {
    /** Challenges button, fixed nav activebutton
     * @type {cLBRButton} */
    ChallengePanel := cLBRButton(792, 144)
    /** Return to main mode from challenge
     * @type {cLBRButton} */
    ChallengeReturnToMain := cLBRButton(690, 377)
    /** Stop challenges button in challenges screen
     *  @type {cLBRButton} */
    ChallengeStop := cLBRButton(1169, 376)
    /** Confirm stop challenge button
     * @type {cLBRButton} */
    ChallengeStopConfim := cLBRButton(1401, 557)
    /** Start fishing challenge button, 28 scroll down
     * @type {cLBRButton} */
    ChallengeStart := cLBRButton(1815, 599)
    /** Complete page medal icon point Color: #C87B00
     * Closing closes panel entirely
     * @type {cLBRButton} */
    ChallengeCompleteMedal := cLBRButton(330, 462)
    /** Challenge button while inside fishing challenge
     *  @type {cLBRButton} */
    ChallengePanel2 := cLBRButton(580, 56)
    /** First bottom bar button (fishing/tool)
     * @type {cLBRButton} */
    FishPanel := cLBRButton(178, 1286)
    /** Second bottom bar button (fishing after leaf)
     * @type {cLBRButton} */
    FishPanel2 := cLBRButton(251, 1285)
    /** Third bottom bar button (fishing after leaf)
     * @type {cLBRButton} */
    FishPanel3 := cLBRButton(323, 1283)
    /** Fishing bottom bar button when fixed nav is enabled
     * @type {cLBRButton} */
    FishPanelFixed := cLBRButton(319, 1145)
    /**  BLC icon in the offline rewards screen, to check
     * if game has returned from challenge 0xEE1C24 
     * @type {cLBRButton} */
    OfflinePanelBLCIcon := cLBRButton(655, 441)

    /** Used for IsChallengePanel
     * @type {cLBRButton} */
    SeedSet := cLBRButton(775, 159)
    /** Used for IsChallengePanel
     * @type {cLBRButton} */
    SeedRandom := cLBRButton(824, 1101)
    /** Used for IsChallengePanel
     * @type {cLBRButton} */
    SeedClear := cLBRButton(547, 1103)

    /** @type {Fishing} */
    Fishing := Fishing()

    /**
     * No shop buttons except first (fishing), reduced settings bar buttons
     * Regain tools and basic leaf after a few leaves knocked off
     */

    ;@region StartSingle()
    /**
     * Start a single pass of the fishing challenge
     */
    StartSingle() {
        Out.I("Stoping Fishing Challenge")
        this.StopChallengeMain()
        Out.I("Starting Fishing Challenge")
        this.StartChallenge()
        Out.I("Opening Fishing")
        this.OpenFishing()

        FishCatchingSearch := S.Get("FishCatchingSearch")
        FishCatchingDelay := S.Get("FishCatchingDelay")
        FishChlTimerJourneyCollect := S.Get("FishChlTimerJourneyCollect")
        FishChlTimerTransmute := S.Get("FishChlTimerTransmute")
        FishChlEnableUpgradeRods := S.Get("FishChlEnableUpgradeRods")
        FishChlTimerUpgradeRods := S.Get("FishChlTimerUpgradeRods")
        FishChlEnableShopUpgrade := S.Get("FishChlEnableShopUpgrade")
        FishChlTimerShopUpgrade := S.Get("FishChlTimerShopUpgrade")

        StartTime := A_TickCount - (FishCatchingDelay * 1000)
        Time1 := StartTime
        Time2 := StartTime
        Time3 := StartTime
        Time4 := StartTime
        If (FishCatchingSearch) {
            Out.I("Started fishing challenge with search")
        } Else {
            Out.I("Started fishing challenge")
        }

        JourneyTime := A_Now
        TransmuteTime := A_Now
        RodsTime := A_Now
        ShopTime := A_Now
        ;TourneyTime := A_Now
        ;TourneyRodTime := A_Now
        LogToggle := true
        ActivePonds := 1
        TotalPonds := 1
        ActiveRods := 1
        TotalRods := 1
        Loop {
            If (!Window.IsActive()) {
                Break
            }
            ActivePonds := this.Fishing.PondCount()
            ActiveRods := this.Fishing.ActiveRodCount()
            Out.I("ActivePonds " ActivePonds " TotalPonds " TotalPonds " ActiveRods " ActiveRods " TotalRods " TotalRods
            )
            While (!this.Fishing.Ponds.IsOnTab()) {
                this.Fishing.Tabs.Pond.ClickButtonActive(, 5)
            }
            If (LogToggle) {
                Out.I("Fishing pass")
                LogToggle := false
            }
            If (FishCatchingSearch) {
                If (this.Fishing.Ponds.Search.IsButtonActive()) {
                    ; Search if the buttons active because a slot is empty
                    this.Fishing.AddNewPond()
                    ActivePonds++
                }

                this.Fishing.PondQualityUpgrade()
            }
            this.Fishing.EnsureAllPondsHaveRods()
            this.Fishing.FishPonds(&Time1, &Time2, &Time3, &Time4, , true)
            If (FishChlTimerJourneyCollect &&
                DateDiff(A_Now, JourneyTime, "S") > FishChlTimerJourneyCollect) {
                this.Fishing.JourneyCollect()
                JourneyTime := A_Now
                LogToggle := true
            }
            If (FishChlTimerTransmute &&
                DateDiff(A_Now, TransmuteTime, "S") > FishChlTimerTransmute) {
                this.Fishing.UserChlSelectedTransmute()
                TransmuteTime := A_Now
                LogToggle := true
            }
            If (FishChlEnableUpgradeRods &&
                DateDiff(A_Now, RodsTime, "S") > FishChlTimerUpgradeRods) {
                If (count := this.Fishing.UpgradeRods(TotalPonds, TotalRods, true)) {
                    TotalRods += count
                }
                RodsTime := A_Now
                LogToggle := true
            }
            If (FishChlEnableShopUpgrade &&
                DateDiff(A_Now, ShopTime, "S") > FishChlTimerShopUpgrade) {
                If (this.Fishing.ShopUpgrade(true)) {
                    TotalPonds++
                }
                ShopTime := A_Now
                LogToggle := true
            }

            ; If challenge complete panel shown
            If (this.ChallengeCompleteMedal.GetColour() = "0xC87B00") {
                Break
            }
        }
    }
    ;@endregion

    ;@region StartLoop()
    /**
     * Start looped passes of the fishing challenge
     */
    StartLoop() {
        Out.I("Starting Fishing Challenge loop")
        Loop {
            this.StartSingle()
            this.StopChallengeDuring()
            this.StartChallenge()
        }
    }
    ;@endregion

    ;@region StartAmount()
    /**
     * Start n passes of the fishing challenge
     */
    StartAmount(amount) {
        Out.I("Starting Fishing Challenge Amount " amount)
        While (amount > 0) {
            this.StartSingle()
            this.StopChallengeDuring()
            If (amount > 1) {
                this.StartChallenge()
            }
            amount--
        }
    }
    ;@endregion

    ;@region CheckForGameReload()
    /**
     * Repeatedly close panel until game actually closes panel
     * Window freezes and resizes/relocates to alt settings
     */
    CheckForGameReload() {
        ; Using isactive to trigger coord updates for Window class
        While (Window.IsActive() && Window.IsPanel() && this.OfflinePanelBLCIcon.GetColour() = "0xEE1C24") {
            Travel.ClosePanel()
        }
    }
    ;@endregion

    ;@region OpenFishing()
    /**
     * Open fishing panel while in challenge
     */
    OpenFishing() {
        While (!Window.IsPanel() && !this.Fishing.Pond1.CastRod.IsButton()) {
            Travel.ClosePanelIfActive()
            Sleep(34)
            If (this.FishPanelFixed.IsButtonActive()) {
                this.FishPanelFixed.ClickButtonActive()
            } Else If (this.FishPanel3.IsButtonActive()) {
                this.FishPanel3.ClickOffset()
            } Else If (this.FishPanel2.IsButtonActive()) {
                this.FishPanel2.ClickOffset()
            } Else {
                this.FishPanel.ClickOffset()
            }
        }
    }
    ;@endregion

    ;@region StopChallengeMain()
    /**
     * Description
     */
    StopChallengeMain() {
        Travel.ClosePanelIfActive()
        While (!Window.IsPanel()) {
            this.ChallengePanel.ClickOffset()
            Window.AwaitPanel()
        }
        Travel.ScrollResetToTop()
        If (this.ChallengeStop.IsButton()) {
            this.ChallengeStop.ClickOffset()
            this.ChallengeStop.ClickOffset()
            this.ChallengeStopConfim.WaitUntilActiveButtonS(2)
            If (this.ChallengeStopConfim.IsButtonActive()) {
                this.ChallengeStopConfim.ClickOffset()
                this.ChallengeStopConfim.ClickOffset()
            }
            this.CheckForGameReload()
            Out.I("Stopped active challenge")
        } Else {
            Out.I("No challenge active")
        }
    }
    ;@endregion

    ;@region StopChallengeDuring()
    /**
     * Description
     */
    StopChallengeDuring() {
        Travel.ClosePanelIfActive()
        While (!Window.IsPanel()) {
            ; Uses different location during challenge
            this.ChallengePanel2.ClickOffset()
            Window.AwaitPanel()
        }
        Travel.ScrollResetToTop()
        If (this.ChallengeReturnToMain.IsButton()) {
            this.ChallengeReturnToMain.ClickOffset()
            this.ChallengeReturnToMain.ClickOffset()
            this.ChallengeStopConfim.WaitUntilActiveButtonS(2)
            If (this.ChallengeStopConfim.IsButtonActive()) {
                this.ChallengeStopConfim.ClickOffset()
                this.ChallengeStopConfim.ClickOffset()
            }
            this.CheckForGameReload()
            Out.I("Returned from challenge to main mode")
        } Else {
            Out.I("Already in main mode")
        }
    }
    ;@endregion

    ;@region StartChallenge()
    /**
     * Description
     */
    StartChallenge() {
        If (!this.IsChallengePanel()) {
            Travel.ClosePanelIfActive()
            While (!Window.IsPanel() && !this.IsChallengePanel()) {
                this.ChallengePanel.ClickOffset()
                Window.AwaitPanel()
            }
        }
        Travel.ScrollResetToTop()
        ; If in a challenge or challenge remains started close it
        If (this.ChallengeStop.IsButton()) {
            this.ChallengeStop.ClickOffset()
            this.ChallengeStop.ClickOffset()
            this.ChallengeStopConfim.WaitUntilActiveButtonS(2)
            If (this.ChallengeStopConfim.IsButtonActive()) {
                this.ChallengeStopConfim.ClickOffset()
                this.ChallengeStopConfim.ClickOffset()
            }
            this.CheckForGameReload()
            Out.I("Challenge was reset at StartChallenge")
            this.StartChallenge()
            Return
        }
        ; 4 shift + wheel down for fishing challenge
        Travel.ScrollAmountDown(28)
        ; Start Challenge
        While (this.ChallengeStart.IsButtonActive()) {
            this.ChallengeStart.ClickButtonActive()
        }
        ; Wait for game reload
        this.CheckForGameReload()
    }
    ;@endregion

    ;@region MaxTransmuteToCredits()
    /**
     * Go to transmute and transmute max of all currency to Fish Credits
     */
    MaxTransmuteToCredits() {
        this.Fishing.Tabs.Transmute.ClickButtonActive()
        this.Fishing.Transmute.TrashToCreditsMax.WaitUntilButtonS()
        this.Fishing.Transmute.TrashToCreditsMax.ClickButtonActive()
        this.Fishing.Transmute.AdvancedToCrystalMax.ClickButtonActive()
    }
    ;@endregion

    ;@region ShopUpgrade()
    /**
     * Upgrade fishing shop to max available prioritising important upgrades
     */
    ShopUpgrade() {
        this.Fishing.Tabs.Shop.ClickButtonActive()
        this.Fishing.Shop.BuySpot.WaitUntilActiveButtonS()
        this.Fishing.Shop.BuySpot.ClickButtonActive()
    }
    ;@endregion

    ;@region IsChallengePanel()
    /**
     * 
     */
    IsChallengePanel() {
        If (Window.IsPanel() && this.SeedClear.IsButton() && this.SeedRandom.IsButton() && this.SeedSet.IsButton()) {
            Return true
        }
        Return false
    }
    ;@endregion
}
