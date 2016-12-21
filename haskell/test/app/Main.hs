module Main where

import Lib
import Safe (readMay)
import Control.Applicative ((<*>), Applicative)
import Prelude (return, Monad)
import qualified Prelude

fmap :: (Applicative m, Monad m) => (a -> b) -> (m a -> m b)
fmap f ma = return f <*> ma

main =
  case fmap (Prelude.+ 1) (Prelude.Just 2) of
    Prelude.Just 3 -> Prelude.putStrLn "good job"
    _ -> Prelude.putStrLn "try again"



-- displayAge maybeAge =
--   case maybeAge of
--     Nothing -> putStrLn "You provided an invalid year"
--     Just age -> putStrLn $ "In 2020, you will be: " ++ show age

-- yearToAge year = 2020 - year


-- main :: IO ()
-- main = do
--   putStrLn "Please enter your birth year"
--   yearStr <- getLine
--   putStrLn "Please enter some year future"
--   futureYearStr <- getLine
--   let maybeAge =
--         case (readMay yearStr :: Maybe Integer) of
--           Nothing -> Nothing
--           Just birthYear ->
--             case (readMay futureYearStr :: Maybe Integer) of
--               Nothing -> Nothing
--               Just futureYear -> Just (futureYear - birthYear)
--   displayAge maybeAge

-- main = do
--   putStrLn "Please enter your birth year"
--   yearStr <- getLine
--   putStrLn "Please enter a future year"
--   futureYearStr <- getLine
--   let maybeAge =
--         do
--           birthYear <- readMay yearStr
--           futureYear <- readMay futureYearStr
--           return $ futureYear - birthYear
--   displayAge maybeAge
--



