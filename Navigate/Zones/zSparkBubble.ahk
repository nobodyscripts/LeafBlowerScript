#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * SparkBubble class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class SparkBubble extends Zone {
    ; The name of the zone for display purposes
    Name := "Spark Bubble"
    ; The colour of the SparkBubble pixel for the zone
    ZoneColour := this.GetColourByName("Spark Bubble")
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
        Local SparkBubbleLeaf := this.FindSparkBubbleZone()
        If (SparkBubbleLeaf) {
            this.ClickTravelButton(SparkBubbleLeaf, delay + extradelay)
        } Else {
            Out.I("Spark Bubble leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindSparkBubbleZone() {
        ; Change this if used
        ;return Rects.SacredN.SparkBubbleTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Spark Bubble
        ;Button := Points.Areas.SacredN.SparkBubble
        Button := cPoint()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Out.I("Spark Bubble travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}