#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ..\Lib\cLBRButton.ahk
#Include ..\Navigate\Harbor\HarborCoords.ahk

; TODO Travel and opening review

S.AddSetting("Harbor", "HarborJobRefresh", true, "bool")
S.AddSetting("Harbor", "HarborShopMax", true, "bool")
S.AddSetting("Harbor", "HarborShipsClaim", true, "bool")
S.AddSetting("Harbor", "HarborJourneyClaim", true, "bool")
S.AddSetting("Harbor", "HarborShopTimer", 120, "int")
S.AddSetting("Harbor", "HarborShipsTimer", 30, "int")
S.AddSetting("Harbor", "HarborJourneyTimer", 300, "int")

/**
 * Harbor Class to contain all Harbor related functions
 * @module Harbor
 */
Class Harbor {

    ;@region Properties
    /**
     * Copy points to shortcut
     * @type {cHarborPoints}
     */
    ;Points := cHarborPoints()
    ;@endregion

    ;@region fHarborManager()
    /**
     * Manage tasks in Harbor - External start point
     */
    startHarborManager() {
        HarborJobRefresh := S.Get("HarborJobRefresh")
        HarborShopMax := S.Get("HarborShopMax")
        HarborShipsClaim := S.Get("HarborShipsClaim")
        HarborJourneyClaim := S.Get("HarborJourneyClaim")
        HarborShopTimer := S.Get("HarborShopTimer")
        HarborShipsTimer := S.Get("HarborShipsTimer")
        HarborJourneyTimer := S.Get("HarborJourneyTimer")

        Window.StartOrReload()

        StartTime := A_TickCount

        JourneyTime := A_Now
        ShopTime := A_Now
        ShipsTime := A_Now
        Loop {
            If (!Window.IsActive()) {
                Break
            }
            If (HarborJobRefresh) {
                 this.JobRefresh()
            }

            If (HarborShipsClaim &&
                DateDiff(A_Now, ShipsTime, "S") > HarborShipsTimer) {
                this.ShipsClaim()
                ShipsTime := A_Now
            }

            If (HarborJourneyClaim &&
                DateDiff(A_Now, JourneyTime, "S") > HarborJourneyTimer) {
                this.JourneyCollect()
                JourneyTime := A_Now
            }

            ; Do claims before buying stuff so we don't sit on currency
            If (HarborShopMax &&
                DateDiff(A_Now, ShopTime, "S") > HarborShopTimer) {
                this.ShopMax()
                ShopTime := A_Now
            }
        }
    }
    ;@endregion

    ;@region JobRefresh()
    /**
     * Refresh and claim jobs in the harbor overview tab
     */
    JobRefresh() {
        While (!Points.Harbor.Overview.IsOnTab()) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.Tab.ClickButtonActive(, 5)
        }
        ; Just always claim diver as theres no gain to waiting
        Points.Harbor.Overview.ClaimDiver.ClickButtonActive(, 5)

        ; If any claimable jobs, claim all
        If (this.IsClaimableJob()) {
            Points.Harbor.Overview.ClaimAll.ClickButtonActive(, 5)
        }
        If (Points.Harbor.Overview.JobAddLeaf1.IsBackground() &&
        Points.Harbor.Overview.JobClaim1.IsBackground()) {
            Sleep(54)
            Points.Harbor.Overview.RefreshJobs.ClickButtonActive(, 5)
        }
        While (this.IsJobNeedingLeaves(1)) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.JobAddLeaf1.ClickButtonActive(, 5)
        }
        Points.Harbor.Overview.JobDeliver1.ClickButtonActive(, 5)

        While (this.IsJobNeedingLeaves(2)) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.JobAddLeaf2.ClickButtonActive(, 5)
        }
        Points.Harbor.Overview.JobDeliver2.ClickButtonActive(, 5)

        While (this.IsJobNeedingLeaves(3)) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.JobAddLeaf3.ClickButtonActive(, 5)
        }
        Points.Harbor.Overview.JobDeliver3.ClickButtonActive(, 5)

        While (this.IsJobNeedingLeaves(4)) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.JobAddLeaf4.ClickButtonActive(, 5)
        }
        Points.Harbor.Overview.JobDeliver4.ClickButtonActive(, 5)

        While (this.IsJobNeedingLeaves(5)) {
            Window.ActiveOrReload()
            Points.Harbor.Overview.JobAddLeaf5.ClickButtonActive(, 5)
        }
        Points.Harbor.Overview.JobDeliver5.ClickButtonActive(, 5)
    }
    ;@endregion

    IsClaimableJob() {
        If (Points.Harbor.Overview.JobClaim1.IsButtonActive() ||
        Points.Harbor.Overview.JobClaim2.IsButtonActive() ||
        Points.Harbor.Overview.JobClaim3.IsButtonActive() ||
        Points.Harbor.Overview.JobClaim4.IsButtonActive() ||
        Points.Harbor.Overview.JobClaim5.IsButtonActive()) {
            Return true
        }
        Return false
    }

    IsJobNeedingLeaves(JobNum) {
        Switch (JobNum) {
        Case 1:
            If (Points.Harbor.Overview.JobClaim1.IsBackground() && Points.Harbor.Overview.JobAddLeaf1.IsButtonActive()) {
                Return true
            }
            Return false
        Case 2:
            If (Points.Harbor.Overview.JobClaim2.IsBackground() && Points.Harbor.Overview.JobAddLeaf2.IsButtonActive()) {
                Return true
            }
            Return false
        Case 3:
            If (Points.Harbor.Overview.JobClaim3.IsBackground() && Points.Harbor.Overview.JobAddLeaf3.IsButtonActive()) {
                Return true
            }
            Return false
        Case 4:
            If (Points.Harbor.Overview.JobClaim4.IsBackground() && Points.Harbor.Overview.JobAddLeaf4.IsButtonActive()) {
                Return true
            }
            Return false
        Case 5:
            If (Points.Harbor.Overview.JobClaim5.IsBackground() && Points.Harbor.Overview.JobAddLeaf5.IsButtonActive()) {
                Return true
            }
            Return false
        default:
        }
    }

    ;@region ShipsClaim()
    /**
     * Claim all ships in the harbor ships tab
     */
    ShipsClaim() {
        Out.I("Ships Claim")
        While (!Points.Harbor.Ships.IsOnTab()) {
            Window.ActiveOrReload()
            Points.Harbor.Ships.Tab.ClickButtonActive(, 5)
        }
        Points.Harbor.Ships.ClaimAll.ClickButtonActive(, 5)
    }
    ;@endregion

    ;@region JourneyCollect()
    /**
     * Claim journey rewards in the harbor journey tab
     */
    JourneyCollect() {
        Out.I("Journey Collect")
        While (!Points.Harbor.Journey.IsOnTab()) {
            Window.ActiveOrReload()
            Points.Harbor.Journey.Tab.ClickButtonActive(, 5)
        }
        Points.Harbor.Journey.ClaimAll.WaitUntilButtonS(0.5)
        If (Points.Harbor.Journey.ClaimAll.IsButton()) {
            Points.Harbor.Journey.ClaimAll.ClickButtonActive(, 5)
            Points.Harbor.Journey.ClaimAll.ClickButtonActive(, 5)
        }
        Points.Harbor.Journey.Complete.WaitUntilButtonS(0.5)
        Points.Harbor.Journey.Complete.ClickButtonActive(, 5)
        Points.Harbor.Journey.Complete.ClickButtonActive(, 5)
    }
    ;@endregion

    ;@region ShopMax()
    /**
     * Buy max items in the harbour shop tab
     */
    ShopMax() {
        Out.I("Shop Max")
        While (!Points.Harbor.Shop.IsOnTab()) {
            Window.ActiveOrReload()
            Points.Harbor.Shop.Tab.ClickButtonActive(, 5)
        }
        SetModifierKeys(false, false, true)
        Points.Harbor.Shop.BuyMaxShop.WaitUntilButtonS(0.5)
        Points.Harbor.Shop.BuyMaxShop.ClickButtonActive(, 5)
        Points.Harbor.Shop.BuyMaxShop.ClickButtonActive(, 5)
        ResetModifierKeys()
    }
    ;@endregion

    ;@region ShopUpgrade()
    /**
     * Upgrade Harbor shop to max available prioritising important upgrades
     */
    ShopUpgrade(challenge := false) {
        Out.I("Shop Upgrade")
        While (!Points.Harbor.Shop.IsOnTab()) {
            Points.Harbor.Shop.Tab.ClickButtonActive(, 5)
        }

    }
    ;@endregion

}
