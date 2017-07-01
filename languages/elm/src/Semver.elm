module Versions exposing (Semver)

-- Public


type Semver string
    = Semver string


fromString : string -> Maybe Semver
fromString =
    String.split "."
        |> String.toInt
