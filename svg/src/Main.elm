module Main exposing (main)

import Browser
import Html exposing (Html, div, img)
import Html.Attributes exposing (src, style, width)
-- import Svg exposing (Svg)
-- import Svg.Attributes exposing (fill)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = None


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div []
        [ img
            [ src "../assets/color-stew.svg"
            , width 300
            , style "background-color" "#bbefef"
            ]
            []
        ]
