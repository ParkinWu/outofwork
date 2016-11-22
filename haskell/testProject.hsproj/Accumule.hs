module Accumule where

import Data.Char
import Data.List

accum :: [Char] -> [Char]
accum [] = []
accum s = intercalate "-" $ map (capitalized . repeatIt) (zip s [1..])

repeatIt :: (Char, Int) -> String
repeatIt p = take (snd p) $ repeat (fst p)

capitalized :: [Char] -> [Char]
capitalized [] = []
capitalized (head:tail) = (toUpper head) : (map toLower tail)

