module FizzBuzz exposing (go)


go : List String
go =
    List.map toFizzBuzz <| createList 1 100


toFizzBuzz : Int -> String
toFizzBuzz value =
    let
        matches =
            matchTo value
    in
        if matches 3 && matches 5 then
            "fizzbuzz"
        else if matches 3 then
            "fizz"
        else if matches 5 then
            "buzz"
        else
            toString value


matchTo : Int -> Int -> Bool
matchTo value matcher =
    let
        stringMatcher =
            toString matcher

        stringValue =
            toString value

        divisibleBy =
            value % matcher == 0

        contains =
            String.contains stringMatcher stringValue
    in
        divisibleBy || contains


createList : Int -> Int -> List Int
createList num max =
    if num < max then
        num :: createList (num + 1) max
    else
        [ num ]
