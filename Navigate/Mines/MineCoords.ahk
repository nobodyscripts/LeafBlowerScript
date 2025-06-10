#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

/**
 * Mine points for buttons
 * @memberof module:cPoints
 * @property {cLBRButton} FreeFuel Mine (tab4) free fuel button
 * @property {cLBRButton} CoalSphere Mine (tab4) coal sphere button
 * @property {cLBRButton} Tab1Vein Mine navigate tab Vein
 * @property {cLBRButton} Tab2Mines Mine navigate tab Mines
 * @property {cLBRButton} Tab4Drill Mine navigate tab Drill
 * @property {cLBRButton} Tab5Shop Mine navigate tab Shop
 * @property {cLBRButton} Tab6Transmute Mine navigate tab Transmute
 * @property {cCavePoints} Cave
 * @property {cTransmutePoints} Transmute
 * @property {cVeinPoints} Vein
 */
Class cMinePoints {
    /** @type {cLBRButton} */
    FreeFuel := cLBRButton(1220, 615)
    /** @type {cLBRButton} */
    CoalSphere := cLBRButton(1260, 445)
    /** @type {cLBRButton} */
    Tab1Vein := cLBRButton(526, 1180)
    /** @type {cLBRButton} */
    Tab2Mines := cLBRButton(760, 1180)
    /** @type {cLBRButton} */
    Tab4Drill := cLBRButton(1320, 1180)
    /** @type {cLBRButton} */
    Tab5Shop := cLBRButton(1600, 1180)
    /** @type {cLBRButton} */
    Tab6Transmute := cLBRButton(1900, 1180)

    /** @type {cCavePoints} Mine Cave points */
    Cave := cCavePoints()

    /** @type {cTransmutePoints} Mine Transmute points */
    Transmute := cTransmutePoints()

    /** @type {cVeinPoints} Mine Vein points */
    Vein := cVeinPoints()
}

/**
 * Mine Transmute points for buttons
 * @memberof module:cLBRButtons
 * @property {cLBRButton} SingleCBarToCDia Button for Transmute CBar to CDia once
 * @property {cLBRButton} SingleCDiaToSDia Button for Transmute CDia to SDia once
 * @property {cLBRButton} SingleCDiaToFuel Button for Transmute CDia to Fuel once
 * @property {cLBRButton} SingleCDiaToSphere Button for Transmute CDia to Sphere
 * once
 * @property {cLBRButton} AllCBarsToCDias Button for Transmute all CBars to CDias
 * @property {cLBRButton} AllCDiasToSDias Button for Transmute all CDias to SDias
 * @property {cLBRButton} AllCDiasToFuel Button for Transmute all CDias to Fuel
 * @property {cLBRButton} AllCDiasToSpheres Button for Transmute all CDias to 
 * Spheres
 * @property {cLBRButton} AllSDiasToCDia Button for Transmute all SDias to CDias
 * @property {cLBRButton} AutoCBarToCDia Button for Auto Transmute all CBar to CDia
 * @property {cLBRButton} AutoCDiaToSDia Button for Auto Transmute all CDia to SDia
 * @property {cLBRButton} AutoCDiaToFuel Button for Auto Transmute all CDia to Fuel
 * @property {cLBRButton} AutoCDiaToSphere Button for Auto Transmute all CDia to 
 * Sphere
 */
Class cTransmutePoints {
    /** @type {cLBRButton} */
    SingleCBarToCDia := cLBRButton(600, 387)
    /** @type {cLBRButton} */
    SingleCDiaToSDia := cLBRButton(603, 518)
    /** @type {cLBRButton} */
    SingleCDiaToFuel := cLBRButton(603, 644)
    /** @type {cLBRButton} */
    SingleCDiaToSphere := cLBRButton(602, 774)
    /** @type {cLBRButton} */
    AllCBarsToCDias := cLBRButton(703, 385)
    /** @type {cLBRButton} */
    AllCDiasToSDias := cLBRButton(723, 516)
    /** @type {cLBRButton} */
    AllCDiasToFuel := cLBRButton(724, 644)
    /** @type {cLBRButton} */
    AllCDiasToSpheres := cLBRButton(722, 772)
    /** @type {cLBRButton} */
    AllSDiasToCDia := cLBRButton(1750, 512)
    /** @type {cLBRButton} */
    AutoCBarToCDia := cLBRButton(1082, 384)
    /** @type {cLBRButton} */
    AutoCDiaToSDia := cLBRButton(1083, 514)
    /** @type {cLBRButton} */
    AutoCDiaToFuel := cLBRButton(1085, 643)
    /** @type {cLBRButton} */
    AutoCDiaToSphere := cLBRButton(1083, 771)
}

/**
 * Cave points for buttons
 * 78d063 (Some colour that was left in old file)
 * @memberof module:cLBRButtons
 * @property {cLBRButton} DrillToggle Button for toggling drill on/off
 * @property {cLBRButton} AutoSearch Button for toggling auto search on/off
 * @property {cLBRButton} Select1 Button for selecting which cave to show
 * @property {cLBRButton} Select2 Button for selecting which cave to show
 * @property {cLBRButton} Select3 Button for selecting which cave to show
 * @property {cLBRButton} Select4 Button for selecting which cave to show
 * @property {cLBRButton} Select5 Button for selecting which cave to show
 */
Class cCavePoints {
    /** @type {cLBRButton} */
    DrillToggle := cLBRButton(970, 940)
    /** @type {cLBRButton} */
    AutoSearch := cLBRButton(768, 288)
    /** @type {cLBRButton} */
    Select1 := cLBRButton(328, 490)
    /** @type {cLBRButton} */
    Select2 := cLBRButton(328, 555)
    /** @type {cLBRButton} */
    Select3 := cLBRButton(328, 619)
    /** @type {cLBRButton} */
    Select4 := cLBRButton(328, 682)
    /** @type {cLBRButton} */
    Select5 := cLBRButton(328, 747)
}
