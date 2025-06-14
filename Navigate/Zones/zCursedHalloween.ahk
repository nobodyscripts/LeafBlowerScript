#Requires AutoHotkey v2.0

#Include ..\..\Lib\cZone.ahk
#Include ..\..\Lib\cTravel.ahk
#include ..\..\ScriptLib\cToolTip.ahk

/**
 * CursedHalloween class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class CursedHalloween extends Zone {
    ; The name of the zone for display purposes
    Name := "Cursed Halloween"
    ; The colour of the sample pixel for the zone
    ZoneColour := this.GetColourByName("Cursed Halloween")
    ; Require boss timer (or not) to match for success
    BossTimer := true

    Goto() {
        If (!this.IsHalloweenEventActive()) {
            Out.I("Claw: Halloween inactive.")
            gToolTip.CenterMS("Halloween inactive`nPlease use the artifact to enable"
                " halloween event", 5000)
            Return false
        }
        this.ResetAreaScroll() ; Reset incase
        Sleep(150)
        this.ScrollAmountDown(46) ; Scroll down
        Sleep(150)
        ; Pub button check
        If (Points.Areas.LeafGalaxy.Pub.IsBackground()) {
            Out.I("Claw: Could not travel to pub.")
            gToolTip.CenterMS("Pub area button didn't align, try again", 5000)
            Return false
        }
        ; Open pub area
        Points.Areas.LeafGalaxy.Pub.Click(101)
        Sleep(250)

        ; Close the area screen
        Points.Claw.CloseArea.Click(101)
        Sleep(250)

        ; Open claw machine
        Points.Claw.OpenClaw.Click(101)
        Sleep(250)
        Return true
    }

    IsHalloweenEventActive() {
        Travel.OpenAreasEvents()
        If (Points.Areas.Events.CursedHalloween.IsBackground()) {
            Return false
        }
        Return true
    }
}
