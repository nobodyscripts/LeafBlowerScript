#Requires AutoHotkey v2.0

/**
 * Collection of static colours and functions to check if pixels are certain
 * things.
 * @module Colours
 * @property {Map} ZoneColours Collection of sample colours by name of zone
 * @method GetColourByZone
 * @method GetZoneByColour
 */
Class Colours {

    ;@region Button Colours
    /** 0xFFF1D2
     * @type {String} */
    Active := "0xFFF1D2"
    /** 0xFDD28A
     *  @type {String} */
    ActiveMouseOver := "0xFDD28A"
    /** 0xC8BDA5
     * @type {String} */
    Inactive := "0xC8BDA5"
    /** 0x97714A
     * @type {String} */
    Background := "0x97714A"
    /** 0xFFFFFF
     * @type {String} */
    ActiveSelected := ""
    /** 0xFFFFFF
     * @type {String} */
    InactiveSelected := ""

    /** 0xB3A993
     *  @type {String} */
    AfkActive := "0xB3A993"
    /** 0xB29361
     * @type {String} */
    AfkActiveMouseover := "0xB29361"
    /** 0x6A4F34
     * @type {String} */
    BackgroundAFK := "0x6A4F34"
    /** 0x837C6C
     * @type {String} */
    DarkBgActive := "0x837C6C"
    /** 0x826C47
     * @type {String} */
    DarkBgActiveMouseover := "0x826C47"
    /** 0x97714B
     * @type {String} */
    BackgroundSpotify := "0x97714B"
    /** 0x78D063
     * @type {String} */
    BankTabSelectedActive := "0x78D063"
    /** 0xA0EC84
     * @type {String} */
    BankTabSelectedActiveMouseover := "0xA0EC84"
    ;@endregion

    ;@region ZoneColours
    /** Contains zone sample colours
     * @type {Map} */
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
        "Shadow Lighthouse", "0x000028",
        "Industrial Harbor", "0x6A4459")
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
     * @returns {Array[String]|false} Full names of the zone as found in ZoneColours
     */
    GetZoneByColour(colour) {
        list := []
        For (zname, zcolour in this.ZoneColours) {
            If (colour = zcolour) {
                list.Push(zname)
            }
        }
        If (list = []) {
            Out.I("GetZoneByColour could not find zone: " colour)
            Return false
        }
        Else {
            Return list
        }
    }
    ;@endregion

}

/** Colour instance
 * @type {Colours}
 */
c := Colours()