module RomanConverter exposing (toRoman)


type alias Conversion =
    ( Int, String )


arabic : Conversion -> Int
arabic ( a, r ) =
    a


roman : Conversion -> String
roman ( a, r ) =
    r


conversions : List Conversion
conversions =
    List.reverse
        [ ( 1, "I" )
        , ( 4, "IV" )
        , ( 5, "V" )
        , ( 9, "IX" )
        , ( 10, "X" )
        , ( 40, "XL" )
        , ( 50, "L" )
        , ( 90, "XC" )
        , ( 100, "C" )
        , ( 400, "CD" )
        , ( 500, "D" )
        , ( 900, "CM" )
        , ( 1000, "M" )
        ]


toRoman : Int -> Maybe String
toRoman number =
    case getConversion number of
        Just conversion ->
            Maybe.map
                ((++) <| roman conversion)
                (nextNumeral <| number - arabic conversion)

        Nothing ->
            Nothing


nextNumeral : Int -> Maybe String
nextNumeral number =
    if (number == 0) then
        Just ""
    else
        toRoman number


getConversion : Int -> Maybe Conversion
getConversion number =
    conversions |> List.filter (greaterThan number) |> List.head


greaterThan : Int -> Conversion -> Bool
greaterThan number conversion =
    number >= (arabic conversion)
