import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
    Html.beginnerProgram {
    model = model
    , view = view
    , update = update
    }

-- Model
type alias Model =
    {
    useNotification: Bool
    , useAutoPlay: Bool
    , useLocation: Bool
    }

model: Model
model =
    Model False False False


-- Update
type Msg =
    ToggleNotification
    | ToggleAutoPlay
    | ToggleLocation

update: Msg -> Model -> Model
update msg model =
    case msg of
        ToggleNotification ->
          { model | useNotification = not model.useNotification }

        ToggleAutoPlay ->
          { model | useAutoPlay = not model.useAutoPlay }

        ToggleLocation ->
          { model | useLocation = not model.useLocation }


-- View
view: Model -> Html Msg
view model =
    fieldset []
        [
        checkbox ToggleNotification "Notification"
        , checkbox ToggleAutoPlay "AutoPlay"
        , checkbox ToggleLocation "Location"
        ]

checkbox : Msg -> String -> Html Msg
checkbox msg name =
  label []
    [ input [ type_ "checkbox", onClick msg ] []
    , text name
    ]
