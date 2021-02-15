module Main exposing (..)

import Browser
import Effect exposing (Effect)
import Html exposing (div)
import SubModule


type alias Model =
    { subModuleModel : SubModule.Model
    , name : String
    }


type Msg
    = SubModuleMsg SubModule.Msg


main =
    Browser.element
        { init = \flags -> init flags |> Effect.perform
        , update = \msg model -> update msg model |> Effect.perform
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Effect Msg )
init () =
    let
        ( subModuleModel, subModuleEffect ) =
            SubModule.init
    in
    ( { name = ""
      , subModuleModel = subModuleModel
      }
    , Effect.map SubModuleMsg (Effect.ApplyCmd subModuleEffect)
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SubModuleMsg subModuleMsg ->
            let
                ( subModuleModel, subModuleEffect ) =
                    SubModule.update subModuleMsg model.subModuleModel
            in
            ( model
            , Effect.map SubModuleMsg (Effect.ApplyCmd subModuleEffect)
            )


view : Model -> Html.Html Msg
view model =
    SubModule.view
        |> Html.map SubModuleMsg
