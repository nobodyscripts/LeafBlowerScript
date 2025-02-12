#Requires AutoHotkey v2.0

/**
 * Collection of static colours and functions to check if pixels are certain
 * things.
 * @property {String} Active Active button colour (excluding text)
 * @property {String} ActiveMouseOver Active button colour when mouse over
 * @property {String} AfkActive Active button colour when afk on
 * @property {String} AfkActiveMouseover Active button colour when afk and 
 * mouseover
 * @property {String} DarkBgActive Active button colour when dark background on
 * @property {String} DarkBgActiveMouseover Active button colour when dark
 * background on and mouseover
 * @property {String} Inactive Inactive button colour
 * @property {String} Background Background window main colour
 * @property {String} BackgroundSpotify Background window colour when spotify
 * desktop is running
 * @property {String} BackgroundAFK Background window colour when afk on
 * @property {Map} ZoneColours Collection of sample colours by name of zone
 * @method IsButton 
 * @method IsMouseOver
 * @method IsButtonActive
 * @method IsButtonAFK
 * @method IsCoveredByNotification
 * @method IsButtonOffPanel
 * @method IsButtonDarkened
 * @method IsBackground
 * @method GetColourByZone
 * @method GetZoneByColour
 */
Class Colours {
    ;@region Properties
    /** @type {String} 0xFFF1D2 */
    Active := "0xFFF1D2"
    /** @type {String} 0xFDD28A */
    ActiveMouseOver := "0xFDD28A"
    /** @type {String} 0xB3A993 */
    AfkActive := "0xB3A993"
    /** @type {String} 0xB29361 */
    AfkActiveMouseover := "0xB29361"
    /** @type {String} 0x837C6C */
    DarkBgActive := "0x837C6C"
    /** @type {String} 0x826C47 */
    DarkBgActiveMouseover := "0x826C47"
    /** @type {String} 0xC8BDA5 */
    Inactive := "0xC8BDA5"
    /** @type {String} 0x97714A */
    Background := "0x97714A"
    /** @type {String} 0x97714B */
    BackgroundSpotify := "0x97714B"
    /** @type {String} 0x6A4F34 */
    BackgroundAFK := "0x6A4F34"

    ;@region ZoneColours
    /** @type {Map} Contains zone sample colours */
    ZoneColours := Map("Home Garden", "0x4A9754", ; (non unique)
        "Neighbors' Garden", "0x3B8D43", ; Blank comments for formatting
        "Mountain", "0xA2C6CB", ;
        "Space", "0x000004", ;
        "THE VOID", "0x231A29", ;
        "The Abyss", "0x232222", ;
        "The Celestial Plane", "0x7BB4D4", ;
        "The Mythical Garden", "0x384832", ;
        "The Volcano", "0x292524", ;
        "The Abandoned Research Station", "0xAEBCCC", ;
        "The Hidden Sea", "0x002C5A", ;
        "Leafsink Harbor", "0x283C5D", ;
        "The Leaf Tower", "0x11151F", ;
        "The Moon", "0x161720", ;
        "The Infernal Desert", "0xAC816B", ; (non unique)
        "The Cursed Pyramid", "0xAC816B", ; (non unique)
        "The Inner Cursed Pyramid", "0x191516", ;
        "Kokkaupunki", "0x001031", ;
        "Cursed Kokkaupunki", "0x000000", ; (non unique)
        "The Dark Glade", "0x000000", ; (non unique)
        "Black Leaf Hole", "0x325211", ;
        "Dicey Meadows", "0x121619", ;
        "Glinting Thicket", "0x161419", ;
        "The Cheese Pub", "0x492604", ;
        "Your House", "0x20170D", ;
        "Biotite Forest", "0x0C1911", ;
        "The Exalted Bridge", "0x000000", ; (non unique)
        "The Ancient Sanctum", "0x257078", ;
        "Vilewood Cemetery", "0x0F1D1F", ;
        "The Lone Tree", "0x8C7B61", ;
        "Spark Range", "0x030607", ;
        "Spark Bubble", "0x201532", ;
        "Spark Portal", "0x09010D", ;
        "Energy Shrine", "0x021721", ;
        "Plasma Forest", "0x151A32", ;
        "Blue Planet Edge", "0x02060D", ;
        "Green Planet Edge", "0x000300", ;
        "Red Planet Edge", "0x020000", ;
        "Purple Planet Edge", "0x010007", ;
        "Black Planet Edge", "0x000000", ; (non unique)
        "Terror Graveyard", "0x20191B", ;
        "Energy Singularity", "0x1A1A31", ;
        "Fire Fields Portal", "0x1F1509", ;
        "The Shadow Cavern", "0x260000", ;
        "Moltenfury", "0x841E11", ;
        "The Coal Mine", "0x06000C", ;
        "Mount Moltenfury", "0x841E11", ;
        "The Fire Temple", "0x291F31", ;
        "Flame Brazier", "0x121328", ;
        "Fire Universe", "0x17190F", ;
        "Soul Portal", "0x05050B", ;
        "Soul Temple", "0x030706", ;
        "Soul Crypt", "0x1C1C31", ;
        "The Hollow", "0x170F24", ;
        "Soul Forge", "0x02030D", ;
        "Quark Portal", "0x000000", ; (non unique)
        "The Fabric of the Leafverse", "0x110B1B", ;
        "Primordial Ethos", "0x000003", ;
        "Quark Nexus", "0x00000A", ;
        "Quantum Aether", "0x131119", ;
        "Astral Oasis", "0x000108", ;
        "Dimensional Tapestry", "0x37356B", ;
        "Planck Scope", "0x0B1E32", ;
        "Cursed Halloween", "0x150412", ;
        "Farm Field", "0x4A9754", ; (non unique)
        "Butterfly Field", "0x4A9754", ; (non unique)
        "Vial of Life", "0x4A9754", ; (non unique)
        "The Doomed Tree", "0x090B10", ;
        "Ante Leafton", "0x000000", ; (non unique)
        "The Leafton Pit", "0x000000", ; (non unique)
        "Shadow Crystal", "0x010911", ;
        "Tenebris Field", "0x181818", ;
        "Blacklight Verge", "0x000000", ; (non unique)
        "Sombrynth", "0x000000", ; (non unique)
        "Latsyrc Wodash", "0x000009",
        "Shadow Lighthouse", "0x000028")
    ;@endregion
    ;@endregion

    ;@region Button methods
    ;@region IsButton()
    /**
     * Is the provided colour a LBR button
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButton(colour) {
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsMouseOver()
    /**
     * Is the provided colour a LBR button in mouseover state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsMouseOver(colour) {
        If (colour = this.ActiveMouseOver || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonActive()
    /**
     * Is the provided colour a LBR button in active state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonActive(colour) {
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonAFK()
    /**
     * Is the provided colour a LBR button in active state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonAFK(colour) {
        If (colour = this.AfkActive || colour = this.AfkActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonInactive()
    /**
     * Is the provided colour a LBR button in inactive state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonInactive(colour) {
        If (colour = this.Inactive) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsCoveredByNotification()
    /**
     * Is the provided colour NOT an LBR button or background
     * @param colour 
     * @returns {Integer} true/false
     */
    IsCoveredByNotification(colour) {
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive || colour = this.Background || colour = this.BackgroundSpotify
        ) {
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region IsButtonOffPanel()
    /**
     * Is the provided colour a LBR button off the panels
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonOffPanel(colour) {
        If (colour = this.Active || colour = this.ActiveMouseOver || colour =
            this.AfkActive || colour = this.AfkActiveMouseover || colour = this
            .Inactive || colour = this.DarkBgActive || colour = this.DarkBgActiveMouseover
        ) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region IsButtonDarkened()
    /**
     * Is the provided colour an LBR button off the panels thats darkened
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonDarkened(colour) {
        If (colour = this.DarkBgActive || colour = this.DarkBgActiveMouseover) {
            Return true
        }
        Return false
    }
    ;@endregion
    ;@endregion

    ;@region IsBackground()
    /**
     * Is the provided colour the LBR background panel colour
     * @param colour 
     * @returns {Integer} true/false
     */
    IsBackground(colour) {
        If (colour = this.Background || colour = this.BackgroundSpotify) {
            Return true
        }
        Return false
    }
    ;@endregion

    ;@region GetColourByZone()
    /**
     * Gets the colour the game needs to return to confirm current zone
     * @param name Full name of zone found in ZoneColours
     * @returns {String} Colour string for zone check
     */
    GetColourByZone(name) {
        If (this.ZoneColours.Has(name)) {
            Return this.ZoneColours[name]
        }
        Out.I("GetColourByZone could not find zone: " name)
    }
    ;@endregion

    ;@region GetZoneByColour()
    /**
     * Gets the name of the zone based on colour sample
     * @param colour Colour code as found in ZoneColours
     * @returns {String} Full name of the zone as found in ZoneColours
     */
    GetZoneByColour(colour) {
        For (zname, zcolour in this.ZoneColours) {
            If (colour = zcolour) {
                Return zname
            }
        }
        Return false
    }
    ;@endregion
}
