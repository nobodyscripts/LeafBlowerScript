#Requires AutoHotkey v2.0

#Include ..\..\Lib\cColours.ahk

For zonename, v in Colours().ZoneColours {
    classname := StrReplace(zonename, " ")
    classname := StrReplace(classname, "'")
    If (classname && !FileExist(A_ScriptDir "\" classname ".ahk")) {
        ; Append include to header
        FileAppend("`n#include z" classname ".ahk", A_ScriptDir "\Header.ahk")

        ; Read sample file
        classcontents := FileRead(A_ScriptDir "\Sample.ahk")

        ;@region galaxy replace
        ; Replace Sample with name of class
        classcontents := StrReplace(classcontents, "Sample", classname)
        classcontents := StrReplace(classcontents, "FullName", zonename)
        Switch (zonename) {
        Case "Home Garden":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Neighbors' Garden":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Mountain":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Space":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "THE VOID":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Abyss":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Celestial Plane":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Mythical Garden":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Volcano":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Abandoned Research Station":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Hidden Sea":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Leafsink Harbor":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Leaf Tower":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Moon":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Infernal Desert":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Cursed Pyramid":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Inner Cursed Pyramid":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Kokkaupunki":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Cursed Kokkaupunki":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Dark Glade":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Black Leaf Hole":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Dicey Meadows":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Glinting Thicket":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "The Cheese Pub":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Your House":
            classcontents := StrReplace(classcontents, "<Galaxy>", "LeafGalaxy")
        Case "Biotite Forest":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "The Exalted Bridge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "The Ancient Sanctum":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "Vilewood Cemetery":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "The Lone Tree":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "Spark Range":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "Spark Bubble":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "Spark Portal":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "SacredNebula")
        Case "Energy Shrine":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Plasma Forest":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Blue Planet Edge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Green Planet Edge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Red Planet Edge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Purple Planet Edge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Black Planet Edge":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Terror Graveyard":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Energy Singularity":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "Fire Fields Portal":
            classcontents := StrReplace(classcontents, "<Galaxy>",
                "EnergyBelt")
        Case "The Shadow Cavern":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "The Coal Mine":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "Mount Moltenfury":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "The Fire Temple":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "Flame Brazier":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "Fire Universe":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "Soul Portal":
            classcontents := StrReplace(classcontents, "<Galaxy>", "FireFields")
        Case "Soul Temple":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "Soul Crypt":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "The Hollow":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "Soul Forge":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "Quark Portal":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "The Fabric of the Leafverse":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "Primordial Ethos":
            classcontents := StrReplace(classcontents, "<Galaxy>", "SoulRealm")
        Case "Quark Nexus":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Quantum Aether":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Astral Oasis":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Dimensional Tapestry":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Planck Scope":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Ante Leafton":
            classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkAmbit"
            )
        Case "Shadow Crystal":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Tenebris Field":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Blacklight Verge":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Sombrynth":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Latsyrc Wodash":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Shadow Lighthouse":
            classcontents := StrReplace(classcontents, "<Galaxy>", "UmbralCluster"
            )
        Case "Cursed Halloween":
            classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
            )
        Case "Farm Field":
            classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
            )
        Case "Butterfly Field":
            classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
            )
        Case "Vial of Life":
            classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
            )
        Case "The Doomed Tree":
            classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
            )
        default:
            Throw Error("Zone attempted to add but wasn't in list " zonename
            )
        }
        ;@endregion
        ; Copy modified sample to new file
        FileAppend(classcontents, A_ScriptDir "\z" classname ".ahk")

        ; Add new class to travel class
        If (FileExist(A_ScriptDir "\..\..\Lib\cTravel.ahk")) {
            ; Read travel class
            travelcontents := FileRead(A_ScriptDir "\..\..\Lib\cTravel.ahk")
            ; Replace classmarker with new class define
            travelcontents := StrReplace(travelcontents, "/* <classmarker> */",
                "`r`n    /**`r`n" . "     * Travel class for " classname "`r`n" .
                "     * @type {" classname "}`r`n" . "     */`r`n" . "    " classname " := " classname "()`r`n`r`n" .
                "    /* <classmarker> */")

            travelcontents := StrReplace(travelcontents, " * <jsdocmarker>",
                " * @property {" classname "} " classname " Travel class for " zonename "`r`n" .
                " * <jsdocmarker>")
            ; Copy modified sample to new file
            FileDelete(A_ScriptDir "\..\..\Lib\cTravel.ahk")
            FileAppend(travelcontents, A_ScriptDir "\..\..\Lib\cTravel.ahk")
        }
    }
}
