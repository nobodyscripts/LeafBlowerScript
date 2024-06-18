#Requires AutoHotkey v2.0

#Include ..\..\Lib\cPoints.ahk

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
    SingleCBarToCDia := cPoint(600, 387)
    SingleCDiaToSDia := cPoint(603, 518)
    SingleCDiaToFuel := cPoint(603, 644)
    SingleCDiaToSphere := cPoint(602, 774)
    AllCBarsToCDias := cPoint(703, 385)
    AllCDiasToSDias := cPoint(723, 516)
    AllCDiasToFuel := cPoint(724, 644)
    AllCDiasToSpheres := cPoint(722, 772)
    AllSDiasToCDia := cPoint(1750, 512)
    AutoCBarToCDia := cPoint(1082, 384)
    AutoCDiaToSDia := cPoint(1083, 514)
    AutoCDiaToFuel := cPoint(1085, 643)
    AutoCDiaToSphere := cPoint(1083, 771)
}