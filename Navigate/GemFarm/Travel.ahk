#Requires AutoHotkey v2.0

/**
 * 
 */

FindDesertZone() {
    return Areas.GemFarm.TravelLeafSearch.PixelSearch("0x4A4429")
}

GoToDesert() {
    if (!IsWindowActive()) {
        Log("No window found while trying to travel.")
        return false
    }
    global DisableZoneChecks
    i := 0
    if (!DisableZoneChecks) {
        Log("Traveling to The Infernal Desert")

        ; Advantage of this sample check is script doesn't travel if already
        ; there and can recheck if travels failed
        while (!IsAreaSampleColour("0xAC816B") && !IsBossTimerActive() &&
            i <= 4) {
            if (!IsWindowActive()) {
                Log("No window found while trying to travel.")
                return false
            }
            OpenAreasPanel(true)
            ScrollAmountDown(23) ; Scroll down for the zones 0xAC816B
            Sleep(NavigateTime)
            local DesertLeaf := FindDesertZone()
            if (DesertLeaf) {
                ClickTravelButton(DesertLeaf, NavigateTime)
            } else {
                Log("Desert leaf not found while trying to travel.")
            }
            Sleep(NavigateTime)
            ; Delay to allow the map to change, otherwise we travel twice
            i++
        }
    }
    if (IsAreaSampleColour("0xAC816B")) {
        DebugLog("Travel success to The Infernal Desert.")
        return true
    } else {
        Log("Traveling to The Infernal Desert. Attempt to blind travel with"
            " slowed times.")
        OpenAreasPanel(true, 200)
        ScrollAmountDown(23, 50) ; Scroll down for the zones 0xAC816B
        Sleep(NavigateTime + 200)
        DesertLeaf := FindDesertZone()
        if (DesertLeaf) {
            ClickTravelButton(DesertLeaf, NavigateTime + 200)
        }
        Sleep(NavigateTime + 200)
        if (DisableZoneChecks) {
            ; Checks are disabled so blindly trust we reached zone
            return true
        }
        if (IsAreaSampleColour("0xAC816B")) {
            DebugLog("Blind travel success to The Infernal Desert.")
            return true
        } else {
            Log("Traveling to The Infernal Desert failed, colour found was "
                GetAreaSampleColour())
            return false
        }
    }
}

ClickTravelButton(coord, delay) {
    ; Button to travel to desert
    Button := cPoint(
        coord[1] + WinRelPosLargeW(225),
        coord[2] + WinRelPosLargeH(5), true)
    if (Button.IsButtonActive()) {
        ; Set zone to The Infernal Desert
        Button.Click(delay)
    } else {
        Log("Desert travel: Button not found.")
        ToolTip(" ",
            coord[1] + WinRelPosLargeW(225),
            coord[2] + WinRelPosLargeH(5),
            7)
    }
}