import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Debug exposing (log)
import Json.Decode as Decode

-- Simple project using Union Types in Elm to implement LinkedList

main =
    Html.beginnerProgram {
    model = model
    , view = view
    , update = update
    }

-- Model

type LinkedList = Empty | Node String LinkedList
type alias Model =
    {
    linkedList: LinkedList
    , input: String
    }

model: Model
model = Model Empty ""

-- Update
type Msg
    = Input String
    | Click
    | KeyDown Int

update: Msg -> Model -> Model
update msg model =
    case msg of
        Click ->
            let
                linkedList = Node model.input model.linkedList
                a = Debug.log (toString linkedList) ""
            in
                { model | linkedList = linkedList, input = "" }

        Input input ->
            { model | input = input}

        KeyDown key ->
            if key == 13 then
                update Click model
            else
                model


-- View
view: Model -> Html Msg
view model =
    div []
        [
        input [onInput Input, value model.input, onKeyDown KeyDown] []
        , button [onClick Click] [text "Click"]
        , div [] (listView model.linkedList)
        ]

onKeyDown: (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Decode.map tagger keyCode)

listView: LinkedList -> List (Html Msg)
listView linkedList =
    case linkedList of
        Empty ->
            [(div [] [])]

        Node value remaining ->
            (div [] [text value]) :: listView remaining

