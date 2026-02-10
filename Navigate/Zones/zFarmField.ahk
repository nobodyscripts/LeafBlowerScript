#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * FarmField class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class FarmField extends Zone {
    ; The name of the zone for display purposes
    Name := "Farm Field"
    ; The colour of the FarmField pixel for the zone
    ZoneColour := this.GetColourByName("Farm Field")
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
        Local FarmFieldLeaf := this.FindFarmFieldZone()
        If (FarmFieldLeaf) {
            this.ClickTravelButton(FarmFieldLeaf, delay + extradelay)
        } Else {
            Out.I("Farm Field leaf not found while trying to travel.")
        }
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindFarmFieldZone() {
        ; Change this if used
        ;return Rects.Events.FarmFieldTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Farm Field
        ;Button := Points.Areas.Events.FarmField
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Farm Field travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
