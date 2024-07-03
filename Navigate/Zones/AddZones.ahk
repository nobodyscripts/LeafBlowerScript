#Requires AutoHotkey v2.0

#Include ..\..\Lib\cColours.ahk

for zonename, v in Colours().ZoneColours {
    classname := StrReplace(zonename, " ")
    if (classname && !FileExist(A_ScriptDir "\" classname ".ahk")) {
        ; Append include to header
        FileAppend("`n#include " classname ".ahk", A_ScriptDir "\Header.ahk")

        ; Read sample file
        classcontents := FileRead(A_ScriptDir "\Sample.ahk")

        ; Replace Sample with name of class
        classcontents := StrReplace(classcontents, "Sample", classname)
        switch (zonename) {
            case "Home Garden":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Neighbors' Garden":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Mountain":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Space":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "THE VOID":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Abyss":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Celestial Plane":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Mythical Garden":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Volcano":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Abandoned Research Station":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Hidden Sea":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Leafsink Harbor":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Leaf Tower":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Moon":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Infernal Desert":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Cursed Pyramid":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Inner Cursed Pyramid":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Kokkaupunki":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Cursed Kokkaupunki":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Dark Glade":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Black Leaf Hole":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Dicey Meadows":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Glinting Thicket":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "The Cheese Pub":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Your House":
                classcontents := StrReplace(classcontents, "<Galaxy>", "LeafG")
            case "Biotite Forest":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "The Exalted Bridge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "The Ancient Sanctum":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "Vilewood Cemetery":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "The Lone Tree":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "Spark Range":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "Spark Bubble":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "Spark Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "SacredN")
            case "Energy Shrine":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Plasma Forest":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Blue Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Green Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Red Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Purple Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Black Planet Edge":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Terror Graveyard":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Energy Singularity":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "Fire Fields Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>",
                    "EnergyB")
            case "The Shadow Cavern":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "The Coal Mine":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "Mount Moltenfurty":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "The Fire Temple":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "Flame Brazier":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "Fire Universe":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "Soul Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>", "FireF")
            case "Soul Temple":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "Soul Crypt":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "The Hollow":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "Soul Forge":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "Quark Portal":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "The Fabric of the Leafverse":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "Primordial Ethos":
                classcontents := StrReplace(classcontents, "<Galaxy>", "SoulR")
            case "Quark Nexus":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            case "Quantum Aether":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            case "Astral Oasis":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            case "Dimensional Tapestry":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            case "Planck Scope":
                classcontents := StrReplace(classcontents, "<Galaxy>", "QuarkA"
                )
            case "Cursed Halloween":
                classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
                )
            case "Farm Field":
                classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
                )
            case "Butterfly Field":
                classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
                )
            case "Vial of Life":
                classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
                )
            case "The Doomed Tree":
                classcontents := StrReplace(classcontents, "<Galaxy>", "Events"
                )
            default:
                Throw Error("Zone attempted to add but wasn't in list " zonename
                )
        }
        ; Copy modified sample to new file
        FileAppend(classcontents, A_ScriptDir "\" classname ".ahk")

        ; Add new class to travel class
        if (FileExist(A_ScriptDir "\..\..\Lib\cTravel.ahk")) {
            ; Read travel class
            travelcontents := FileRead(A_ScriptDir "\..\..\Lib\cTravel.ahk")
            ; Replace classmarker with new class define
            travelcontents := StrReplace(travelcontents, "`n    \; <classmarker>", 
            "`n" . 
            "    /**`n" .
            "     * Travel class for " classname "`n" .
            "     * @type {" classname "}`n" .
            "     */`n" .
            "    " classname " := " classname "()`n" . 
            "`n" . 
            "    \; <classmarker>")

            travelcontents := StrReplace(travelcontents, " * <jsdocmarker>", 
            " * @property {" classname "} " classname " Travel class for " zonename "`n" .
            " * <jsdocmarker>")
            ; Copy modified sample to new file
            FileDelete(A_ScriptDir "\..\..\Lib\cTravel.ahk")
            FileAppend(travelcontents, A_ScriptDir "\..\..\Lib\cTravel.ahk")
        }
    }
}