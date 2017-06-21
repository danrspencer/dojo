module SampleTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect


---

import Sample exposing (..)

o : Bool
o = True

x : Bool
x = False


all : Test
all =
    describe "Game of Life"
        [ test "If all cells are dead they stay dead" <|
            \() ->
                let
                    input = [
                        [x, x, x, x]
                        ,[x, x, x, x]
                        ,[x, x, x, x]
                        ,[x, x, x, x]
                    ]

                    output = [
                        [x, x, x, x]
                         ,[x, x, x, x]
                         ,[x, x, x, x]
                         ,[x, x, x, x]
                     ]
                in
                    Expect.equal (nextGeneration input) output

            , test "A Single live cell dies" <|
                \() ->
                    let
                        input = [
                            [x, x, x, x]
                            ,[x, x, x, x]
                            ,[x, x, x, x]
                            ,[x, x, x, x]
                        ]


                        output = [
                            [x, x, x, x]
                             ,[x, x, x, x]
                             ,[x, x, x, x]
                             ,[x, x, x, x]
                         ]
                    in
                        Expect.equal (nextGeneration input) output
        ]