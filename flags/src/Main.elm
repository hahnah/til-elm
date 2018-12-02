import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import List

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : Int -> ( Model, Cmd msg )
init flags =
  ( { num = flags }, Cmd.none )

type alias Model =
  { num : Int }

type Msg
  = NoMessage

update : Msg -> Model -> ( Model, Cmd msg)
update msg model =
  ( model, Cmd.none)

view : Model -> Html Msg
view model =
  div [] <|
    List.repeat model.num <| div [] [ text "Hello World!" ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none