import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex exposing (contains, regex)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- Model

type alias Model =
    { name: String
    , password: String
    , passwordAgain: String
    , submitPressed: Bool
    }

model: Model
model =
    Model "" "" "" False

-- Update

type Msg =
    Name String
    | Password String
    | PasswordAgain String
    | Submit

update: Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Submit ->
            { model | submitPressed = True }

-- View

view: Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Password again", onInput PasswordAgain ] []
        , div [] []
        , input [ type_ "submit", onClick Submit ] []
        , viewValidation model
        ]

viewValidation: Model -> Html Msg
viewValidation model =
    if model.submitPressed then
        let
            (color, message) =
                if (String.length model.password <= 8) then
                    ("red", "Password length should be over 8")
                else if not (Regex.contains (regex "[a-z]+") model.password)
                || not (Regex.contains (regex "[A-Z]+") model.password)
                || not (Regex.contains (regex "\\d+") model.password) then
                    ("red", "Password should have at least one lowercase, uppercase, and a digit")
                else if (model.password /= model.passwordAgain) then
                    ("red", "Passwords don't match")
                else
                    ("green", "OK")
        in
            div [ style [("color", color)] ] [ text message ]
    else
        div [] []
