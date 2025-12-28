#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Harbor points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} HarborScreen Toobar button to open harbor
 * @property {HarborOverview} Overview Sub class for Harbor Overview tab
 * @property {HarborShop} Shop Sub class for Harbor Shop tab
 * @property {HarborShips} Ships Sub class for Harbor Ships tab
 * @property {HarborJourney} Journey Sub class for Harbor Journey tab
 * @property {cLBRButton} InventoryTab Button to open Inventory tab
 */
Class cHarborPoints {
    /**
     * Toobar button to open harbor
     * @type {cLBRButton}
     */
    HarborScreen := cLBRButton(428, 1125)

    /**
     * Sub class for Harbor Overview tab
     * @type {HarborOverview}
     */
    Overview := HarborOverview()

    /**
     * Sub class for Harbor Shop tab
     * @type {HarborShop}
     */
    Shop := HarborShop()

    /**
     * Sub class for Harbor Ships tab
     * @type {HarborShips}
     */
    Ships := HarborShips()

    /**
     * Sub class for Harbor Journey tab
     * @type {HarborJourney}
     */
    Journey := HarborJourney()

    /**
     * Button to open Inventory tab
     * @type {cLBRButton}
     */
    InventoryTab := cLBRButton(1350, 1180)
}

;@region HarborOverview
/**
 * Points class to contain points of the harbor overview tab
 * @module HarborOverview
 * @memberof module:cHarborPoints
 * @property {cLBRButton} Tab Button to open Overview tab
 * @property {cLBRButton} ClaimDiver Button to claim diver generated resources on overview tab
 * @property {cLBRButton} ClaimAll Button to claim all complete delivery jobs on overview tab
 * @property {cLBRButton} RefreshJobs Button to refresh delivery jobs on overview tab
 * @property {cLBRButton} JobClaim1 Button to claim delivery job 1 on overview tab
 * @property {cLBRButton} JobAddLeaf1 Button to add leaves to delivery job 1 on overview tab
 * @property {cLBRButton} JobDeliver1 Button to deliver delivery job 1 on overview tab
 * @property {cLBRButton} JobClaim2 Button to claim delivery job 2 on overview tab
 * @property {cLBRButton} JobAddLeaf2 Button to add leaves to delivery job 2 on overview tab
 * @property {cLBRButton} JobDeliver2 Button to deliver delivery job 2 on overview tab
 * @property {cLBRButton} JobClaim3 Button to claim delivery job 3 on overview tab
 * @property {cLBRButton} JobAddLeaf3 Button to add leaves to delivery job 3 on overview tab
 * @property {cLBRButton} JobDeliver3 Button to deliver delivery job 3 on overview tab
 * @property {cLBRButton} JobClaim4 Button to claim delivery job 4 on overview tab
 * @property {cLBRButton} JobAddLeaf4 Button to add leaves to delivery job 4 on overview tab
 * @property {cLBRButton} JobDeliver4 Button to deliver delivery job 4 on overview tab
 * @property {cLBRButton} JobClaim5 Button to claim delivery job 5 on overview tab
 * @property {cLBRButton} JobAddLeaf5 Button to add leaves to delivery job 5 on overview tab
 * @property {cLBRButton} JobDeliver5 Button to deliver delivery job 5 on overview tab
 */
Class HarborOverview {
    /**
     * Button to open Overview tab
     * @type {cLBRButton}
     */
    Tab := cLBRButton(514, 1180)

    /**
     * Button to claim diver generated resources on overview tab
     * @type {cLBRButton}
     */
    ClaimDiver := cLBRButton(625, 925)

    /**
     * Button to claim all complete delivery jobs on overview tab
     * @type {cLBRButton}
     */
    ClaimAll := cLBRButton(1880, 315)

    /**
     * Button to refresh delivery jobs on overview tab
     * @type {cLBRButton}
     */
    RefreshJobs := cLBRButton(2085, 290)

    /**
     * Button to claim delivery job 1 on overview tab
     * @type {cLBRButton}
     */
    JobClaim1 := cLBRButton(1718, 426)

    /**
     * Button to add leaves to delivery job 1 on overview tab
     * @type {cLBRButton}
     */
    JobAddLeaf1 := cLBRButton(1640, 401)

    /**
     * Button to deliver delivery job 1 on overview tab
     * @type {cLBRButton}
     */
    JobDeliver1 := cLBRButton(1882, 401)

    /**
     * Button to claim delivery job 2 on overview tab
     * @type {cLBRButton}
     */
    JobClaim2 := cLBRButton(1718, 565)

    /**
     * Button to add leaves to delivery job 2 on overview tab
     * @type {cLBRButton}
     */
    JobAddLeaf2 := cLBRButton(1640, 541)

    /**
     * Button to deliver delivery job 2 on overview tab
     * @type {cLBRButton}
     */
    JobDeliver2 := cLBRButton(1882, 541)

    /**
     * Button to claim delivery job 3 on overview tab
     * @type {cLBRButton}
     */
    JobClaim3 := cLBRButton(1718, 704)

    /**
     * Button to add leaves to delivery job 3 on overview tab
     * @type {cLBRButton}
     */
    JobAddLeaf3 := cLBRButton(1640, 681)

    /**
     * Button to deliver delivery job 3 on overview tab
     * @type {cLBRButton}
     */
    JobDeliver3 := cLBRButton(1882, 681)

    /**
     * Button to claim delivery job 4 on overview tab
     * @type {cLBRButton}
     */
    JobClaim4 := cLBRButton(1718, 842)

    /**
     * Button to add leaves to delivery job 4 on overview tab
     * @type {cLBRButton}
     */
    JobAddLeaf4 := cLBRButton(1640, 821)

    /**
     * Button to deliver delivery job 4 on overview tab
     * @type {cLBRButton}
     */
    JobDeliver4 := cLBRButton(1882, 821)

    /**
     * Button to claim delivery job 5 on overview tab
     * @type {cLBRButton}
     */
    JobClaim5 := cLBRButton(1718, 982)

    /**
     * Button to add leaves to delivery job 5 on overview tab
     * @type {cLBRButton}
     */
    JobAddLeaf5 := cLBRButton(1640, 958)

    /**
     * Button to deliver delivery job 5 on overview tab
     * @type {cLBRButton}
     */
    JobDeliver5 := cLBRButton(1882, 958)

    IsOnTab() {
        If (this.ClaimDiver.IsButton() && this.ClaimAll.IsButton() && this.RefreshJobs.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region HarborShop
/**
 * Points class to contain points of the harbor shop tab
 * @module HarborShop
 * @property {cLBRButton} Tab Button to open Shop tab
 * @property {cLBRButton} BuyMaxShop Button to buy max on shop tab
 */
Class HarborShop {
    /**
     * Button to open Shop tab
     * @type {cLBRButton}
     */
    Tab := cLBRButton(790, 1180)

    /**
     * Button to buy max on shop tab
     * @type {cLBRButton}
     */
    BuyMaxShop := cLBRButton(610, 1105)

    IsOnTab() {
        If (this.BuyMaxShop.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region HarborShips
/**
 * Points class to contain points of the harbor ships tab
 * @module HarborShips
 * @property {cLBRButton} Tab Button to open ships tab
 * @property {cLBRButton} ClaimAll Button to claim all on ships tab
 */
Class HarborShips {
    /**
     * Button to open Ships tab
     * @type {cLBRButton}
     */
    Tab := cLBRButton(1080, 1180)

    /**
     * Button to claim all completed ships on ships tab
     * @type {cLBRButton}
     */
    ClaimAll := cLBRButton(1977, 315)

    IsOnTab() {
        If (this.ClaimAll.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion

;@region HarborJourney
/**
 * Points class to contain points of the harbor journey tab
 * @module HarborJourney
 * @property {cLBRButton} Tab Button to open Journey tab
 * @property {cLBRButton} ClaimAll Button to claim all on journey tab
 * @property {cLBRButton} Complete Collect reset bonus
 */
Class HarborJourney {
    /**
     * Button to open Journey tab
     * @type {cLBRButton}
     */
    Tab := cLBRButton(1630, 1180)

    /**
     * Button to claim all on journey tab
     * @type {cLBRButton}
     */
    ClaimAll := cLBRButton(520, 620)

    /**
     * Collect reset bonus
     * @type {cLBRButton} 
     */
    Complete := cLBRButton(1243, 836)

    IsOnTab() {
        If (this.ClaimAll.IsButton()) {
            Return true
        }
        Return false
    }
}
;@endregion
