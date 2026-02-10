#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * BlackLeafHole class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class BlackLeafHole extends Zone {
    ; The name of the zone for display purposes
    Name := "Black Leaf Hole"
    ; The colour of the BlackLeafHole pixel for the zone
    ZoneColour := this.GetColourByName("Black Leaf Hole")
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
        ;Points.Areas.LeafGalaxy.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local BlackLeafHoleLeaf := this.FindBlackLeafHoleZone()
        If (BlackLeafHoleLeaf) {
            this.ClickTravelButton(BlackLeafHoleLeaf, delay + extradelay)
        } Else {
            Out.I("Black Leaf Hole leaf not found while trying to travel.")
        }
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindBlackLeafHoleZone() {
        ; Change this if used
        ;return Rects.LeafG.BlackLeafHoleTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Black Leaf Hole
        ;Button := Points.Areas.LeafGalaxy.BlackLeafHole
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Black Leaf Hole travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
