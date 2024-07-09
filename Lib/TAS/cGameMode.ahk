#Requires AutoHotkey v2.0

/**
 * Adapt to which type of speedrun we are attempting (second level)
 */
Class cGameMode {
    Type := ""
    GameState := {}
    Stage := {}

    __New(GameState) {
        this.GameState := GameState
    }

    GetProgressStage() {
        ; This needs to reflect what stage the game is in
        this.Stage := this.GameState.LoadCurrent()
    }
}

Class GameModeBasic extends cGameMode {

    Type := "Basic"

    RunCurrentStage() {
        While (this.GetProgressStage() = "BasicLeaf") {
            StageBasicLeaf().RunTaskList()
        }
    }
}

Class GameModeChallengeBasic extends cGameMode {

    Type := "ChallengeBasic"

}

Class GameModeChallengeGem extends cGameMode {

    Type := "ChallengeGem"

}

Class GameModeOnlineChallenge extends cGameMode {

    Type := "OnlineChallenge"

    __New(GameState) {
        Throw Error("Not adding online challenge support")
    }
}