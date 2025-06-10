#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * FireFieldsPortal class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class FireFieldsPortal extends Zone {
    ; The name of the zone for display purposes
    Name := "Fire Fields Portal"
    ; The colour of the FireFieldsPortal pixel for the zone
    ZoneColour := this.GetColourByName("Fire Fields Portal")
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
        ;Points.Areas.EnergyBelt.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local FireFieldsPortalLeaf := this.FindFireFieldsPortalZone()
        If (FireFieldsPortalLeaf) {
            this.ClickTravelButton(FireFieldsPortalLeaf, delay + extradelay)
        } Else {
            Out.I("Fire Fields Portal leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindFireFieldsPortalZone() {
        ; Change this if used
        ;return Rects.EnergyB.FireFieldsPortalTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Fire Fields Portal
        ;Button := Points.Areas.EnergyBelt.FireFieldsPortal
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Fire Fields Portal travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
