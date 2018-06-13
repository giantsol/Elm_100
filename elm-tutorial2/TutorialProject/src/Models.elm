module Models exposing (..)

type alias Model =
    {
    players: List Player
    }

type alias Player =
    {
    id: PlayerId
    , name: String
    , level: Int
    }

type alias PlayerId =
    String

initialModel: Model
initialModel =
    Model [
        Player "1" "Sam" 1
        , Player "2" "HeyMan" 1
    ]
