module RomanConverterTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect
import Maybe exposing (withDefault)


---

import RomanConverter exposing (..)


all : Test
all =
    describe "Roman Converter"
        [ testToRoman ]


testToRoman : Test
testToRoman =
    describe "Converts Arabic to Roman numerals"
        [ singleNumeral
        , multipleOfSame
        , complex
        ]


singleNumeral : Test
singleNumeral =
    describe "Single numeral"
        [ test "1 to I" <|
            \() ->
                toRoman 1 |> withDefault "" |> Expect.equal "I"
        , test "5 to V" <|
            \() ->
                toRoman 5 |> withDefault "" |> Expect.equal "V"
        , test "10 to X" <|
            \() ->
                toRoman 10 |> withDefault "" |> Expect.equal "X"
        , test "50 to L" <|
            \() ->
                toRoman 50 |> withDefault "" |> Expect.equal "L"
        , test "100 to C" <|
            \() ->
                toRoman 100 |> withDefault "" |> Expect.equal "C"
        , test "500 to D" <|
            \() ->
                toRoman 500 |> withDefault "" |> Expect.equal "D"
        , test "1000 to M" <|
            \() ->
                toRoman 1000 |> withDefault "" |> Expect.equal "M"
        ]


multipleOfSame : Test
multipleOfSame =
    describe "Multiple of same numeral"
        [ test "2 to II" <|
            \() ->
                toRoman 2 |> withDefault "" |> Expect.equal "II"
        ]


complex : Test
complex =
    describe "Complicate examples"
        [ test "1999 to MCMXCIX" <|
            \() ->
                toRoman 1999 |> withDefault "" |> Expect.equal "MCMXCIX"
        , test "0 to Nothing" <|
            \() ->
                toRoman 0 |> Expect.equal Nothing
        , test "5000 to Nothing" <|
            \() ->
                toRoman 5000 |> Expect.equal Nothing
        ]
