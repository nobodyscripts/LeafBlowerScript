#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * GlintingThicket class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class GlintingThicket extends Zone {
    ; The name of the zone for display purposes
    Name := "Glinting Thicket"
    ; The colour of the GlintingThicket pixel for the zone
    ZoneColour := this.GetColourByName("Glinting Thicket")
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
        Local GlintingThicketLeaf := this.FindGlintingThicketZone()
        If (GlintingThicketLeaf) {
            this.ClickTravelButton(GlintingThicketLeaf, delay + extradelay)
        } Else {
            Out.I("Glinting Thicket leaf not found while trying to travel.")
        }
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindGlintingThicketZone() {
        ; Change this if used
        ;return Rects.LeafG.GlintingThicketTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to Glinting Thicket
        ;Button := Points.Areas.LeafGalaxy.GlintingThicket
        Button := cLBRButton()
        Out.D("Zone travel button colour " Button.GetColour())
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, S.Get("NavigateTime") + delay)) {
            Out.I("Glinting Thicket travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}
