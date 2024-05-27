#Requires AutoHotkey v2.0

IsOnMineCoalVeinTab() {
    if (cMineVeinSearchButton().IsButton() &&
        cMineVeinAutoMineButton().IsButton()) {
        return true
    }
    return false
}

IsOnMineTransmuteTab() {
    if (
        !cMineTransmuteSingleCBar().IsBackground() &&
        !cMineTransmuteSingleSdia().IsBackground() &&
        !cMineTransmuteSingleFuel().IsBackground() &&
        !cMineTransmuteSingleSphere().IsBackground() &&
        !cMineTransmuteMaxCBar().IsBackground() &&
        !cMineTransmuteMaxSdia().IsBackground() &&
        !cMineTransmuteMaxFuel().IsBackground() &&
        !cMineTransmuteMaxSphere().IsBackground() &&
        !cMineTransmuteAutoCBar().IsBackground() &&
        !cMineTransmuteAutoSdia().IsBackground() &&
        !cMineTransmuteAutoFuel().IsBackground() &&
        !cMineTransmuteAutoSphere().IsBackground()
    ) {
        return true
    }
    return false
}

IsOnMineDrillTab() {
    if (cMineDrillSphereButton().IsButton() &&
        cMineFreeFuelButton().IsButton()) {
        return true
    }
    return false
}

IsOnMineCavesTab() {
    if (cMineCaveSelectButton1().IsButton() &&
        cMineCaveAutoSearchButton().IsButton()) {
        return true
    }
    return false
}