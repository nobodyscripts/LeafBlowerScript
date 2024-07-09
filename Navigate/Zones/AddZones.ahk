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
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Neighbors' Garden":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Mountain":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Space":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "THE VOID":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Abyss":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Celestial Plane":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Mythical Garden":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Volcano":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Abandoned Research Station":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Hidden Sea":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Leafsink Harbor":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Leaf Tower":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Moon":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Infernal Desert":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Cursed Pyramid":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Inner Cursed Pyramid":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Kokkaupunki":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Cursed Kokkaupunki":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Dark Glade":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Black Leaf Hole":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Dicey Meadows":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Glinting Thicket":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "The Cheese Pub":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Your House":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            Case "Biotite Forest":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "The Exalted Bridge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "The Ancient Sanctum":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "Vilewood Cemetery":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "The Lone Tree":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "Spark Range":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "Spark Bubble":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "Spark Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            Case "Energy Shrine":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Plasma Forest":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Blue Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Green Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Red Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Purple Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Black Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Terror Graveyard":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Energy Singularity":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "Fire Fields Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            Case "The Shadow Cavern":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "The Coal Mine":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "Mount Moltenfurty":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "The Fire Temple":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "Flame Brazier":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "Fire Universe":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "Soul Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            Case "Soul Temple":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "Soul Crypt":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "The Hollow":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "Soul Forge":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "Quark Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "The Fabric of the Leafverse":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "Primordial Ethos":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            Case "Quark Nexus":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            Case "Quantum Aether":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            Case "Astral Oasis":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            Case "Dimensional Tapestry":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            Case "Planck Scope":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
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