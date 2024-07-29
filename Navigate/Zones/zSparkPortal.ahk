#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * SparkPortal class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class SparkPortal extends Zone {
    ; The name of the zone for display purposes
    Name := "Spark Portal"
    ; The colour of the SparkPortal pixel for the zone
    ZoneColour := this.GetColourByName("Spark Portal")
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
        ;Points.Areas.SacredN.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local SparkPortalLeaf := this.FindSparkPortalZone()
        If (SparkPortalLeaf) {
            this.ClickTravelButton(SparkPortalLeaf, delay + extradelay)
        } Else {
            Out.I("Spark Portal leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindSparkPortalZone() {
        ; Change this if used
        ;return Rects.SacredN.SparkPortalTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Spark Portal
        ;Button := Points.Areas.SacredN.SparkPortal
        Button := cPoint()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Out.I("Spark Portal travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}