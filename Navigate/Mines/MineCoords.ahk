#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine points for buttons
 * @memberof module:cPoints
 * @property {cPoint} FreeFuel Mine (tab4) free fuel button
 * @property {cPoint} CoalSphere Mine (tab4) coal sphere button
 * @property {cPoint} Tab1Vein Mine navigate tab Vein
 * @property {cPoint} Tab2Mines Mine navigate tab Mines
 * @property {cPoint} Tab4Drill Mine navigate tab Drill
 * @property {cPoint} Tab5Shop Mine navigate tab Shop
 * @property {cPoint} Tab6Transmute Mine navigate tab Transmute
 * @property {cCavePoints} Cave
 * @property {cTransmutePoints} Transmute
 * @property {cVeinPoints} Vein
 */
Class cMinePoints {
    /** @type {cPoint} */
    FreeFuel := cPoint(1220, 615)
    /** @type {cPoint} */
    CoalSphere := cPoint(1260, 445)
    /** @type {cPoint} */
    Tab1Vein := cPoint(526, 1180)
    /** @type {cPoint} */
    Tab2Mines := cPoint(760, 1180)
    /** @type {cPoint} */
    Tab4Drill := cPoint(1320, 1180)
    /** @type {cPoint} */
    Tab5Shop := cPoint(1600, 1180)
    /** @type {cPoint} */
    Tab6Transmute := cPoint(1900, 1180)

    /** @type {cCavePoints} Mine Cave points */
    Cave := cCavePoints()

    /** @type {cTransmutePoints} Mine Transmute points */
    Transmute := cTransmutePoints()

    /** @type {cVeinPoints} Mine Vein points */
    Vein := cVeinPoints()
}

/**
 * Mine Transmute points for buttons
 * @memberof module:cPoints
 * @property {cPoint} SingleCBarToCDia Button for Transmute CBar to CDia once
 * @property {cPoint} SingleCDiaToSDia Button for Transmute CDia to SDia once
 * @property {cPoint} SingleCDiaToFuel Button for Transmute CDia to Fuel once
 * @property {cPoint} SingleCDiaToSphere Button for Transmute CDia to Sphere
 * once
 * @property {cPoint} AllCBarsToCDias Button for Transmute all CBars to CDias
 * @property {cPoint} AllCDiasToSDias Button for Transmute all CDias to SDias
 * @property {cPoint} AllCDiasToFuel Button for Transmute all CDias to Fuel
 * @property {cPoint} AllCDiasToSpheres Button for Transmute all CDias to 
 * Spheres
 * @property {cPoint} AllSDiasToCDia Button for Transmute all SDias to CDias
 * @property {cPoint} AutoCBarToCDia Button for Auto Transmute all CBar to CDia
 * @property {cPoint} AutoCDiaToSDia Button for Auto Transmute all CDia to SDia
 * @property {cPoint} AutoCDiaToFuel Button for Auto Transmute all CDia to Fuel
 * @property {cPoint} AutoCDiaToSphere Button for Auto Transmute all CDia to 
 * Sphere
 */
Class cTransmutePoints {
    /** @type {cPoint} */
    SingleCBarToCDia := cPoint(600, 387)
    /** @type {cPoint} */
    SingleCDiaToSDia := cPoint(603, 518)
    /** @type {cPoint} */
    SingleCDiaToFuel := cPoint(603, 644)
    /** @type {cPoint} */
    SingleCDiaToSphere := cPoint(602, 774)
    /** @type {cPoint} */
    AllCBarsToCDias := cPoint(703, 385)
    /** @type {cPoint} */
    AllCDiasToSDias := cPoint(723, 516)
    /** @type {cPoint} */
    AllCDiasToFuel := cPoint(724, 644)
    /** @type {cPoint} */
    AllCDiasToSpheres := cPoint(722, 772)
    /** @type {cPoint} */
    AllSDiasToCDia := cPoint(1750, 512)
    /** @type {cPoint} */
    AutoCBarToCDia := cPoint(1082, 384)
    /** @type {cPoint} */
    AutoCDiaToSDia := cPoint(1083, 514)
    /** @type {cPoint} */
    AutoCDiaToFuel := cPoint(1085, 643)
    /** @type {cPoint} */
    AutoCDiaToSphere := cPoint(1083, 771)
}

/**
 * Cave points for buttons
 * 78d063 (Some colour that was left in old file)
 * @memberof module:cPoints
 * @property {cPoint} DrillToggle Button for toggling drill on/off
 * @property {cPoint} AutoSearch Button for toggling auto search on/off
 * @property {cPoint} Select1 Button for selecting which cave to show
 * @property {cPoint} Select2 Button for selecting which cave to show
 * @property {cPoint} Select3 Button for selecting which cave to show
 * @property {cPoint} Select4 Button for selecting which cave to show
 * @property {cPoint} Select5 Button for selecting which cave to show
 */
Class cCavePoints {
    /** @type {cPoint} */
    DrillToggle := cPoint(970, 940)
    /** @type {cPoint} */
    AutoSearch := cPoint(768, 288)
    /** @type {cPoint} */
    Select1 := cPoint(328, 490)
    /** @type {cPoint} */
    Select2 := cPoint(328, 555)
    /** @type {cPoint} */
    Select3 := cPoint(328, 619)
    /** @type {cPoint} */
    Select4 := cPoint(328, 682)
    /** @type {cPoint} */
    Select5 := cPoint(328, 747)
}
