#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheCoalMine class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheCoalMine extends Zone {
    ; The name of the zone for display purposes
    Name := "The Coal Mine"
    ; The colour of the TheCoalMine pixel for the zone
    ZoneColour := this.GetColourByName("The Coal Mine")
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
        ;Points.Areas.FireFields.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local TheCoalMineLeaf := this.FindTheCoalMineZone()
        If (TheCoalMineLeaf) {
            this.ClickTravelButton(TheCoalMineLeaf, delay + extradelay)
        } Else {
            Out.I("The Coal Mine leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheCoalMineZone() {
        ; Change this if used
        ;return Rects.FireF.TheCoalMineTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Coal Mine
        ;Button := Points.Areas.FireFields.TheCoalMine
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("The Coal Mine travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
