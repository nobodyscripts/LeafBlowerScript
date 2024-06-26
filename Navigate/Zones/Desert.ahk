#Requires AutoHotkey v2.0

/**
 * Desert class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class Desert extends Zone {
    ; The name of the zone for display purposes
    Name := "The Infernal Desert"
    ; The colour of the sample pixel for the zone
    ZoneColour := this.GetColourByName("The Infernal Desert")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        ScrollAmountDown(23, scrolldelay) ; Scroll down for the zones 0xAC816B
        Sleep(delay + extradelay)
        local DesertLeaf := this.FindDesertZone()
        if (DesertLeaf) {
            this.ClickTravelButton(DesertLeaf, delay + extradelay)
        } else {
            Log("Desert leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    FindDesertZone() {
        return Rects.GemFarm.TravelLeafSearch.PixelSearch("0x4A4429")
    }

    ClickTravelButton(coord, delay) {
        ; Button to travel to desert
        Button := cPoint(
            coord[1] + WinRelPosLargeW(225),
            coord[2] + WinRelPosLargeH(5), false)
        DebugLog(Button.GetColour() " " Button.IsButton() " " Button.IsButtonActive())
        ; If no button we are misaligned
        if (Button.IsButton()) {
            ; Set zone to The Infernal Desert (if not already inactive)
            if (Button.IsButtonActive()) {
                Button.Click(delay)
            }
        } else {
            Log("Desert travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}