module SubModule exposing (..)

import Browser.Dom
import Html exposing (Html, input)
import Html.Attributes exposing (id)
import Task


type alias Model =
    {}


type Msg
    = FocusWasSet (Result Browser.Dom.Error ())


init : ( Model, Cmd Msg )
init =
    ( {}
    , Task.attempt FocusWasSet (Browser.Dom.focus inputId)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


inputId =
    "inputId"


view : Html Msg
view =
    input [ id inputId ] []
