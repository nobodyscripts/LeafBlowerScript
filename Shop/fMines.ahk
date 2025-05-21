#Requires AutoHotkey v2.0

#Include ..\Lib\Logging.ahk
#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTravel.ahk

/**
 * Mine class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class sMine extends Zone {

    ;@region cFeatureMine main travel
    /**
     * Go to mine panel can return on any tab
     * @param {Boolean} [reset=false] Click first tab after travel?
     * @returns {Boolean} Is panel active
     */
    GoTo(reset := false) {
        If (!reset) {
            Return Shops.OpenMining(false)
        } Else {
            Shops.OpenMining(false)
            If (Points.Mine.Tab1Vein.IsButtonActive()) {
                Points.Mine.Tab1Vein.Click()
                Sleep(NavigateTime)
            }
            Return Window.IsPanel()
        }
    }
    ;@endregion

    ;@region Vein Tab
    /**
     * Go to mine panel > vein tab
     */
    GoToTabVein() {
        Shops.OpenMining(false)

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
        If (Points.Mine.Vein.Search.IsButton() && Points.Mine.Vein.AutoMine.IsButton()) {
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
        If (Points.Mine.Cave.Select1.IsButton() && Points.Mine.Cave.AutoSearch.IsButton()) {
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
        If (Points.Mine.CoalSphere.IsButton() && Points.Mine.FreeFuel.IsButton()) {
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
        T := Points.Mine.Transmute
        If (T.SingleCBarToCDia.IsButton() && T.SingleCDiaToSDia.IsButton() &&
        T.SingleCDiaToFuel.IsButton() && T.SingleCDiaToSphere.IsButton() &&
        T.AllCBarsToCDias.IsButton() && T.AllCDiasToSDias.IsButton() &&
        T.AllCDiasToFuel.IsButton() && T.AllCDiasToSpheres.IsButton() &&
        T.AllSDiasToCDia.IsButton()) {
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
