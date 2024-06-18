#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine points for buttons
 * @property {cPoint} FreeFuel Mine (tab4) free fuel button
 * @property {cPoint} CoalSphere Mine (tab4) coal sphere button
 * @property {cPoint} Tab1Vein Mine navigate tab Vein
 * @property {cPoint} Tab2Mines Mine navigate tab Mines
 * @property {cPoint} Tab4Drill Mine navigate tab Drill
 * @property {cPoint} Tab5Shop Mine navigate tab Shop
 * @property {cPoint} Tab6Transmute Mine navigate tab Transmute
 */
Class cMinePoints {
    FreeFuel := cPoint(1220, 615)
    CoalSphere := cPoint(1260, 445)
    Tab1Vein := cPoint(526, 1180)
    Tab2Mines := cPoint(760, 1180)
    Tab4Drill := cPoint(1320, 1180)
    Tab5Shop := cPoint(1600, 1180)
    Tab6Transmute := cPoint(1900, 1180)
}