#Requires AutoHotkey v2.0

/**
 * Controller for TAS functionality. (Top level)
 * Handles main logic and is the controller for tasks
 */
Class cGameController {

    GS := GameState()

    Run() {
        fCheckGameSettings()
        var := this.GS.GetCurrentGameMode()
        switch var {
            case "Basic":
                return GameModeBasic(this.GS)
            case "ChallengeBasic":
                return GameModeChallengeBasic(this.GS)
            case "ChallengeGem":
                return GameModeChallengeGem(this.GS)
            case "OnlineChallenge":
                return GameModeOnlineChallenge(this.GS)
            default:
                return GameModeBasic(this.GS)
        }
    }
}