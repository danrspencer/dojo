module Colours exposing (decToHex, hexToDec, hexColourToDecColour)

import Maybe exposing (withDefault)
import Char exposing (toCode, fromCode)
import String exposing (fromChar)


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
            dec - 10 |> (+) (toCode 'a') |> fromCode |> fromChar
        else
            toString dec


hexToDec : String -> Maybe Int
hexToDec hex =
    String.split "" hex
        |> List.map hexCharToDec
        |> maybeList
        |> Maybe.map (sumBaseDigits 16)


hexColourToDecColour : String -> Maybe ( Int, Int, Int )
hexColourToDecColour hexColour =
    ( colourIndexToDec 0 hexColour
    , colourIndexToDec 1 hexColour
    , colourIndexToDec 2 hexColour
    )
        |> maybeTuple3


colourIndexToDec : Int -> String -> Maybe Int
colourIndexToDec index hexColour =
    let
        start =
            index * 2

        end =
            start + 2
    in
        String.slice start end hexColour |> hexToDec


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


sumBaseDigits : Int -> List Int -> Int
sumBaseDigits base =
    Tuple.second << List.foldr (\v ( p, a ) -> ( p * base, a + p * v )) ( 1, 0 )


maybeTuple3 : ( Maybe a, Maybe b, Maybe c ) -> Maybe ( a, b, c )
maybeTuple3 ( a, b, c ) =
    Maybe.map3 (,,) a b c


maybeList : List (Maybe a) -> Maybe (List a)
maybeList =
    List.foldr (Maybe.map2 (::)) (Just [])
