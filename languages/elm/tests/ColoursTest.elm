module ColoursTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect
import Maybe exposing (withDefault)


---

import Colours exposing (..)


all : Test
all =
    describe "Colour"
        [ hexToDecTests
        , decToHexTests
        , hexColourToDecColourTests
        ]


hexToDecTests : Test
hexToDecTests =
    describe "hexToDec"
        [ test "Converts 5 directly" <|
            \() ->
                hexToDec "5" |> withDefault 0 |> Expect.equal 5
        , test "Converts a to 10" <|
            \() ->
                hexToDec "a" |> withDefault 0 |> Expect.equal 10
        , test "Converts b to 11" <|
            \() ->
                hexToDec "b" |> withDefault 0 |> Expect.equal 11
        , test "Converts c to 12" <|
            \() ->
                hexToDec "c" |> withDefault 0 |> Expect.equal 12
        , test "Converts d to 13" <|
            \() ->
                hexToDec "d" |> withDefault 0 |> Expect.equal 13
        , test "Converts e to 14" <|
            \() ->
                hexToDec "e" |> withDefault 0 |> Expect.equal 14
        , test "Converts f to 15" <|
            \() ->
                hexToDec "f" |> withDefault 0 |> Expect.equal 15
        , test "Converts g to nothing" <|
            \() ->
                hexToDec "g" |> Expect.equal Nothing
        , test "Converts 10 to 16" <|
            \() ->
                hexToDec "10" |> withDefault 0 |> Expect.equal 16
        , test "Converts 82 to 130" <|
            \() ->
                hexToDec "82" |> withDefault 0 |> Expect.equal 130
        , test "Converts fedcba987654321 to 1147797409030816545" <|
            \() ->
                hexToDec "fedcba987654321" |> withDefault 0 |> Expect.equal 1147797409030816545
        ]


decToHexTests : Test
decToHexTests =
    describe "decToHex"
        [ test "Converts 0 .. 9 directly" <|
            \() ->
                let
                    input =
                        List.range 0 9

                    expected =
                        List.map toString input
                in
                    List.map decToHex input |> Expect.equal expected
        , test "Converts 10 .. 15 to [ a, b, c, d, e, f ]" <|
            \() ->
                let
                    input =
                        List.range 10 15
                in
                    List.map decToHex input |> Expect.equal aToF
        , test "Converts 16 .. 31 to 10 .. 1f" <|
            \() ->
                let
                    input =
                        List.range 16 31
                in
                    List.map decToHex input |> Expect.equal (hexRange "1")
        , test "Converts 32 .. 47 to 20 .. 2f" <|
            \() ->
                let
                    input =
                        List.range 32 47
                in
                    List.map decToHex input |> Expect.equal (hexRange "2")
        , test "Converts 240 .. 255 to f0 .. f1" <|
            \() ->
                let
                    input =
                        List.range 240 255
                in
                    List.map decToHex input |> Expect.equal (hexRange "f")
        , test "Converts 256 .. 4095 to 100 .. fff" <|
            \() ->
                let
                    input =
                        List.range 256 4095

                    expected =
                        hexRange ""
                            |> List.concatMap hexRange
                            |> List.concatMap hexRange
                            |> List.filter (not << String.startsWith "0")
                in
                    List.map decToHex input |> Expect.equal expected
        , test "Converts 1836536483 to 6d7752a3" <|
            \() ->
                decToHex 1836536483 |> Expect.equal "6d7752a3"
        ]


hexColourToDecColourTests : Test
hexColourToDecColourTests =
    describe "hexColourToDec"
        [ test "Converts ff8212 to [ 255, 130, 18 ]" <|
            \() ->
                Expect.equal (hexColourToDecColour "ff8212" |> withDefault ( 0, 0, 0 )) ( 255, 130, 18 )
        ]


aToF : List String
aToF =
    [ "a", "b", "c", "d", "e", "f" ]


hexRange : String -> List String
hexRange prefix =
    let
        applyPrefix =
            (++) prefix

        numeric =
            List.range 0 9 |> List.map toString |> List.map applyPrefix

        alphaNumeric =
            List.map applyPrefix aToF
    in
        numeric ++ alphaNumeric
