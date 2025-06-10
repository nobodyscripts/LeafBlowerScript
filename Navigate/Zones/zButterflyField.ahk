#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * ButterflyField class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class ButterflyField extends Zone {
    ; The name of the zone for display purposes
    Name := "Butterfly Field"
    ; The colour of the ButterflyField pixel for the zone
    ZoneColour := this.GetColourByName("Butterfly Field")
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
        ;Points.Areas.Events.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local ButterflyFieldLeaf := this.FindButterflyFieldZone()
        If (ButterflyFieldLeaf) {
            this.ClickTravelButton(ButterflyFieldLeaf, delay + extradelay)
        } Else {
            Out.I("Butterfly Field leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindButterflyFieldZone() {
        ; Change this if used
        ;return Rects.Events.ButterflyFieldTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Butterfly Field
        ;Button := Points.Areas.Events.ButterflyField
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Butterfly Field travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
