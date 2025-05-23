#Requires AutoHotkey v2.0

#Include ..\Lib\Logging.ahk
#Include ..\Lib\cZone.ahk
#Include ..\Lib\cTravel.ahk

/**
 * Relics class for zone travel
 * @extends Zone
 * @memberof module:cTravel
 */
Class sRelics extends Zone {

    pTransmuteAll := cPoint(1015, 1101)
    ConfirmTransmute := cPoint(1362, 557) ; old this.ConfirmTransmute
    TabLegend := cPoint(1944, 1180)
    TabMastr := cPoint(2217, 1180)
    ResetMastr := cPoint(980, 737)

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
        cPoint(969, 88).ClickButtonActive()
        If (!Window.AwaitPanel()) {
            Return false
        }
        If (reset) {
            cPoint(570, 1163).ClickButtonActive()
            Sleep(50)
            cPoint(289, 1163).ClickButtonActive()
        }
        Return true
    }
    ;@endregion

    TabLegendary() {
        If (!this.TabLegend.ClickButtonActive()) {
            Return false
        }
        Sleep(100)
        Return true
    }

    TabMaster() {
        If (!this.TabMastr.ClickButtonActive()) {
            Return false
        }
        Sleep(100)
        Return true
    }

    TransmuteAll() {
        If (!this.pTransmuteAll.ClickButtonActive()) {
            Return false
        }
        If (!this.ConfirmTransmute.WaitUntilActiveButtonS(0.5)) {
            If (!this.pTransmuteAll.ClickButtonActive()) {
                Return false
            }
            If (!this.ConfirmTransmute.WaitUntilActiveButtonS(0.5)) {
                Return false
            }
        }
        ; Confirm
        If (!this.ConfirmTransmute.ClickButtonActive()) {
            Return false
        }
        Sleep(50)
        If (this.ConfirmTransmute.IsBackground()) {
            Return true
        }
        If (!this.ConfirmTransmute.ClickButtonActive()) {
            Return false
        }
        Sleep(50)

        Return true
    }

    ResetMaster() {
        If (!this.ResetMastr.ClickButtonActive()) {
            Return false
        }
        Sleep(50)
        ; Confirm
        If (!this.ConfirmTransmute.ClickButtonActive()) {
            Return false
        }
        Sleep(50)
        If (this.ConfirmTransmute.IsBackground()) {
            Return true
        }
        If (!this.ConfirmTransmute.ClickButtonActive()) {
            Return false
        }
        Sleep(50)

        Return true
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
