import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second, minute, hour)
import Debug exposing (log)

main = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model
type alias Model = Time

init: (Model, Cmd Msg)
init =
    (0, Cmd.none)

-- Update
type Msg = Tick Time

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick newTime ->
            (newTime, Cmd.none)

-- Subs
subscriptions: Model -> Sub Msg
subscriptions model =
    Time.every second Tick

-- View
view: Model -> Html Msg
view model =
    let
        inMinutes = Time.inMinutes model
        angle =
            turns inMinutes - pi / 2

        inHours = Time.inHours model
        minuteAngle =
            turns inHours - pi / 2

        hourAngle =
            turns (inHours / 24)

    in
        svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", y1 "50", x2 (getHandX angle), y2 (getHandY angle), stroke "#023963"
            , strokeWidth "1"] []
            , line [ x1 "50", y1 "50", x2 (getHandX minuteAngle), y2 (getHandY minuteAngle), stroke "#023963"
            , strokeWidth "2"] []
            , line [ x1 "50", y1 "50", x2 (getHandX hourAngle), y2 (getHandY hourAngle), stroke "#023963"
            , strokeWidth "3"] []
            ]

getHandX: Float -> String
getHandX angle =
    let
        res = toString (50 + 40 * cos angle)
        a = Debug.log res ""
    in
        res

getHandY: Float -> String
getHandY angle =
    toString (50 + 40 * sin angle)
