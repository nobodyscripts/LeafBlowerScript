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
        Switch var {
            Case "Basic":
                Return GameModeBasic(this.GS)
            Case "ChallengeBasic":
                Return GameModeChallengeBasic(this.GS)
            Case "ChallengeGem":
                Return GameModeChallengeGem(this.GS)
            Case "OnlineChallenge":
                Return GameModeOnlineChallenge(this.GS)
            default:
                Return GameModeBasic(this.GS)
        }
    }
}