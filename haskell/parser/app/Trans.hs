{-# LANGUAGE OverloadedStrings #-}
module Trans where

import Data.Text
import Data.Text.IO as T

data LoginError = InvaildEmail | NoSuchUser | InvaildPassword
main :: IO ()
main = do
  T.putStrLn "please enter email"
  email <- T.getLine
  T.putStrLn email
  case getToken email of
    Left _ -> T.putStrLn "incorrect email"
    Right username -> case lookup username users of
                        Nothing -> T.putStrLn "No such user"
                        Just password -> do
                          T.putStrLn "please enter your password"
                          passwd <- T.getLine
                          if passwd == password
                             then T.putStrLn $ "Login success! hello " `mappend` username
                             else T.putStrLn "incorrect password"

getPassword :: Text -> Maybe Text
getPassword username = lookup username

getToken :: Text -> Either LoginError Text
getToken email =
  case splitOn "@" email of
    [userName, domain] -> Right userName
    _ -> Left InvaildEmail

users :: [(Text, Text)]
users = [("example", "qwerty123"), ("pzwu", "popopo")]


