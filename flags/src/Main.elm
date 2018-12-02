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

-- INIT

init : Flags -> ( Model, Cmd msg )
init flags =
  ( { greeting = flags.greeting
    , times = flags.times
    }
  , Cmd.none
  )

type alias Flags =
  { greeting : String
  , times : Int
  }

-----


type alias Model =
  { greeting : String
  , times : Int
  }

type Msg
  = NoMessage

update : Msg -> Model -> ( Model, Cmd msg)
update msg model =
  ( model, Cmd.none)

view : Model -> Html Msg
view model =
  div [] <|
    List.repeat model.times <| div [] [ text model.greeting ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none