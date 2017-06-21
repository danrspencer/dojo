module Colours exposing (hexToDec, hexColourToDecColour)

import Maybe exposing (withDefault)


hexToDec : String -> Maybe Int
hexToDec hex =
    String.split "" hex
        |> List.map hexCharToDec
        |> \decimals ->
            if List.any isNothing decimals then
                Nothing
            else
                List.map (withDefault 0) decimals
                    |> List.reverse
                    |> List.indexedMap toActualValue
                    |> List.sum
                    |> Just


hexColourToDecColour : String -> Maybe ( Int, Int, Int )
hexColourToDecColour hexColour =
    ( colourIndexToDec 0 hexColour
    , colourIndexToDec 1 hexColour
    , colourIndexToDec 2 hexColour
    )
        |> tupleOfMaybesToMaybeTuple


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


toActualValue : Int -> Int -> Int
toActualValue index value =
    case index of
        0 ->
            value

        _ ->
            16 ^ index * value


isNothing : Maybe Int -> Bool
isNothing value =
    case value of
        Just value ->
            False

        Nothing ->
            True


tupleOfMaybesToMaybeTuple : ( Maybe a, Maybe b, Maybe c ) -> Maybe ( a, b, c )
tupleOfMaybesToMaybeTuple tuple =
    case tuple of
        ( Just a, Just b, Just c ) ->
            Just ( a, b, c )

        _ ->
            Nothing
