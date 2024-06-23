#Requires AutoHotkey v2.0

#Include ..\Navigate\Header.ahk
#Include SettingsCheck.ahk

/**
 * Base zone travel object
 * @property {String} Name The name of the zone for display purposes
 * @property {String} AreaColour The colour of the sample pixel for the zone
 * @property {Bool} BossTimer Require boss timer (or not) to match for success
 */
Class Zone {
    ; The name of the zone for display purposes
    Name := ""
    ; The colour of the sample pixel for the zone
    ZoneColour := ""
    ; Require boss timer (or not) to match for success
    BossTimer := false

    /**
     * Go to the zone base function, uses other functions in class to modifiy
     * target zone (don't use base Zone class directly)
     * @returns {Bool} 
     */
    GoTo() {
        if (!IsWindowActive()) {
            Log("No window found while trying to travel.")
            return false
        }
        global DisableZoneChecks
        i := 0
        if (!DisableZoneChecks) {
            Log("Traveling to " this.Name)
            ; Advantage of this sample check is script doesn't travel if already
            ; there and can recheck if travels failed
            while (!this.IsZoneColour() &&
                this.BossTimer = !IsBossTimerActive() &&
                i <= 4) {
                if (!IsWindowActive()) {
                    Log("No window found while trying to travel.")
                    return false
                }
                this.AttemptTravel(NavigateTime)
                i++
            }
        }
        if (this.IsZoneColour()) {
            DebugLog("Travel success to " this.Name)
            return true
        } else {
            Log("Traveling to " this.Name ". Attempt to blind travel with"
                " slowed times.")
            this.AttemptTravel(NavigateTime, 50, 200)
            if (DisableZoneChecks) {
                ; Checks are disabled so blindly trust we reached zone
                return true
            }
            if (this.IsZoneColour()) {
                DebugLog("Blind travel success to " this.Name)
                return true
            } else {
                Log("Traveling to " this.Name " failed, colour found was "
                    this.GetZoneColour())
                return false
            }
        }
    }

    /**
     * Blank function contains the code in extend to attempt one pass at travel
     * @param delay 
     * @param {Integer} scrolldelay 
     * @param {Integer} extradelay 
     */
    AttemptTravel(delay, scrolldelay := 0, extradelay := 0) {
    }

    /**
     * Used in AttemptTravel to handle the button checks and press with delays
     * @param coord 
     * @param delay 
     */
    ClickTravelButton(coord, delay) {
    }

    /**
     * Checks if zone is currently set to the zone required based on 
     * this.AreaColour
     * @returns {Integer} 
     */
    IsZoneColour() {
        sampleColour := this.GetZoneColour()
        If (sampleColour = this.ZoneColour) {
            ; Found target colour
            return true
        }
        DebugLog("IsZoneColour: Not in target zone, colour: " sampleColour)
        return false
    }

    /**
     * Get current zone colour sample to know what zone player is currently in
     * @returns {String} 
     */
    GetZoneColour() {
        return Points.ZoneSample.GetColour()
    }

    /**
     * Gets the colour the game needs to return to confirm current zone
     * @param name Full name string of zone found in ZoneColours
     * @returns {String} Colour string for zone check
     */
    GetColourByName(name) {
        return ZoneColours[name]
    }



    /**
     * Resets the scroll position on areas panel by swapping tabs
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    ResetAreaScroll(extraDelay := 0) {
        NavTime := NavigateTime + extraDelay
        if (NavigateTime < 72) {
            NavTime := 72 + extraDelay
        }
        ; Click Favourites
        Points.Areas.Favs.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)

        ; Click Back to default page to reset the scroll
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)

        ; Double click for redundancy
        Points.Areas.LeafG.Tab.ClickOffset(, , NavTime)
        Sleep(NavTime)
    }

    /**
     * Scroll downwards in a panel by ticks
     * @param {number} amount (optional): default 1, amount to scroll in ticks
     * of mousewheel
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    ScrollAmountDown(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelDown")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }

    /**
     * Scroll upwards in a panel by ticks
     * @param {number} amount (optional): default 1, amount to scroll in ticks
     * of mousewheel
     * @param {number} extraDelay (optional): add ms to the sleep timers
     */
    ScrollAmountUp(amount := 1, extraDelay := 0) {
        while (amount > 0) {
            if (!IsWindowActive() || !IsPanelActive()) {
                break
            } Else {
                ControlClick(, LBRWindowTitle, , "WheelUp")
                Sleep(NavigateTime + extraDelay)
                amount--
            }
        }
    }
}

ZoneColours := Map()

ZoneColours["Home Garden"] := "0x4A9754" ; (non unique)
ZoneColours["Neighbors' Garden"] := "0x3B8D43"
ZoneColours["Mountain"] := "0xA2C6CB"
ZoneColours["Space"] := "0x000004"
ZoneColours["THE VOID"] := "0x231A29"
ZoneColours["The Abyss"] := "0x232222"
ZoneColours["The Celestial Plane"] := "0x7BB4D4"
ZoneColours["The Mythical Garden"] := "0x384832"
ZoneColours["The Volcano"] := "0x292524"
ZoneColours["The Abandoned Research Station"] := "0xAEBCCC"
ZoneColours["The Hidden Sea"] := "0x002C5A"
ZoneColours["Leafsink Harbor"] := "0x283C5D"
ZoneColours["The Leaf Tower"] := "0x11151F"
ZoneColours["The Moon"] := "0x161720"
ZoneColours["The Infernal Desert"] := "0xAC816B" ; (non unique)
ZoneColours["The Cursed Pyramid"] := "0xAC816B" ; (non unique)
ZoneColours["The Inner Cursed Pyramid"] := "0x191516"
ZoneColours["Kokkaupunki"] := "0x001031"
ZoneColours["Cursed Kokkaupunki"] := "0x000000" ; (non unique)
ZoneColours["The Dark Glade"] := "0x000000" ; (non unique)
ZoneColours["Black Leaf Hole"] := "0x325211"
ZoneColours["Dicey Meadows"] := "0x121619"
ZoneColours["Glinting Thicket"] := "0x161419"
ZoneColours["The Cheese Pub"] := "0x492604"
ZoneColours["Your House"] := "0x20170D"
ZoneColours["Biotite Forest"] := "0x0C1911"
ZoneColours["The Exalted Bridge"] := "0x000000" ; (non unique)
ZoneColours["The Ancient Sanctum"] := "0x257078"
ZoneColours["Vilewood Cemetery"] := "0x0F1D1F"
ZoneColours["The Lone Tree"] := "0x8C7B61"
ZoneColours["Spark Range"] := "0x030607"
ZoneColours["Spark Bubble"] := "0x201532"
ZoneColours["Spark Portal"] := "0x09010D"
ZoneColours["Energy Shrine"] := "0x021721"
ZoneColours["Plasma Forest"] := "0x151A32"
ZoneColours["Blue Planet Edge"] := "0x02060D"
ZoneColours["Green Planet Edge"] := "0x000300"
ZoneColours["Red Planet Edge"] := "0x020000"
ZoneColours["Purple Planet Edge"] := "0x010007"
ZoneColours["Black Planet Edge"] := "0x000000" ; (non unique)
ZoneColours["Terror Graveyard"] := "0x20191B"
ZoneColours["Energy Singularity"] := "0x1A1A31"
ZoneColours["Fire Fields Portal"] := "0x1F1509"
ZoneColours["The Shadow Cavern"] := "0x260000"
ZoneColours["Mount Moltenfurty"] := "0x841E11"
ZoneColours["The Fire Temple"] := "0x291F31"
ZoneColours["Flame Brazier"] := "0x121328"
ZoneColours["Fire Universe"] := "0x17190F"
ZoneColours["Soul Portal"] := "0x05050B"
ZoneColours["Soul Temple"] := "0x030706"
ZoneColours["Soul Crypt"] := "0x1C1C31"
ZoneColours["The Hollow"] := "0x170F24"
ZoneColours["Soul Forge"] := "0x02030D"
ZoneColours["The Fabric of the Leafverse"] := "0x110B1B"
ZoneColours["Quark Portal"] := "0x000000" ; (non unique)
ZoneColours["Quark Nexus"] := "0x00000A"
ZoneColours["Quantum Aether"] := "0x131119"
ZoneColours["Astral Oasis"] := "0x000108"
ZoneColours["Dimensional Tapestry"] := "0x37356B"
ZoneColours["Planck Scope"] := "0x0B1E32"
ZoneColours["Cursed Halloween"] := "0x150412"
ZoneColours["Farm Field"] := "0x4A9754" ; (non unique)
ZoneColours["Butterfly Field"] := "0x4A9754" ; (non unique)
ZoneColours["Vial of Life"] := "0x4A9754" ; (non unique)
ZoneColours["The Doomed Tree"] := "0x090B10"