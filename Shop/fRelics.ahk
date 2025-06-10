#Requires AutoHotkey v2.0

#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTravel.ahk

/**
 * Relics class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class sRelics extends Zone {

    pTransmuteAll := cLBRButton(1015, 1101)
    ConfirmTransmute := cLBRButton(1362, 557) ; old this.ConfirmTransmute
    TabLegend := cLBRButton(1944, 1180)
    TabMastr := cLBRButton(2217, 1180)
    ResetMastr := cLBRButton(980, 737)

    ;@region cFeatureRelics main travel
    /**
     * Go to Relics panel can return on any tab
     * @param {Boolean} [reset=false] Click first tab after travel?
     * @returns {Boolean} Is panel active
     */
    GoTo(reset := false) {
        UlcWindow()
        Travel.ClosePanelIfActive()
        If (!Window.AwaitPanelClose()) {
            Return false
        }
        cLBRButton(969, 88).ClickButtonActive()
        If (!Window.AwaitPanel()) {
            Return false
        }
        If (reset) {
            cLBRButton(570, 1163).ClickButtonActive(5, 5)
            Sleep(50)
            cLBRButton(289, 1163).ClickButtonActive(5, 5)
        }
        Return true
    }
    ;@endregion

    TabLegendary() {
        While (!this.pTransmuteAll.IsButtonActive()) {
            this.TabLegend.ClickButtonActive(5, 5)
        }
        If (!this.pTransmuteAll.IsButtonActive()) {
            Return false
        }
        Return true
    }

    TabMaster() {
        While (!this.ResetMastr.IsButtonActive()) {
            this.TabMastr.ClickButtonActive(5, 5)
        }

        If (!this.ResetMastr.IsButtonActive()) {
            Return false
        }
        Return true
    }

    TransmuteAll() {
        this.pTransmuteAll.WaitUntilActiveButtonS(2)
        If (!this.pTransmuteAll.IsButtonActive()) {
            Out.I("No transmute all button")
            Return false
        }
        While (this.pTransmuteAll.IsButtonActive()) {
            this.pTransmuteAll.ClickButtonActive(5, 5)
        }

        this.ConfirmTransmute.WaitUntilActiveButtonS(2)
        If (!this.ConfirmTransmute.IsButtonActive()) {
            Out.I("No confirm transmute button")
            Return false
        }
        While (this.ConfirmTransmute.IsButtonActive()) {
            this.ConfirmTransmute.ClickButtonActive(5, 5)
        }

        Wait := A_Now
        While (!this.ConfirmTransmute.IsBackground() && DateDiff(A_now, Wait, "S") < 10) {
            Sleep(17)
        }
        If (this.ConfirmTransmute.IsBackground()) {
            Return true
        }
        Return false
    }

    ResetMaster() {
        this.ResetMastr.WaitUntilActiveButtonS(2)
        If (!this.ResetMastr.IsButtonActive()) {
            Return false
        }
        While (this.ResetMastr.IsButtonActive()) {
            this.ResetMastr.ClickButtonActive(5, 5)
        }

        this.ConfirmTransmute.WaitUntilActiveButtonS(2)
        If (!this.ConfirmTransmute.IsButtonActive()) {
            Return false
        }
        While (this.ConfirmTransmute.IsButtonActive()) {
            this.ConfirmTransmute.ClickButtonActive(5, 5)
        }

        If (this.ConfirmTransmute.IsBackground()) {
            Return true
        }
        Return false
    }

    ;@region TransMuteReset Spam
    /**
     * Transmute 10 times then reset looped
     * @param {Boolean} [reset=false] Click first tab after travel?
     * @returns {Boolean} Is panel active
     */
    TransMuteResetLoop() {
        UlcWindow()
        Shops.Relics.GoTo()
        If (!Window.AwaitPanel()) {
            Out.D("Panel false")
            Return false
        }
        Loop {
            If (!Shops.Relics.TabLegendary()) {
                Out.D("Legendary tab false")
                Return false
            }
            If (!Window.AwaitPanel()) {
                Out.D("loop AwaitPanel false")
                Return false
            }
            Loop 10 {
                If (!Shops.Relics.TransmuteAll()) {
                    Out.D("TransmuteAll false")
                    Return false
                }
            }
            If (!Shops.Relics.TabMaster()) {
                Out.D("TabMaster false")
                Return false
            }
            If (!Shops.Relics.ResetMaster()) {
                Out.D("ResetMaster false")
                Return false
            }
        }
        Return true
    }
    ;@endregion

}
