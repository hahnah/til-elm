module Main exposing (main)

import Channel exposing (Channel)
import Element exposing (Element, alignBottom, alignLeft, alignTop, column, el, fill, height, layout, none, paddingXY, px, rgb, row, spacing, spacingXY, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias ChatMessage =
    { speaker : String
    , message : String
    }


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
        [ alignLeft
        , height fill
        , Background.color <| rgb 0.8 0.3 0.6
        , Font.color (rgb 1 1 1)
        ]
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
        , height fill
        , paddingXY 20 5
        ]
        [ viewChatHeader channel
        , viewChatBody channel
        , viewChatFooter channel
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
    let
        chatLog : List ChatMessage
        chatLog =
            [ ChatMessage "hahnah" "testestest"
            , ChatMessage "hahnah" "Let's talk about Elm events!"
            , ChatMessage "whoami" "Yoooooooooooooooo Hoooooooooooooooo"
            , ChatMessage "hoge" "hoge hoge"
            , ChatMessage "elmo" "CSS and HTML are actually quite difficult to use when you're trying to do the layout and styling of a web page. This library is a complete alternative to HTML and CSS. Basically you can just write your app using this library and (mostly) never have to think about HTML and CSS again. The high level goal of this library is to be a design toolkit that draws inspiration from the domains of design, layout, and typography, as opposed to drawing from the ideas as implemented in CSS and HTML."
            ]
    in
    column
        [ spacing 10, Element.clipX, width fill ]
        (List.map viewChatMessage chatLog)


viewChatMessage : ChatMessage -> Element msg
viewChatMessage chatMessage =
    column
        [ spacing 3 ]
        [ el [ Font.bold ] <| text chatMessage.speaker
        , Element.paragraph [] [ el [] <| text chatMessage.message ]
        ]


viewChatFooter : Channel -> Element msg
viewChatFooter channel =
    el
        [ alignBottom
        , width fill
        , height <| px 30
        , paddingXY 5 5
        , Border.width 2
        , Border.rounded 8
        , Border.color <| rgb 0.8 0.8 0.8
        , Font.color <| rgb 0.8 0.8 0.8
        , Font.size 15
        ]
        (text <| "Type message to  " ++ Channel.toString channel)
