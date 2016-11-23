module Realworld where
  
import SimpleJSON
import Prettify
import PrettyJSON

main = print $ pretty 20 (renderJValue (JObject [("name",  JString "pzwu"), ("age", JNumber 25), ("age1", JNumber 25), ("age2", JNumber 25)]))

