module VersionsTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect
import Maybe exposing (withDefault)
import String exposing (concat)


---

import Versions exposing (..)


all : Test
all =
    describe "Versions"
        [ fromStringTest
        ]


fromStringTest : Test
fromStringTest =
    describe "fromString"
        [ test "0.0.1" <|
            \() ->
                hexToDec "a" |> withDefault 0 |> Expect.equal 10
        ]
