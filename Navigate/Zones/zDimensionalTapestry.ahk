#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * DimensionalTapestry class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class DimensionalTapestry extends Zone {
    ; The name of the zone for display purposes
    Name := "Dimensional Tapestry"
    ; The colour of the DimensionalTapestry pixel for the zone
    ZoneColour := this.GetColourByName("Dimensional Tapestry")
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
        ;Points.Areas.QuarkA.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local DimensionalTapestryLeaf := this.FindDimensionalTapestryZone()
        If (DimensionalTapestryLeaf) {
            this.ClickTravelButton(DimensionalTapestryLeaf, delay + extradelay)
        } Else {
            Log("Dimensional Tapestry leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindDimensionalTapestryZone() {
        ; Change this if used
        ;return Rects.QuarkA.DimensionalTapestryTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Dimensional Tapestry
        ;Button := Points.Areas.QuarkA.DimensionalTapestry
        Button := cPoint()
        DebugLog("Zone travel button colour " Button.GetColour() )
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Log("Dimensional Tapestry travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}