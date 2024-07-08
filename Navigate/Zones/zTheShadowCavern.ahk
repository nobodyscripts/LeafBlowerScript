#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * TheShadowCavern class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheShadowCavern extends Zone {
    ; The name of the zone for display purposes
    Name := "The Shadow Cavern"
    ; The colour of the TheShadowCavern pixel for the zone
    ZoneColour := this.GetColourByName("The Shadow Cavern")
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
        ;Points.Areas.FireF.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local TheShadowCavernLeaf := this.FindTheShadowCavernZone()
        If (TheShadowCavernLeaf) {
            this.ClickTravelButton(TheShadowCavernLeaf, delay + extradelay)
        } Else {
            Log("The Shadow Cavern leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheShadowCavernZone() {
        ; Change this if used
        ;return Rects.FireF.TheShadowCavernTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Shadow Cavern
        ;Button := Points.Areas.FireF.TheShadowCavern
        Button := cPoint()
        DebugLog("Zone travel button colour " Button.GetColour() )
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Log("The Shadow Cavern travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}