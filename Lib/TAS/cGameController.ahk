#Requires AutoHotkey v2.0

/**
 * Controller for TAS functionality. (Top level)
 * Handles main logic and is the controller for tasks
 */
Class cGameController {

    GS := GameState()

    Run() {
        ;fCheckGameSettings()
        ; This needs converting to load the raw > base64 > json data
        ; At the moment loads raw
        var := this.GS.GetCurrentGameMode()
        Switch var {
            Case "Basic":
                Return GameModeBasic(this.GS).RunCurrentStage()
            Case "ChallengeBasic":
                Return GameModeChallengeBasic(this.GS).RunCurrentStage()
            Case "ChallengeGem":
                Return GameModeChallengeGem(this.GS).RunCurrentStage()
            Case "OnlineChallenge":
                Return GameModeOnlineChallenge(this.GS).RunCurrentStage()
            default:
                Return GameModeBasic(this.GS).RunCurrentStage()
        }
    }
}