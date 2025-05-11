#Requires AutoHotkey v2.0
#Include ../Lib/cRects.ahk
#Include ../Lib/cPoints.ahk

Global FishCatchingDelay := 5

/**
 * Fishing Class to contain all fishing related functions
 * @module Fishing
 * @property {Type} property Desc
 * @method Name Desc
 */
Class Fishing {
    /** @type {cPoint} */
    Lure := cPoint(858, 314)
    /** @type {cPoint} */
    ConfirmCancel := cPoint(1395, 556)
    /** @type {cPoint} */
    Search := cPoint(524, 313)
    /** @type {cPoint} */
    NewPondRod := cPoint(968, 892)
    /** @type {cPoint} */
    NewPondRod2 := cPoint(1048, 892)
    /** @type {cPoint} */
    NewPondRod3 := cPoint(1128, 892)

    Pond1 := Pond(1)
    Pond2 := Pond(2)
    Pond3 := Pond(3)
    Pond4 := Pond(4)

    ;@region fFishAutoCatch()
    /**
     * Attempt to auto catch fish (Simple)
     */
    fFishAutoCatch(challenge := false) {
        Time1 := A_Now
        Time2 := A_Now
        Time3 := A_Now
        Time4 := A_Now
        Search := challenge
        Loop {
            If (!Window.IsActive()) {
                Break
            }
            this.FishPonds(&Search, &Time1, &Time2, &Time3, &Time4)
        }
    }
    ;@endregion

    ;@region FishPonds()
    /**
     * Fish ponds a single time
     */
    FishPonds(&Search, &Time1, &Time2, &Time3, &Time4) {
        If (!Search) {
            if(!this.PondQualityUpgrade()) {
                ; Disable search if all ponds legendary
                Search := true
            }
        }
        If (!this.Pond1.CastRod.IsBackground()) {
            this.FishPond(this.Pond1, &Time1, 1)
        }
        If (!this.Pond2.CastRod.IsBackground()) {
            this.FishPond(this.Pond2, &Time2, 2)
        }
        If (!this.Pond3.CastRod.IsBackground()) {
            this.FishPond(this.Pond3, &Time3, 3)
        }
        If (!this.Pond4.CastRod.IsBackground()) {
            this.FishPond(this.Pond4, &Time4, 4)
        }
        Sleep (17)
        If (this.Lure.IsButtonActive()) {
            this.Lure.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region FishPond()
    /**
     * Fish ponds a single time
     */
    FishPond(pond, &Time, id) {
        If (!pond.Progress.pixelSearch()) {
            ; Was off cooldown and nothing catching
            pond.CastRod.ClickButtonActive()
        }
        If (pond.Progress.PixelSearch() && !pond.CooldownSuffix.PixelSearch()) {
            ;Out.D("Resetting cd on" id)
            Time := A_Now
        }
        If (Time && DateDiff(A_Now, Time, "S") > FishCatchingDelay) {
            ;Out.D("Casting " id)
            pond.CastRod.ClickButtonActive()
        }
    }
    ;@endregion

    ;@region IsSearchOffCD()
    /**
     * Check if pond search cooldown has reset
     */
    IsSearchOffCD() {
        If (cRect(392, 344, 531, 375).pixelSearch()) {
            Return false
        }
        Return true
    }
    ;@endregion

    ;@region AreAllPondsMax()
    /**
     * Check if all ponds are legendary
     */
    AreAllPondsMax() {
        p1 := this.Pond1.GetPondRarity()
        p2 := this.Pond2.GetPondRarity()
        p3 := this.Pond3.GetPondRarity()
        p4 := this.Pond4.GetPondRarity()
        If (p4 > 0 && p1 = 6 && p2 = 6 && p3 = 6 && p4 = 6) {
            out.d("1")
            Return true
        } Else {
            out.d("2")
            Return false
        }
        If (p3 > 0 && p1 = 6 && p2 = 6 && p3 = 6) {
            out.d("3")
            Return true
        } Else {
            out.d("4")
            Return false
        }
        If (p2 > 0 && p1 = 6 && p2 = 6) {
            out.d("5")
            Return true
        } Else {
            out.d("6")
            Return false
        }
        If (p1 = 6) {
            out.d("7")
            Return true
        } Else {
            out.d("8")
            Return false
        }
    }
    ;@endregion

    ;@region GetFirstPondOfRarity()
    /**
     * Get first pond where rarity matches var
     */
    GetFirstPondOfRarity(var) {
        p1 := this.Pond1.GetPondRarity()
        p2 := this.Pond2.GetPondRarity()
        p3 := this.Pond3.GetPondRarity()
        p4 := this.Pond4.GetPondRarity()
        If (var = p1) {
            Return 1
        }
        If (var = p2) {
            Return 2
        }
        If (var = p3) {
            Return 3
        }
        If (var = p4) {
            Return 4
        }
        Return false
    }
    ;@endregion

    ;@region PondQualityUpgrade()
    /**
     * Check for and attempt to upgrade pond quality to max
     */
    PondQualityUpgrade() {
        If (this.AreAllPondsMax()) {
            Return false
        }
        If (!this.IsSearchOffCD()) {
            Return false
        }
        Out.I("Attempting pond upgrade")
        WeakestLink := false
        rarity := 1
        While (!WeakestLink && rarity < 6) {
            WeakestLink := this.GetFirstPondOfRarity(rarity)
            rarity++
        }
        If (!WeakestLink) {
            Out.D("Pond rarity upgrade failed to get a pond to upgrade")
            Return false
        }
        Switch (WeakestLink) {
        Case 1:
            While (!this.Pond1.Cancel.IsButtonActive()) {
                this.Pond1.CastRod.ClickButtonActive()
                Sleep(50)
            }
            this.Pond1.Cancel.ClickButtonActive()
            this.Pond1.Cancel.ClickButtonActive()
            Out.I("Canceled pond 1")
        Case 2:
            While (!this.Pond2.Cancel.IsButtonActive()) {
                this.Pond2.CastRod.ClickButtonActive()
                Sleep(50)
            }
            this.Pond2.Cancel.ClickButtonActive()
            this.Pond2.Cancel.ClickButtonActive()
            Out.I("Canceled pond 2")
        Case 3:
            While (!this.Pond3.Cancel.IsButtonActive()) {
                this.Pond3.CastRod.ClickButtonActive()
                Sleep(50)
            }
            this.Pond3.Cancel.ClickButtonActive()
            this.Pond3.Cancel.ClickButtonActive()
            Out.I("Canceled pond 3")
        Case 4:
            While (!this.Pond4.Cancel.IsButtonActive()) {
                this.Pond4.CastRod.ClickButtonActive()
                Sleep(50)
            }
            this.Pond4.Cancel.ClickButtonActive()
            this.Pond4.Cancel.ClickButtonActive()
            Out.I("Canceled pond 4")
        default:
        }
        If (!this.ConfirmCancel.WaitUntilActiveButtonS(3)) {
            Out.I("No confirm cancel, assuming no search state")
            Return false
        }
        this.ConfirmCancel.ClickButtonActive()
        this.Search.WaitUntilActiveButtonS(3)
        this.Search.ClickButtonActive()
        this.NewPondRod.WaitUntilActiveButtonS(3)
        this.NewPondRod.ClickButtonActive()
        this.NewPondRod2.ClickButtonActive()
        this.NewPondRod3.ClickButtonActive()
    }
    ;@endregion
}

/**
 * Pond class type to contain vars used in Fishing
 * @module Pond
 * @property {Type} property Desc
 * @method Name Desc
 */
Class Pond {
    /** @type {cPoint} Rarity point */
    Rarity := false
    /** @type {cPoint} */
    CastRod := ""
    /** @type {cPoint} */
    Cancel := ""
    /** @type {cRect} */
    Progress := ""
    /** @type {cRect} */
    CooldownSuffix := ""

    __New(id := 0) {
        Switch (id) {
        Case 1:
            this.Rarity := cPoint(308, 574)
            this.CastRod := cPoint(541, 667)
            this.Progress := cRect(400, 702, 500, 728)
            this.CooldownSuffix := cRect(464, 705, 500, 728)
            this.Cancel := cPoint(803, 485)
        Case 2:
            this.Rarity := cPoint(915, 569)
            this.CastRod := cPoint(1157, 667)
            this.Progress := cRect(1005, 699, 1108, 728)
            this.CooldownSuffix := cRect(1073, 703, 1108, 728)
            this.Cancel := cPoint(1411, 486)
        Case 3:
            this.Rarity := cPoint(307, 847)
            this.CastRod := cPoint(542, 972)
            this.Progress := cRect(396, 1001, 500, 1031)
            this.CooldownSuffix := cRect(465, 1004, 500, 1031)
            this.Cancel := cPoint(803, 787)
        Case 4:
            this.Rarity := cPoint(913, 879)
            this.CastRod := cPoint(1150, 972)
            this.Progress := cRect(1001, 1002, 1106, 1030)
            this.CooldownSuffix := cRect(1071, 1006, 1106, 1030)
            this.Cancel := cPoint(1409, 786)
        default:
        }
    }

    ;@region GetPondRarity()
    /**
     * Get pond rarity
     */
    GetPondRarity() {
        Return this.PondColourToRarity(this.Rarity.GetColour())
    }
    ;@endregion

    ;@region PondColourToRarity()
    /**
     * Convert colour code of pond rarity to rarity id
     */
    PondColourToRarity(colour) {
        Switch colour {
        Case "0xA0A0A0":
            Return 1
        Case "0x3B6CA0":
            Return 2
        Case "0x326DAB":
            Return 2
        Case "0xCDBA40":
            Return 3
        Case "0xD3C33F":
            Return 3
        Case "0xB3260A":
            Return 4
        Case "0x9D19B4":
            Return 5
        Case "0x9E10C1":
            Return 5
        Case "0xD9661E":
            Return 6
        Case "0xD9661F":
            Return 6
        Case "0xE1661A":
            Return 6
        Case "0x97714A":
            Return -1
        Default:
            Out.D("Pond colour could not be matched " colour)
            Return 0
        }
    }
    ;@endregion
}
