#Requires AutoHotkey v2.0


; ----------------- Mine Caves -----------------

    ;78d063
    ;328 490
    ;328 555
    ;328 619
    ;328 682
    ;328 747
    
    cMineCaveSelectButton1() { ; Button for selecting which cave to show
        o := RelCoord()
        o.SetCoordRel(328, 490)
        return o
    }
    
    cMineCaveSelectButton2() {
        o := RelCoord()
        o.SetCoordRel(328, 555)
        return o
    }
    
    cMineCaveSelectButton3() {
        o := RelCoord()
        o.SetCoordRel(328, 619)
        return o
    }
    
    cMineCaveSelectButton4() {
        o := RelCoord()
        o.SetCoordRel(328, 682) 
        return o
    }
    
    cMineCaveSelectButton5() {
        o := RelCoord()
        o.SetCoordRel(328, 747)
        return o
    }
    
    cMineCaveDrillButton() {
        o := RelCoord()
        o.SetCoordRel(970, 940)
        return o
    }
    
    cMineCaveAutoSearchButton() {
        o := RelCoord()
        o.SetCoordRel(768, 288)
        return o
    }
    