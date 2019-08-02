port module Main exposing (init)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd msg )
init _ =
    ( {}
    , Cmd.none
    )


type alias Model =
    {}


type Msg
    = CopyInput String
    | CopyString String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CopyInput id ->
            ( model, copyInput id )

        CopyString str ->
            ( model, copyString str )


port copyInput : String -> Cmd msg


port copyString : String -> Cmd msg


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ Html.input [ id "copy", Html.Attributes.value "This is input value." ] []
            , Html.button [ onClick <| CopyInput "#copy" ] [ text "CopyInput" ]
            ]
        , div []
            [ Html.button [ onClick <| CopyString "You can copy any string!" ] [ text "CopyString" ] ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
