#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * Mine class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class Mine extends Zone {

    ;@region Mine main travel
    /**
     * Go to mine panel can return on any tab
     * @param {Boolean} [reset=false] Click first tab after travel?
     * @returns {Boolean} Is panel active
     */
    GoTo(reset := false) {
        If (!reset) {
            Return Travel.OpenMining(false)
        } Else {
            Travel.OpenMining(false)
            If (Points.Mine.Tab1Vein.IsButtonActive()) {
                Points.Mine.Tab1Vein.Click()
                Sleep(NavigateTime)
            }
            Return IsPanelActive()
        }
    }
    ;@endregion

    ;@region Vein Tab
    /**
     * Go to mine panel > vein tab
     */
    GoToTabVein() {
        Travel.OpenMining(false)

        Points.Mine.Tab1Vein.Click()
        Sleep(NavigateTime)
        Points.Mine.Tab1Vein.Click()
        Sleep(NavigateTime)
    }

    /**
     * Is current panel on Mine Coal Vein tab
     * @returns {Integer} 
     */
    IsOnTabVein() {
        If (Points.Mine.Vein.Search.IsButton() && Points.Mine.Vein.AutoMine.IsButton()
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Mines/Caves Tab
    /**
     * Go to mine panel > mines tab
     */
    GoToTabMines() {
        this.Goto()
        Points.Mine.Tab2Mines.Click()
        Sleep(NavigateTime)
        Points.Mine.Tab2Mines.Click()
        Sleep(NavigateTime)
    }

    /**
     * Is current panel on Mine Caves tab
     * @returns {Integer} 
     */
    IsOnTabMines() {
        If (Points.Mine.Cave.Select1.IsButton() && Points.Mine.Cave.AutoSearch.IsButton()
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Inventory Tab
    /**
     * Go to mine panel > inventory tab
     */
    GoToTabInv() {
        Throw Error("Mine.GoToTabInv not implimented")
    }
    ;@endregion

    ;@region Drill Tab
    /**
     * Go to mine panel > drill tab
     */
    GoToTabDrill() {
        this.Goto()
        Points.Mine.Tab4Drill.Click()
        Sleep(NavigateTime)
        Points.Mine.Tab4Drill.Click()
        Sleep(NavigateTime)
    }
    /**
     * Is current panel on Mine Drill tab
     * @returns {Integer} 
     */
    IsOnTabDrill() {
        If (Points.Mine.CoalSphere.IsButton() && Points.Mine.FreeFuel.IsButton()
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Shop Tab
    /**
     * Go to mine panel > shop tab
     */
    GoToTabShop() {
        this.Goto()
        Points.Mine.Tab5Shop.Click()
        Sleep(NavigateTime)
        Points.Mine.Tab5Shop.Click()
        Sleep(NavigateTime)
    }
    ;@endregion

    ;@region Transmute Tab
    /**
     * Go to mine panel > transmute tab
     */
    GoToTabTrans() {
        this.Goto()
        Points.Mine.Tab6Transmute.Click()
        Sleep(NavigateTime)
        Points.Mine.Tab6Transmute.Click()
        Sleep(NavigateTime)
    }

    /**
     * Is current panel on Mine Transmute tab
     * @returns {Integer} 
     */
    IsOnTabTrans() {
        If (!Points.Mine.Transmute.SingleCBarToCDia.IsBackground() && !Points.Mine
            .Transmute.SingleCDiaToSDia.IsBackground() && !Points.Mine.Transmute
            .SingleCDiaToFuel.IsBackground() && !Points.Mine.Transmute.SingleCDiaToSphere
            .IsBackground() && !Points.Mine.Transmute.AllCBarsToCDias.IsBackground() &&
            !Points.Mine.Transmute.AllCDiasToSDias.IsBackground() && !Points.Mine
            .Transmute.AllCDiasToFuel.IsBackground() && !Points.Mine.Transmute.AllCDiasToSpheres
            .IsBackground() && !Points.Mine.Transmute.AllSDiasToCDia.IsBackground() &&
            !Points.Mine.Transmute.AutoCBarToCDia.IsBackground() && !Points.Mine
            .Transmute.AutoCDiaToSDia.IsBackground() && !Points.Mine.Transmute.AutoCDiaToFuel
            .IsBackground() && !Points.Mine.Transmute.AutoCDiaToSphere.IsBackground()
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region Codex Tab
    /**
     * Go to mine panel > codex tab
     */
    GoToTabCodex() {
        Throw Error("Mine.GoToTabCodex not implimented")
    }
    ;@endregion


}