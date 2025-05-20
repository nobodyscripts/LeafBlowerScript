#Requires AutoHotkey v2.0

/**
 * FishingChallenge class to handle the functions, singlepass and loop of completing the fishing challenge
 * @module FishingChallenge
 * @method StartSingle Desc
 * @method StartLoop Desc
 * @method StartAmount Desc
 */
Class FishingChallenge {
    /** @type {cPoint} Challenges button, fixed nav activebutton */
    ChallengePanel := cPoint(792, 144)
    /** @type {cPoint} Return to main mode from challenge */
    ChallengeReturnToMain := cPoint(690, 377)
    /** @type {cPoint} Stop challenges button in challenges screen */
    ChallengeStop := cPoint(1169, 376)
    /** @type {cPoint} Confirm stop challenge button */
    ChallengeStopConfim := cPoint(1401, 557)
    /** @type {cPoint} Start fishing challenge button
     * 28 scroll down */
    ChallengeStart := cPoint(1815, 599)
    /** @type {cPoint} Complete page medal icon point Color: #C87B00
     * Closing closes panel entirely */
    ChallengeCompleteMedal := cPoint(330, 462)
    /** @type {cPoint} Challenge button while inside fishing challenge */
    ChallengePanel2 := cPoint(580, 56)
    /** @type {cPoint} First bottom bar button (fishing/tool) */
    FishPanel := cPoint(178, 1286)
    /** @type {cPoint} Second bottom bar button (fishing after leaf) */
    FishPanel2 := cPoint(251, 1285)
    /** @type {cPoint} Third bottom bar button (fishing after leaf) */
    FishPanel3 := cPoint(323, 1283)
    /** @type {cPoint} BLC icon in the offline rewards screen, to check
     * if game has returned from challenge 0xEE1C24 */
    OfflinePanelBLCIcon := cPoint(655, 441)

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
        this.StopChallengeMain()
        this.StartChallenge()
        this.OpenFishing()

        JourneyTime := A_Now
        TransmuteTime := A_Now
        RodsTime := A_Now
        ShopTime := A_Now
        StartTime := A_TickCount - (FishCatchingDelay * 1000)
        Time1 := StartTime
        Time2 := StartTime
        Time3 := StartTime
        Time4 := StartTime
        Loop {
            If (!Window.IsActive()) {
                Break
            }

            this.Fishing.FishPonds(&Time1, &Time2, &Time3, &Time4, true)
            If (DateDiff(A_Now, JourneyTime, "S") > 120) {
                this.Fishing.JourneyCollect()
                JourneyTime := A_Now
            }
            If (DateDiff(A_Now, TransmuteTime, "S") > 60) {
                this.MaxTransmuteToCredits()
                TransmuteTime := A_Now
            }
            If (DateDiff(A_Now, RodsTime, "S") > 60) {
                this.Fishing.UpgradeRods()
                RodsTime := A_Now
            }
            If (DateDiff(A_Now, ShopTime, "S") > 60) {
                this.ShopUpgrade()
                ShopTime := A_Now
            }
            ; If challenge complete panel shown
            If (this.ChallengeCompleteMedal.GetColour() = "") {
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
        While (amount > 0) {
            this.StartSingle()
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
            If (this.FishPanel3.IsButtonActive()) {
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
        If (this.ChallengeStop.IsButton()) {
            this.ChallengeStop.ClickOffset()
            this.ChallengeStop.ClickOffset()
            If (this.ChallengeStopConfim.IsButtonActive()) {
                this.ChallengeStopConfim.ClickOffset()
                this.ChallengeStopConfim.ClickOffset()
            }
            this.CheckForGameReload()
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
            this.ChallengePanel2.ClickOffset()
            Window.AwaitPanel()
        }
        If (this.ChallengeReturnToMain.IsButton()) {
            this.ChallengeReturnToMain.ClickOffset()
            this.ChallengeReturnToMain.ClickOffset()
            If (this.ChallengeStopConfim.IsButtonActive()) {
                this.ChallengeStopConfim.ClickOffset()
                this.ChallengeStopConfim.ClickOffset()
            }
            this.CheckForGameReload()
        }
    }
    ;@endregion

    ;@region StartChallenge()
    /**
     * Description
     */
    StartChallenge() {
        Travel.ClosePanelIfActive()
        this.ChallengePanel.ClickOffset()
        Window.AwaitPanel()

        ; If in a challenge or challenge remains started close it
        If (this.ChallengeStop.IsButton()) {
            this.ChallengeStop.ClickOffset()
            this.ChallengeStop.ClickOffset()
            this.CheckForGameReload()
        }

        this.ChallengePanel.ClickOffset()
        Window.AwaitPanel()
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
}
