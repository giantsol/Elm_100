import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket
import Json.Decode as Decode

main =
    Html.program {
    init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
wsUrl = "ws://echo.websocket.org"

-- Model
type alias Model =
    {
    input: String
    , messages: List String
    }

init: (Model, Cmd Msg)
init =
    (Model "" [], Cmd.none)

-- Update
type Msg =
    Input String
    | Send
    | NewMessage String
    | KeyDown Int

update: Msg -> Model -> (Model, Cmd Msg)
update msg { input, messages } =
    case msg of
        Input newInput ->
            (Model newInput messages, Cmd.none)

        Send ->
            (Model "" messages, WebSocket.send wsUrl input)

        NewMessage str ->
            (Model input (str :: messages), Cmd.none)

        KeyDown key ->
            if key == 13 then
                update Send (Model input messages)
            else
                ((Model input messages), Cmd.none)


-- Subscriptions
subscriptions: Model -> Sub Msg
subscriptions model =
    WebSocket.listen wsUrl NewMessage

-- View
view: Model -> Html Msg
view model =
    div []
        [ div [] (List.map viewMessage model.messages)
        , input [onInput Input, onKeyDown KeyDown, value model.input] []
        , button [onClick Send] [text "Send"]
        ]

onKeyDown: (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Decode.map tagger keyCode)

viewMessage: String -> Html Msg
viewMessage msg =
    div [] [text msg]
