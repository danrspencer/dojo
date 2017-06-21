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


hexColourToDecColourTests : Test
hexColourToDecColourTests =
    describe "hexColourToDec"
        [ test "Converts ff8212 to [ 255, 130, 18 ]" <|
            \() ->
                Expect.equal (hexColourToDecColour "ff8212" |> withDefault ( 0, 0, 0 )) ( 255, 130, 18 )
        ]
