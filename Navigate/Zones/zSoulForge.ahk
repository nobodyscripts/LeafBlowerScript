#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * SoulForge class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class SoulForge extends Zone {
    ; The name of the zone for display purposes
    Name := "Soul Forge"
    ; The colour of the SoulForge pixel for the zone
    ZoneColour := this.GetColourByName("Soul Forge")
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
        ;Points.Areas.SoulR.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local SoulForgeLeaf := this.FindSoulForgeZone()
        If (SoulForgeLeaf) {
            this.ClickTravelButton(SoulForgeLeaf, delay + extradelay)
        } Else {
            Log("Soul Forge leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindSoulForgeZone() {
        ; Change this if used
        ;return Rects.SoulR.SoulForgeTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Soul Forge
        ;Button := Points.Areas.SoulR.SoulForge
        Button := cPoint()
        DebugLog("Zone travel button colour " Button.GetColour() )
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Log("Soul Forge travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}