{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text
import qualified Data.Text.IO as T
import Data.Map as Map
import Control.Applicative

data EitherIO e a = EitherIO {
  runEitherIO :: IO (Either e a)
}

instance Functor (EitherIO e) where
  fmap f = EitherIO . fmap (fmap f) . runEitherIO

instance Applicative (EitherIO e) where
  pure = EitherIO . return . Right
  f <*> ex = EitherIO $ liftA2 (<*>) (runEitherIO f) (runEitherIO ex)

instance Monad (EitherIO e) where
  return = pure
  x >>= f = EitherIO $ runEitherIO x >>= either (return . Left) (runEitherIO . f)


data LoginError = InvaildEmail
                | NoSuchUser
                | WrongPassword
                deriving Show

getDomain email =
  case splitOn "@" email of
    [name, domain] -> Right domain
    _ -> Left InvaildEmail


userLogin ::  EitherIO LoginError Text
userLogin = do
  token <- getToken
  userpw <- maybe (liftEither (Left NoSuchUser)) return (Map.lookup token users)
  passwd <- liftIO (T.putStrLn "Enther password: " >> T.getLine)
  if userpw == passwd
     then return token
     else liftEither (Left WrongPassword)


printResult :: Either LoginError Text -> IO ()
printResult res =
  T.putStrLn $ case res of
                 Right token -> append "Logged in with token: " token
                 Left InvaildEmail -> "InvalidEmail"
                 Left NoSuchUser -> "No such user"
                 Left WrongPassword -> "Wrong password"

getToken :: EitherIO LoginError Text
getToken = do
  liftIO (T.putStrLn "Enter email address")
  input <- liftIO T.getLine
  liftEither (getDomain input)

liftEither :: Either e a -> EitherIO e a
liftEither x = EitherIO (return x)

liftIO :: IO a -> EitherIO e a
liftIO x = EitherIO (fmap Right x)

main :: IO ()
main = putStrLn "Hello world"

users :: Map Text Text
users = Map.fromList [("example@ctrip.com", "ques123"), ("localhost@qq.com", "ab"), ("test", "123")]
