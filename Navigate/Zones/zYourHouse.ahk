#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * YourHouse class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class YourHouse extends Zone {
    ; The name of the zone for display purposes
    Name := "Your House"
    ; The colour of the YourHouse pixel for the zone
    ZoneColour := this.GetColourByName("Your House")
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
        Local YourHouseLeaf := this.FindYourHouseZone()
        If (YourHouseLeaf) {
            this.ClickTravelButton(YourHouseLeaf, delay + extradelay)
        } Else {
            Out.I("Your House leaf not found while trying to travel.")
        }
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindYourHouseZone() {
        ; Change this if used
        ;return Rects.LeafG.YourHouseTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Your House
        ;Button := Points.Areas.LeafGalaxy.YourHouse
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Your House travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
