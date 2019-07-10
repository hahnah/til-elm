module Main exposing (main)

import Channel exposing (Channel)
import Element exposing (Element, alignLeft, alignTop, column, el, fill, height, layout, paddingXY, rgb, row, spacingXY, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)


main : Html msg
main =
    let
        selectedChannel : Channel
        selectedChannel =
            Channel.fromString "events"

        channels : List Channel
        channels =
            [ Channel.fromString "beginners"
            , selectedChannel
            , Channel.fromString "general"
            , Channel.fromString "questions"
            , Channel.fromString "town-square"
            ]
    in
    layout [] <|
        row [ width fill, height fill ]
            [ viewChannels channels
            , viewChat selectedChannel
            ]


viewChannels : List Channel -> Element msg
viewChannels channels =
    let
        channelSelection : List Bool
        channelSelection =
            [ False, True, False, False, False ]
    in
    column
        [ alignLeft, height fill, Background.color (rgb 0.8 0.3 0.6), Font.color (rgb 1 1 1) ]
        (List.map2 viewChannel channels channelSelection)


viewChannel : Channel -> Bool -> Element msg
viewChannel channel isSelected =
    if isSelected then
        el
            [ Background.color (rgb 0.1 0.7 0.8)
            , paddingXY 15 5
            , width fill
            ]
            (text <| Channel.toString channel)

    else
        el [ paddingXY 15 5 ] <| text (Channel.toString channel)


viewChat : Channel -> Element msg
viewChat channel =
    column
        [ alignTop
        , width fill
        ]
        [ viewChatHeader channel
        , viewChatBody channel
        , viewChatFooter
        ]


viewChatHeader : Channel -> Element mag
viewChatHeader channel =
    el
        [ paddingXY 20 5
        , width fill
        , Font.bold
        , Border.widthEach { bottom = 3, left = 0, right = 0, top = 0 }
        , Border.color <| rgb 0.8 0.8 0.8
        ]
        (text <| Channel.toString channel)


viewChatBody : Channel -> Element msg
viewChatBody channel =
    Debug.todo "Chat Message"


viewChatFooter : Element msg
viewChatFooter =
    Debug.todo "Add input"
