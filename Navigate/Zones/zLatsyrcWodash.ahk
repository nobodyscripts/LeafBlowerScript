#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * LatsyrcWodash class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class LatsyrcWodash extends Zone {
    ; The name of the zone for display purposes
    Name := "Latsyrc Wodash"
    ; The colour of the LatsyrcWodash pixel for the zone
    ZoneColour := this.GetColourByName("Latsyrc Wodash")
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
        ;Points.Areas.UmbralCluster.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local LatsyrcWodashLeaf := this.FindLatsyrcWodashZone()
        If (LatsyrcWodashLeaf) {
            this.ClickTravelButton(LatsyrcWodashLeaf, delay + extradelay)
        } Else {
            Out.I("Latsyrc Wodash leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindLatsyrcWodashZone() {
        ; Change this if used
        ;return Rects.UmbralCluster.LatsyrcWodashTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Latsyrc Wodash
        ;Button := Points.Areas.UmbralCluster.LatsyrcWodash
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Latsyrc Wodash travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
