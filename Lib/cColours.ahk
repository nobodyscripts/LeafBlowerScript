#Requires AutoHotkey v2.0

/**
 * Collection of static colours and functions to check if pixels are certain
 * things.
 */
Class Colours {

    ; 0xFFF1D2
    Active := "0xFFF1D2"
    ; 0xFDD28A
    ActiveMouseOver := "0xFDD28A"
    ; 0xB3A993
    AfkActive := "0xB3A993"
    ; 0xB29361
    AfkActiveMouseover := "0xB29361"
    ; 0x837C6C
    DarkBgActive := "0x837C6C"
    ; 0x826C47
    DarkBgActiveMouseover := "0x826C47"
    ; 0xC8BDA5
    Inactive := "0xC8BDA5"
    ; 0x97714A
    Background := "0x97714A"
    ; 0x97714B
    BackgroundSpotify := "0x97714B"

    /**
     * Is the provided colour a LBR button
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButton(colour) {
        if (colour = this.Active ||
            colour = this.ActiveMouseOver ||
            colour = this.AfkActive ||
            colour = this.AfkActiveMouseover ||
            colour = this.Inactive) {
            return true
        }
        return false
    }

    /**
     * Is the provided colour a LBR button in mouseover state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsMouseOver(colour) {
        if (colour = this.ActiveMouseOver ||
            colour = this.AfkActiveMouseover) {
            return true
        }
        return false
    }

    /**
     * Is the provided colour a LBR button in active state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonActive(colour) {
        if (colour = this.Active ||
            colour = this.ActiveMouseOver ||
            colour = this.AfkActive ||
            colour = this.AfkActiveMouseover) {
            return true
        }
        return false
    }

    /**
     * Is the provided colour a LBR button in inactive state
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonInactive(colour) {
        if (colour = this.Inactive) {
            return true
        }
        return false

    }

    /**
     * Is the provided colour the LBR background panel colour
     * @param colour 
     * @returns {Integer} true/false
     */
    IsBackground(colour) {
        if (colour = this.Background ||
            colour = this.BackgroundSpotify) {
            return true
        }
        return false
    }

    /**
     * Is the provided colour NOT an LBR button or background
     * @param colour 
     * @returns {Integer} true/false
     */
    IsCoveredByNotification(colour) {
        if (colour = this.Active ||
            colour = this.ActiveMouseOver ||
            colour = this.AfkActive ||
            colour = this.AfkActiveMouseover ||
            colour = this.Inactive ||
            colour = this.Background ||
            colour = this.BackgroundSpotify) {
            return false
        }
        return true
    }

    /**
     * Is the provided colour a LBR button off the panels
     * @param colour 
     * @returns {Integer} true/false
     */
    IsButtonOffPanel(colour) {
        if (colour = this.Active ||
            colour = this.ActiveMouseOver ||
            colour = this.AfkActive ||
            colour = this.AfkActiveMouseover ||
            colour = this.Inactive ||
            colour = this.DarkBgActive ||
            colour = this.DarkBgActiveMouseover) {
            return true
        }
        return false
    }
}