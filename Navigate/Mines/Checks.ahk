#Requires AutoHotkey v2.0

/**
 * Is current panel on Mine Coal Vein tab
 * @returns {Integer} 
 */
IsOnMineCoalVeinTab() {
    if (Points.Mine.Vein.Search.IsButton() &&
        Points.Mine.Vein.AutoMine.IsButton()) {
        return true
    }
    return false
}

/**
 * Is current panel on Mine Transmute tab
 * @returns {Integer} 
 */
IsOnMineTransmuteTab() {
    if (
        !Points.Mine.Transmute.SingleCBarToCDia.IsBackground() &&
        !Points.Mine.Transmute.SingleCDiaToSDia.IsBackground() &&
        !Points.Mine.Transmute.SingleCDiaToFuel.IsBackground() &&
        !Points.Mine.Transmute.SingleCDiaToSphere.IsBackground() &&
        !Points.Mine.Transmute.AllCBarsToCDias.IsBackground() &&
        !Points.Mine.Transmute.AllCDiasToSDias.IsBackground() &&
        !Points.Mine.Transmute.AllCDiasToFuel.IsBackground() &&
        !Points.Mine.Transmute.AllCDiasToSpheres.IsBackground() &&
        !Points.Mine.Transmute.AllSDiasToCDia.IsBackground() &&
        !Points.Mine.Transmute.AutoCBarToCDia.IsBackground() &&
        !Points.Mine.Transmute.AutoCDiaToSDia.IsBackground() &&
        !Points.Mine.Transmute.AutoCDiaToFuel.IsBackground() &&
        !Points.Mine.Transmute.AutoCDiaToSphere.IsBackground()
    ) {
        return true
    }
    return false
}

/**
 * Is current panel on Mine Drill tab
 * @returns {Integer} 
 */
IsOnMineDrillTab() {
    if (Points.Mine.CoalSphere.IsButton() &&
        Points.Mine.FreeFuel.IsButton()) {
        return true
    }
    return false
}

/**
 * Is current panel on Mine Caves tab
 * @returns {Integer} 
 */
IsOnMineCavesTab() {
    if (Points.Mine.Cave.Select1.IsButton() &&
        Points.Mine.Cave.AutoSearch.IsButton()) {
        return true
    }
    return false
}