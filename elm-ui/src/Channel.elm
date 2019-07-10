module Channel exposing (Channel, fromString, toString)


type Channel
    = Channel String


fromString : String -> Channel
fromString channelName =
    Channel ("# " ++ channelName)


toString : Channel -> String
toString (Channel channelName) =
    channelName
