module Main exposing (..)

import Html exposing (..)

-- Model
type alias Model =
    String

init: (Model, Cmd Msg)
init =
    ("Hello", Cmd.none)


-- Update
type Msg
    = NoOp

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)


-- Subs
subscriptions: Model -> Sub Msg
subscriptions model =
    Sub.none


-- View
view: Model -> Html Msg
view model =
    div []
        [ text model ]

-- Main
main: Program Never Model Msg
main =
    Html.program {
        init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }
