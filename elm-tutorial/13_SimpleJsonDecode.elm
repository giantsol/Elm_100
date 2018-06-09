import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (decodeString, int)

main =
    Html.beginnerProgram {
    model = model
    , view = view
    , update = update
    }


-- Init

type alias Model =
    {
    toIntTargetString: String
    , toIntDecodedString: String
    }

model: Model
model =
    Model "" ""


-- Update

type Msg =
    KeyDown Int
    | InputInt String
    | DecodeToInt

update: Msg -> Model -> Model
update msg model =
    case msg of
        KeyDown key ->
            if key == 13 then
                update DecodeToInt model
            else
                model

        InputInt input ->
            { model | toIntTargetString = input }

        DecodeToInt ->
            decodeToInt model

decodeToInt: Model -> Model
decodeToInt model =
    let
        result = decodeString int model.toIntTargetString
    in
        case result of
            Ok value ->
                {model
                | toIntTargetString = ""
                , toIntDecodedString = toString value}

            Err errorString ->
                {model
                | toIntDecodedString = errorString}


-- View
view: Model -> Html Msg
view model =
    div []
        [
        text "Type in number to decode into Elm integer: "
        , input [onInput InputInt, value model.toIntTargetString, onKeyDown KeyDown] []
        , div [] [text model.toIntDecodedString]
        ]

onKeyDown: (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Decode.map tagger keyCode)

