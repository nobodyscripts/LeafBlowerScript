#Requires AutoHotkey v2.0

/**
 * DailyGems Class to handle daily gems interface
 * @module DailyGems
 * @method CollectAll Collect all daily gems
 */
Class DailyGems {

    ;@region CollectAll()
    /**
     * Collect all daily gems
     */
    CollectAll() {
        UlcWindow()
        Out.V("Get Daily Gems Reward")
        /** Daily Gems Feature Open
         * @type {cLBRButton} */
        DailyOpenWindow := cLBRButton(710, 139)
        /** Claim Gems Button
         * @type {cLBRButton} */
        ClaimDaily := cLBRButton(664, 420)
        /** Daily Gems Button
         * @type {cLBRButton} */
        DailyOpenTab := cLBRButton(527, 1181)

        Travel.ClosePanelIfActive()
        DailyOpenWindow.Click()
        DailyOpenTab.WaitUntilButton()
        DailyOpenTab.ClickOffset(, 5)
        ClaimDaily.WaitUntilButton() ; Wait for panel
        ClaimDaily.ClickButtonActive()
        ClaimDaily.ClickButtonActive()
        Travel.ClosePanelIfActive()
    }
    ;@endregion
}
