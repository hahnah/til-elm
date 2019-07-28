module Main exposing (Item, Model, Msg(..), dndSystem, ghostView, init, itemView, main, subscriptions, update, view)

import Browser
import DnDList
import Html
import Html.Attributes


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Item =
    String


type alias Model =
    { items : List Item
    , dnd : DnDList.Model
    }


dndSystem : DnDList.System Item Msg
dndSystem =
    let
        dndConfig : DnDList.Config Item
        dndConfig =
            { beforeUpdate = \_ _ list -> list
            , movement = DnDList.Free
            , listen = DnDList.OnDrag
            , operation = DnDList.Rotate
            }
    in
    DnDList.create dndConfig MyMessage


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model [ "Aaaaa", "Bbbbb", "Ccccc", "Ddddd", "Eeeee" ] dndSystem.model
    , Cmd.none
    )


type Msg
    = MyMessage DnDList.Msg


subscriptions : Model -> Sub Msg
subscriptions model =
    dndSystem.subscriptions model.dnd


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        MyMessage dndMsg ->
            let
                ( dnd, items ) =
                    dndSystem.update dndMsg model.dnd model.items
            in
            ( { model | items = items, dnd = dnd }
            , dndSystem.commands model.dnd
            )


view : Model -> Html.Html Msg
view model =
    Html.section
        [ Html.Attributes.style "text-align" "center" ]
        [ model.items
            |> List.indexedMap (itemView model.dnd)
            |> Html.div []
        , ghostView model.dnd model.items
        ]


itemView : DnDList.Model -> Int -> Item -> Html.Html Msg
itemView dndModel index item =
    let
        itemId : String
        itemId =
            "id-" ++ item
    in
    case dndSystem.info dndModel of
        Just { dragIndex } ->
            if dragIndex /= index then
                Html.p
                    (Html.Attributes.id itemId :: dndSystem.dropEvents index itemId)
                    [ Html.text item ]

            else
                Html.p
                    [ Html.Attributes.id itemId
                    , Html.Attributes.style "color" "lightgray"
                    ]
                    [ Html.text item ]

        Nothing ->
            Html.p
                (Html.Attributes.id itemId :: dndSystem.dragEvents index itemId)
                [ Html.text item ]


ghostView : DnDList.Model -> List Item -> Html.Html Msg
ghostView dnd items =
    let
        maybeDragItem : Maybe Item
        maybeDragItem =
            dndSystem.info dnd
                |> Maybe.andThen (\{ dragIndex } -> items |> List.drop dragIndex |> List.head)
    in
    case maybeDragItem of
        Just item ->
            Html.div
                (dndSystem.ghostStyles dnd)
                [ Html.text item ]

        Nothing ->
            Html.text ""
