#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * TheLeafTower class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheLeafTower extends Zone {
    ; The name of the zone for display purposes
    Name := "The Leaf Tower"
    ; The colour of the TheLeafTower pixel for the zone
    ZoneColour := this.GetColourByName("The Leaf Tower")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(17, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local TheLeafTowerLeaf := this.FindTheLeafTowerZone()
        If (TheLeafTowerLeaf) {
            this.ClickTravelButton(TheLeafTowerLeaf, delay + extradelay)
        } Else {
            Out.I("The Leaf Tower leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        return this.IsZone()
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheLeafTowerZone() {
        ; Change this if used
        /* Rects.Areas.LeafGalaxy.LeafTower.ToolTipAtArea()
        Sleep(2000) */
        Return Rects.Areas.LeafGalaxy.LeafTower.PixelSearch("0xC5D8E0")
        ;Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Leaf Tower
        ;Button := Points.Areas.LeafGalaxy.TheLeafTower
        Button := cPoint(coord[1] + Window.RelW(60), coord[2], false)
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Out.I("The Leaf Tower travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
    ;@region MaxTowerFloor()
    /**
     * MaxTowerFloor, go to leaf tower but max floor first
     * @param delay 
     */
    MaxTowerFloor(delay := 72) {
        Out.D("Leaf tower max floor")
        Travel.OpenAreasLeafGalaxy()
        Travel.ScrollResetToTop()
        ; Scroll down if needed
        this.ScrollAmountDown(14, NavigateTime)

        /** @type {cPoint} Button to travel to Leafsink Harbor*/
        LSButton := cPoint(1853, 759)
        /** @type {cPoint} */
        TowerMax := cPoint(2134, 977)
        /** @type {cPoint} */
        TowerArea := cPoint(1861, 914)

        LSButton.WaitUntilActiveButton(200, 17)
        ; If no button we are misaligned
        LSButton.ClickButtonActive(, , delay, NavigateTime + delay)
        Sleep(delay)
        LSButton.ClickButtonActive(, , delay, NavigateTime + delay)
        If (!this.IsZone("Leafsink Harbor")) {
            Out.I("The Leaf Tower travel: Leafsink harbor travel failed.")
            Return false
        }

        TowerMax.WaitUntilActiveButton(200, 17)
        TowerMax.ClickButtonActive(, , delay, NavigateTime + delay)
        Sleep(delay)
        TowerMax.ClickButtonActive(, , delay, NavigateTime + delay)
        
        TowerArea.WaitUntilActiveButton(200, 17)
        While (TowerArea.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Sleep(delay)
        }
        Sleep(NavigateTime + delay)
        Return this.IsZone()
    }
    ;@endregion
}
/* GoToLeafTower(*) {
    Travel.OpenAreas()
    Travel.ScrollAmountDown(16) ; Scroll down for the zones
    Sleep(101)

    ; Leaf pixel search
    ; Look for colour of a segment of the rightmost tower leaf c5d8e0
    spot := Rects.Areas.LeafTower.PixelSearch("0xC5D8E0")
    If (!spot) {
        ; Not found
        Out.I("TowerBoost: Could not find tower leaf to open area.")
        Return false
    }
    LeafsingButton := cPoint(spot[1] + Window.RelW(69), spot[2] - Window.RelH(
        160), false)
    ; Open leafsing harbor to allow max level reset
    If (LeafsingButton.IsBackground()) {
        ; Background colour found
        Out.I("Error 30: Tower alt area detection failed. Alignment2.")
        Return false
    }
    LeafsingButton.Click(101)
    Sleep(201)

    TowerMax := cPoint(spot[1] + Window.RelW(460), spot[2] + Window.RelH(60),
        false)
    ; Max Tower level
    If (!TowerMax.IsButtonActive()) {
        Out.I("Error 31: Tower max detection failed. Alignment3.")
        Return false
    }
    TowerMax.Click(101)
    Sleep(101)

    TowerArea := cPoint(spot[1] + Window.RelW(69), spot[2] - Window.RelH(5),
        false)
    ; Select Tower area
    If (!TowerArea.IsButtonActive()) {
        Out.I("Error 32: Tower area detection failed. Could not find "
            " Leaf Tower Travel Button.")
        Return
    }
    TowerArea.Click(101)
    Sleep(201)
} */
