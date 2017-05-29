module SampleTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect


---

import Sample exposing (..)


all : Test
all =
    describe "Sample Test Suite"
        [ describe "Unit test examples"
            [ test "The Kata" <|
                \() ->
                    Sample.sum 1 2 |> Expect.equal 3
            ]
        ]
