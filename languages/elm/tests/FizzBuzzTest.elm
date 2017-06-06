module FizzBuzzTest exposing (..)

import ElmTest.Extra exposing (..)
import Expect


---

import FizzBuzz exposing (..)


all : Test
all =
    describe "FizzBuzz"
        [ describe "Returns a list of incrementing numbers"
            [ test "number" <|
                \() ->
                    List.take 2 FizzBuzz.go |> Expect.equal [ "1", "2" ]
            ]
        , describe "fizz - division"
            [ test "Instead of 3 returns 'fizz'" <|
                \() ->
                    let
                        thirdItem =
                            List.take 1 <| List.drop 2 FizzBuzz.go
                    in
                        thirdItem |> Expect.equal [ "fizz" ]
            , test "Instead of 6 returns 'fizz'" <|
                \() ->
                    let
                        thirdItem =
                            List.take 1 <| List.drop 5 FizzBuzz.go
                    in
                        thirdItem |> Expect.equal [ "fizz" ]
            ]
        , describe "fizz - contains"
            [ test "Instead of 13 returns 'fizz'" <|
                \() ->
                    let
                        thirdItem =
                            List.take 1 <| List.drop 12 FizzBuzz.go
                    in
                        thirdItem |> Expect.equal [ "fizz" ]
            ]
        , describe "buzz"
            [ test "Instead of 5 returns 'buzz'" <|
                \() ->
                    let
                        thirdItem =
                            List.take 1 <| List.drop 4 FizzBuzz.go
                    in
                        thirdItem |> Expect.equal [ "buzz" ]
            ]
        , describe "fizzbuzz"
            [ test "Instead of 15 returns 'fizzbuzz'" <|
                \() ->
                    let
                        thirdItem =
                            List.take 1 <| List.drop 14 FizzBuzz.go
                    in
                        thirdItem |> Expect.equal [ "fizzbuzz" ]
            ]
        ]
