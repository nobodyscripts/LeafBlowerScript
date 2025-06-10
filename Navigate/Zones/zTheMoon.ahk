#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheMoon class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheMoon extends Zone {
    ; The name of the zone for display purposes
    Name := "The Moon"
    ; The colour of the TheMoon pixel for the zone
    ZoneColour := this.GetColourByName("The Moon")
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
        Local TheMoonLeaf := this.FindTheMoonZone()
        If (TheMoonLeaf) {
            this.ClickTravelButton(TheMoonLeaf, delay + extradelay)
        } Else {
            Out.I("The Moon leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheMoonZone() {
        ; Change this if used
        ;return Rects.LeafG.TheMoonTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Moon
        ;Button := Points.Areas.LeafGalaxy.TheMoon
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("The Moon travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
