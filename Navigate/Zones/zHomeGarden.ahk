#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#Include ..\..\Lib\cPoint.ahk

/**
 * HomeGarden class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class HomeGarden extends Zone {
    ; The name of the zone for display purposes
    Name := "Home Garden"
    ; The colour of the HomeGarden pixel for the zone
    ZoneColour := this.GetColourByName("Home Garden")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Logic for a single travel attempt
     * @param delay Normal NavigateTime 
     * @param {Integer} [scrolldelay=0] Additional delay to NavigateTime
     * @param {Integer} [extradelay=0] Additional delay to NavigateTime
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Out.I("Traveling to Home Garden")
        Travel.OpenAreas(true, extradelay)
        Points.Areas.LeafG.HomeGarden.Click(NavigateTime)
        Sleep(delay + extradelay)
    }

    IsAreaGarden() {
        If (!Rects.Areas.GardenReset.PixelSearch("0x4A9754")) {
            Return false
        }
        Return true
    }
}