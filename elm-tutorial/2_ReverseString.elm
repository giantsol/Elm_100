import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- Model

type alias Model =
    { content: String
    }

model: Model
model =
    { content = ""
    }

-- Update

type Msg =
    Change String

update: Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

-- View

view: Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]
