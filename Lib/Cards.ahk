#Requires AutoHotkey v2.0

fOpenCardLoop()
{
    if !WinExist("Leaf Blower Revolution") {
        return ; Kill early if no game
    }
    WinActivate("Leaf Blower Revolution") ; Activate window to bypass loop check

    OpenPets()
    ; Opens or closes another screen so that when areas is opened it doesn't
    ; close
    Sleep 100
    OpenCards()
    Sleep 100
    If (CheckForTransparentPanelsSilent()) {
        ; Warning is displayed if there is an issue, return to avoid harm
        return
    }
    fSlowClick(202, 574)
    ; Open leaf galaxy tab incase wrong tab and to reset scroll

    loop {
        ; Check if lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        ClickOffset := WinRelPosLargeH(2)
        CommonX := WinRelPosLargeW(565)
        CommonY := WinRelPosLargeH(820)
        if (IsCoveredByNotification(CommonX, CommonY)) {
            fCustomClick(CommonX, CommonY, 34)
        }
        CommonButtonActive := IsButtonActive(CommonX, CommonY)
        ; Check if button is active, if not we can skip

        if (CardsDontOpenCommons = false && CommonButtonActive) {
            CardNumberToModifier(CardsCommonAmount)
            fCustomClick(CommonX, CommonY + ClickOffset)
            ; Common pack open
            Sleep CardsSleepAmount
        }

        RareX := WinRelPosLargeW(1130)
        RareY := WinRelPosLargeH(820)
        ;if (IsCoveredByNotification(RareX, RareY)) {
        ;    fCustomClick(RareX, RareY, 34)
        ;}
        RareButtonActive := IsButtonActive(RareX, RareY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenRare = false && RareButtonActive) {
            CardNumberToModifier(CardsRareAmount)
            fCustomClick(RareX, RareY + ClickOffset)
            ; Rare pack open
            Sleep CardsSleepAmount
        }

        LegendaryX := WinRelPosLargeW(1690)
        LegendaryY := WinRelPosLargeH(820)
        ;if (IsCoveredByNotification(LegendaryX, LegendaryY)) {
        ;    fCustomClick(LegendaryX, LegendaryY, 34)
        ;}
        LegendaryButtonActive := IsButtonActive(LegendaryX, LegendaryY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenLegendary = false && LegendaryButtonActive) {
            CardNumberToModifier(CardsLegendaryAmount)
            fCustomClick(LegendaryX, LegendaryY + ClickOffset)
            ; Legendary pack open
            Sleep CardsSleepAmount
        }

        If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive)
        {
            break
        }

        ResetModifierKeys() ; Cleanup ctrl+shift+alt modifiers
    }
    ToolTip("Card opening aborted`nFound no active buttons.`nF3 to remove note",
        W / 2 - WinRelPosLargeH(170), H / 2)
    ResetModifierKeys() ; Cleanup incase of broken loop
}

CardBuyLoop() {
    loop {
        ; Check if lost focus, close or crash and break if so
        if !WinExist("Leaf Blower Revolution") ||
            !WinActive("Leaf Blower Revolution") {
                break
        }
        WinActivate("Leaf Blower Revolution")
        ; Use the window found by WinExist.
        WinGetClientPos &X, &Y, &W, &H, "Leaf Blower Revolution"
        ; Update window size

        ClickOffset := WinRelPosLargeH(2)

        CommonX := WinRelPosLargeW(593)
        CommonY := WinRelPosLargeH(955)
        CommonButtonActive := IsButtonActive(CommonX, CommonY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenCommons = false && CommonButtonActive) {
            CardNumberToModifier(CardsCommonAmount)
            fCustomClick(CommonX, CommonY + ClickOffset)
            ; Common pack open
        }

        RareX := WinRelPosLargeW(1158)
        RareY := WinRelPosLargeH(955)
        RareButtonActive := IsButtonActive(RareX, RareY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenRare = false && RareButtonActive) {
            CardNumberToModifier(CardsRareAmount)
            fCustomClick(RareX, RareY + ClickOffset)
            ; Rare pack open
        }

        LegendaryX := WinRelPosLargeW(1690)
        LegendaryY := WinRelPosLargeH(955)
        LegendaryButtonActive := IsButtonActive(LegendaryX, LegendaryY)
        ; Check if button is active, if not we can skip
        if (CardsDontOpenLegendary = false && LegendaryButtonActive) {
            CardNumberToModifier(CardsLegendaryAmount)
            fCustomClick(LegendaryX, LegendaryY + ClickOffset)
            ; Legendary pack open
        }

        If (!CommonButtonActive && !RareButtonActive && !LegendaryButtonActive)
        {
            break
        }

        Sleep CardsSleepAmount
        ResetModifierKeys() ; Cleanup ctrl+shift+alt modifiers
    }
    ResetModifierKeys() ; Cleanup incase of broken loop
}

CardNumberToModifier(num) {
    /*
    shift 10
    ctrl 25
    alt 100
    */
    switch num {
        case 10:
            ControlSend "{Shift down}", , "Leaf Blower Revolution"
        case 25:
            ControlSend "{Control down}", , "Leaf Blower Revolution"
        case 100:
            ControlSend "{Alt down}", , "Leaf Blower Revolution"
        case 250:
            ControlSend "{Control down}", , "Leaf Blower Revolution"
            ControlSend "{Shift down}", , "Leaf Blower Revolution"
        case 1000:
            ControlSend "{Alt down}", , "Leaf Blower Revolution"
            ControlSend "{Shift down}", , "Leaf Blower Revolution"
        case 2500:
            ControlSend "{Control down}", , "Leaf Blower Revolution"
            ControlSend "{Alt down}", , "Leaf Blower Revolution"
        case 25000:
            ControlSend "{Control down}", , "Leaf Blower Revolution"
            ControlSend "{Alt down}", , "Leaf Blower Revolution"
            ControlSend "{Shift down}", , "Leaf Blower Revolution"
        default:

    }
}