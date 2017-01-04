module Main where
import           Control.Applicative
import           Control.Monad
import           Data.Either         (either)
import           Data.List
import           Lib (someFunc)
import Lib (someFunc)
import Debug.Trace


main :: IO ()
main = someFunc

quicksort [] = []
quicksort (x:xs) = left xs ++ [x] ++ right xs
  where left xs = quicksort $ filter (< x) xs
        right xs = quicksort $ filter (>= x) xs



