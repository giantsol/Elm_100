import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, on, keyCode)
import Http
import Json.Decode as Decode

main =
    Html.program {
    init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias Model =
    {
    topic: String
    , gifUrl: String
    , isLoading: Bool
    }

-- Init
init: (Model, Cmd Msg)
init =
    (Model "" "" False, Cmd.none)

-- Update
type Msg =
    Topic String
    | MorePlease
    | NewGif (Result Http.Error String)
    | KeyDown Int

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Topic topic ->
            ( { model | topic = topic }, Cmd.none )
        MorePlease ->
            ({model | isLoading = True}, getRandomGif model.topic)

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl, isLoading = False }, Cmd.none )

        NewGif (Err _) ->
            ({model | isLoading = False}, Cmd.none)

        KeyDown key ->
            if key == 13 then
                update MorePlease model
            else
                (model, Cmd.none)

getRandomGif: String -> Cmd Msg
getRandomGif topic =
    let
        url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
        request = Http.get url decodeGifUrl
    in
        Http.send NewGif request

decodeGifUrl: Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string


-- View
view: Model -> Html Msg
view model =
    div []
        [ text "Topic: "
        , input [ type_ "text", placeholder "Type in topic", onInput Topic, onKeyDown KeyDown ] []
        , div [] []
        , resultView model
        , div [] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        ]

onKeyDown: (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Decode.map tagger keyCode)

resultView: Model -> Html Msg
resultView model =
    if model.isLoading then
        text "loading...."
    else
        img [src model.gifUrl] []


-- Sub
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
