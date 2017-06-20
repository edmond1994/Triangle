-- Read all about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/forms.html


--was modified
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , lastName : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | LastName String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    LastName name ->
      { model | lastName = name }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type_ "text", placeholder "Last Name", onInput LastName ] []
    , viewValidation model
    , viewValidation1 model
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "Passwords OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text <| (String.concat ["Val1: ", message]) ] --using a pipe


viewValidation1 : Model -> Html msg
viewValidation1 model =
  let
    (color, message) =
      if (String.length model.lastName <= 8) then
        ("green", "Last Name OK")
      else
        ("red", "Last Name too long!")
  in
    div [ style [("color", color)] ] [ text <| (String.concat ["Val2: ", message]) ] --using a pipe

