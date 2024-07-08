#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * TheCheesePub class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheCheesePub extends Zone {
    ; The name of the zone for display purposes
    Name := "The Cheese Pub"
    ; The colour of the TheCheesePub pixel for the zone
    ZoneColour := this.GetColourByName("The Cheese Pub")
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
        ;Points.Areas.LeafG.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay)
        Sleep(delay + extradelay)
        ; Scanning by leaf
        Local TheCheesePubLeaf := this.FindTheCheesePubZone()
        If (TheCheesePubLeaf) {
            this.ClickTravelButton(TheCheesePubLeaf, delay + extradelay)
        } Else {
            Log("The Cheese Pub leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    /**
     * Checks if leaf colour is found in an area (If this is needed)
     * @returns {Boolean} 
     */
    FindTheCheesePubZone() {
        ; Change this if used
        ;return Rects.LeafG.TheCheesePubTravel.PixelSearch("0xFFFFFF")
        Return true
    }

    /**
     * Checks and clicks button in area panel
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
        ; Button to travel to The Cheese Pub
        ;Button := Points.Areas.LeafG.TheCheesePub
        Button := cPoint()
        DebugLog("Zone travel button colour " Button.GetColour() )
        ; If no button we are misaligned
        If (!Button.ClickButtonActive(, , delay, NavigateTime + delay)) {
            Log("The Cheese Pub travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}