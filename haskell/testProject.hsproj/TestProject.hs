{-# LANGUAGE OverloadedStrings #-}


import Data.Monoid (mconcat)
import Data.Maybe
import Data.Functor.Identity

main = print $ mconcat ["1", "2", "3"]



data Morse = Morse Char deriving (Show)

charToMorse :: Char -> Maybe Morse
charToMorse c =  case c of
  'a' -> Nothing
  'b' -> Nothing
  'c' -> Nothing
  _ -> Just $ Morse c
  

stringToMorse :: String -> Maybe [Morse]
stringToMorse s = sequence $ fmap charToMorse s



next :: Eq a => a -> [a] -> Maybe a
next item [] = Nothing
next item (x:[]) = Nothing
next item (x:y:xs) = 
  if (item == x)
    then Just y
    else next item (y:xs)


---------------------
