#Requires AutoHotkey v2.0

#Include ..\..\Lib\Logging.ahk
#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk

/**
 * Sample class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class Sample extends Zone {
    ; The name of the zone for display purposes
    Name := "Sample"
    ; The colour of the sample pixel for the zone
    ZoneColour := this.GetColourByName("Sample")
    ; Require boss timer (or not) to match for success
    BossTimer := false

    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
        Travel.OpenAreas(true, extradelay)
        ;Points.Areas.<Galaxy>.Tab.Click()
        ;Sleep(delay)
        ; Scroll down if needed
        this.ScrollAmountDown(26, scrolldelay) 
        Sleep(delay + extradelay)
        ; Scanning by leaf
        local SampleLeaf := this.FindSampleZone()
        if (SampleLeaf) {
            this.ClickTravelButton(SampleLeaf, delay + extradelay)
        } else {
            Log("Sample leaf not found while trying to travel.")
        }
        Sleep(delay + extradelay)
        ; Delay to allow the map to change, otherwise we travel twice
    }

    FindSampleZone() {
        ; Change this if used
        ;return Rects.<Galaxy>.SampleTravel.PixelSearch("0xFFFFFF")
        return true
    }

    ClickTravelButton(coord, delay) {
        ; Button to travel to Sample
        ;Button := Points.Areas.<Galaxy>.Sample
        Button := cPoint()
        DebugLog(Button.GetColour() " " Button.IsButton() " " Button.IsButtonActive()
        )
        ; If no button we are misaligned
        if (Button.IsButton()) {
            ; Set zone to Sample (if not already inactive)
            if (Button.IsButtonActive()) {
                Button.Click(delay)
            }
        } else {
            Log("Sample travel: Button not found.")
            ;Button.ToolTipAtCoord()
        }
    }
}