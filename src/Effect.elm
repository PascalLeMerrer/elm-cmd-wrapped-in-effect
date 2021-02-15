module Effect exposing (..)


type alias Model a =
    { a | name : String }


type Effect msg
    = None
    | ApplyCmd (Cmd msg)


perform : ( Model a, Effect msg ) -> ( Model a, Cmd msg )
perform ( model, effect ) =
    case effect of
        None ->
            ( model, Cmd.none )

        ApplyCmd cmd ->
            ( model, cmd )


none : Effect msg
none =
    None


map : (a -> msg) -> Effect a -> Effect msg
map parentMsgConstructor effect =
    case effect of
        None ->
            None

        ApplyCmd cmd ->
            ApplyCmd (Cmd.map parentMsgConstructor cmd)

