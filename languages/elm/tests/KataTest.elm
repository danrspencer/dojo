module KataTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect


---

import Kata exposing (..)


all : Test
all =
    describe "Sample Test Suite"
        [ describe "Unit test examples"
            [ test "The Kata" <|
                \() ->
                    Kata.sum 1 2 |> Expect.equal 3
            ]
        ]
