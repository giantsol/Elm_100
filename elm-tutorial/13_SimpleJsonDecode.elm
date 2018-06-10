import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (decodeString, int, float)

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
    , toFloatTargetString: String
    , toFloatDecodedString: String
    }

model: Model
model =
    Model "" "" "" ""


-- Update

type Msg =
    InputInt String
    | DecodeToInt
    | InputFloat String
    | DecodeToFloat

update: Msg -> Model -> Model
update msg model =
    case msg of
        InputInt input ->
            { model | toIntTargetString = input }

        DecodeToInt ->
            decodeToInt model

        InputFloat input ->
            { model | toFloatTargetString = input }

        DecodeToFloat ->
            decodeToFloat model

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

decodeToFloat: Model -> Model
decodeToFloat model =
    let
        result = decodeString float model.toFloatTargetString
    in
        case result of
            Ok value ->
                {model
                | toFloatTargetString = ""
                , toFloatDecodedString = toString value}

            Err errorString ->
                {model
                | toFloatDecodedString = errorString}


-- View
view: Model -> Html Msg
view model =
    div []
        [
        decodeBox "Type in number to decode into Elm integer: "
          InputInt
          model.toIntTargetString
          DecodeToInt
          model.toIntDecodedString
        , decodeBox "Type in float to decode into Elm float: "
            InputFloat
            model.toFloatTargetString
            DecodeToFloat
            model.toFloatDecodedString

        ]

decodeBox: String -> (String -> Msg) -> String -> Msg -> String -> Html Msg
decodeBox desc onInputCallback inputBoxValue decodeToWhat decodedValue =
    div []
        [
        text desc
        , input [onInput onInputCallback, value inputBoxValue, onEnter decodeToWhat] []
        , div [] [text decodedValue]
        ]

onEnter : msg -> Attribute msg
onEnter tagger =
    let
        isEnter code =
            if code == 13 then
                Decode.succeed ""
            else
                Decode.fail ""
        decodeEnter =
            Decode.andThen isEnter keyCode
    in
        on "keydown" <| Decode.map (\key -> tagger) decodeEnter

