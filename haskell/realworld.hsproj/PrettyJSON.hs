module PrettyJSON where
import Data.Monoid
import SimpleJSON
import Prettify


renderJValue :: JValue -> Doc
renderJValue (JString str) = string str
renderJValue (JNumber num) = double num
renderJValue (JBool True)  = text "true"
renderJValue (JBool False) = text "false"
renderJValue JNull         = text "null"
renderJValue (JArray ary)  = series '[' ']' renderJValue ary
renderJValue (JObject obj) = series '{' '}' field obj
  where field (name,val) = string name
                          <> text ": "
                          <> renderJValue val



              




















