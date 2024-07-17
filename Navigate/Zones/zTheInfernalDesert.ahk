#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * TheInfernalDesert class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class TheInfernalDesert extends Zone {
    ; The name of the zone for display purposes
    Name := "The Infernal Desert"
    ; The colour of the sample pixel for the zone
    ZoneColour := this.GetColourByName("The Infernal Desert")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        this.ScrollAmountDown(23, scrolldelay) ; Scroll down for the zones 0xAC816B
        Sleep(delay + extradelay)
        Local DesertLeaf := this.FindDesertZone()
        If (DesertLeaf) {
            this.ClickTravelButton(DesertLeaf, delay + extradelay)
        } Else {
            Log(
                "The Infernal Desert marker leaf not found while trying to travel."
            )
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    FindDesertZone() {
        Return Rects.GemFarm.TravelLeafSearch.PixelSearch("0x4A4429")
    }

    ClickTravelButton(coord, delay) {
        ; Button to travel to The Infernal Desert
        Button := cPoint(coord[1] + Window.RelW(225), coord[2] + Window.RelH(5),
            false)
        DebugLog(Button.GetColour() " " Button.IsButton() " " Button.IsButtonActive()
        )
        ; If no button we are misaligned
        If (Button.IsButton()) {
            ; Set zone to The Infernal Desert (if not already inactive)
            If (Button.IsButtonActive()) {
                Button.Click(delay)
            }
        } Else {
            Log("The Infernal Desert travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}