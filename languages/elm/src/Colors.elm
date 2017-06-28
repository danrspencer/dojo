module Colors exposing (decToHex, hexToDec, hexColorToDecColor, colorName)

import Maybe exposing (withDefault)
import Char exposing (toCode, fromCode)
import String exposing (fromChar)


-- Public


decToHex : Int -> String
decToHex dec =
    let
        powerOf =
            dec // 16

        remainder =
            dec - 16 * powerOf
    in
        if powerOf >= 1 then
            (decToHex powerOf) ++ (decToHex remainder)
        else if dec >= 10 then
            incrementChar 'a' (dec - 10) |> fromChar
        else
            toString dec


hexToDec : String -> Maybe Int
hexToDec hex =
    String.split "" hex
        |> List.map hexCharToDec
        |> maybeList
        |> Maybe.map (sumBaseDigits 16)


hexColorToDecColor : String -> Maybe ( Int, Int, Int )
hexColorToDecColor hexColor =
    ( colorIndexToDec 0 hexColor
    , colorIndexToDec 1 hexColor
    , colorIndexToDec 2 hexColor
    )
        |> maybeTuple3


colorName : List ( String, String ) -> String -> Maybe String
colorName colorList colorHash =
    let
        matchesHash =
            Tuple.first >> (==) colorHash

        getDistance =
            hexColorDistance colorHash

        applyDistance ( h, n ) =
            ( Just h, Just n, getDistance h ) |> maybeTuple3

        distance ( h, n, d ) =
            d

        name ( h, n, d ) =
            n
    in
        List.map applyDistance colorList
            |> maybeList
            |> Maybe.andThen (List.sortBy distance >> List.head)
            |> Maybe.map name



-- Private


colorIndexToDec : Int -> String -> Maybe Int
colorIndexToDec index hexColor =
    let
        start =
            index * 2

        end =
            start + 2
    in
        String.slice start end hexColor |> hexToDec


hexCharToDec : String -> Maybe Int
hexCharToDec hex =
    case hex of
        "a" ->
            Just 10

        "b" ->
            Just 11

        "c" ->
            Just 12

        "d" ->
            Just 13

        "e" ->
            Just 14

        "f" ->
            Just 15

        _ ->
            String.toInt hex |> Result.toMaybe


hexColorDistance : String -> String -> Maybe Int
hexColorDistance a b =
    ( hexColorToDecColor a, hexColorToDecColor b )
        |> \( a, b ) -> Maybe.map2 rgbColorDistance a b


rgbColorDistance : ( Int, Int, Int ) -> ( Int, Int, Int ) -> Int
rgbColorDistance ( r1, b1, g1 ) ( r2, b2, g2 ) =
    abs (r1 - r2) + abs (b1 - b2) + abs (g1 - g2)


sumBaseDigits : Int -> List Int -> Int
sumBaseDigits base =
    Tuple.second << List.foldr (\v ( p, a ) -> ( p * base, a + p * v )) ( 1, 0 )


maybeTuple3 : ( Maybe a, Maybe b, Maybe c ) -> Maybe ( a, b, c )
maybeTuple3 ( a, b, c ) =
    Maybe.map3 (,,) a b c


maybeList : List (Maybe a) -> Maybe (List a)
maybeList =
    List.foldr (Maybe.map2 (::)) (Just [])


incrementChar : Char -> Int -> Char
incrementChar char int =
    (toCode char) + int |> fromCode
