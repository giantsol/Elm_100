module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    {
    players: WebData (List Player)
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
    Model RemoteData.Loading
