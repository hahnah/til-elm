import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import List
import Maybe
import Svg exposing (svg, circle)
import Svg.Attributes exposing (viewBox, width, cx, cy, r, fill, fillOpacity, stroke, strokeWidth, strokeDashoffset, strokeDasharray)


-- MODEL

type alias Model =
  { items: List Item
  , colors: List Color
  }

init : Model
init =
  let
    items =
      [ Item 34
      , Item 21
      , Item 13
      , Item 8
      , Item 5
      , Item 3
      , Item 2
      , Item 1
      , Item 1
      ]
    colors =
      [ "#ff7f7f"
      , "#bf7fff"
      , "#bfff7f"
      , "#7fffff"
      , "#ff7fbf"
      , "#7f7fff"
      , "#ffff7f"
      , "#ff7fff"
      , "#ffbf7f"
      ]
  in
    Model items colors

type alias Item =
  { count: Int }

type alias Color =
  String

type alias FanShape =
  { offset: Float
  , percentage: Float
  , color: Color
  }


-- MSG

type Msg = NoMsg


-- UPDATE

update : Msg -> Model -> Model
update message model = model

-- VIEW

view : Model -> Html Msg
view model =
  div [] [ viewPieChart model.items model.colors ]

viewPieChart : List Item -> List Color -> Html Msg
viewPieChart items colors =
  let
    counts = List.map (\item -> toFloat item.count) items
    total = List.sum counts
    percentages = List.map (\count -> 100.0 * count / total) counts
    offsets = List.foldl (\percentage acc -> List.append acc [(Maybe.withDefault 0.0 <| List.maximum acc) + percentage]) [0.0] percentages
    fanShapes = List.map3 (\offset percentage color -> FanShape offset percentage color) offsets percentages colors
  in
    svg
      [ viewBox "0 0 63.6619772368 63.6619772368" , width "300px" ]
      (List.map (\fanShape -> viewFanShape fanShape) fanShapes)
      
viewFanShape : FanShape -> Html Msg
viewFanShape fanShape =
  let
    strokeDashoffset_ = String.fromFloat <| 25.0 - fanShape.offset
    strokeDasharray_ = String.fromFloat fanShape.percentage ++ " " ++ (String.fromFloat <| 100.0 - fanShape.percentage)
  in
    circle
      [ cx "31.8309886184", cy "31.8309886184", r "15.9154943092"
      , fill "#ffffff", fillOpacity "0.0"
      , stroke fanShape.color, strokeWidth "31.8309886184", strokeDashoffset strokeDashoffset_, strokeDasharray strokeDasharray_ ]
      []
 
 -- MAIN

main =
  Browser.sandbox
    { init = init
    , update = update
    , view = view
    }
