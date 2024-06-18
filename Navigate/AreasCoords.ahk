#Requires AutoHotkey v2.0

#Include ..\Lib\cPoints.ahk
#Include ..\Lib\cAreas.ahk

/**
 * AreasPanel points for buttons
 * This is for areas panel stuff which unfortunately has the same name as my rect class
 * @property {cPoint} Tab1 Tab for areas panel (Favourites)
 * @property {cPoint} Tab2 Tab for areas panel (Leaf Galaxy)
 * @property {cPoint} Tab7 Tab for areas panel (Quark Ambit)
 * @property {cPoint} Tab8 Tab for areas panel (Events)
 */
Class cAreasPanelPoints {
    Tab1 := cPoint(300, 1180)
    Tab2 := cPoint(535, 1164)
    Tab7 := cPoint(1760, 1164)
    Tab8 := cPoint(2006, 1164)
}

/**
 * Areas areas areas areas areas areas areas areas areas 
 * @property {cArea} GardenReset Garden reset area
 */
Class cAreasPanelAreas {
    GardenReset := cArea(1240, 5, 1280, 40)
}