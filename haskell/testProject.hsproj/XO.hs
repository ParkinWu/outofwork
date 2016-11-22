module XO where
  
import Data.Char

xo :: String -> Bool
xo str = (count 'x' str) == (count 'o' str)

count :: Char -> [Char] -> Int
count x xs = length (filter (== x) $ map toLower xs)


data Membership = Open | Senior deriving (Eq, Show)
openOrSenior :: [(Int, Int)] -> [Membership]
openOrSenior xs = map membership xs 
  where membership (x, y) = if (x >= 55 && y > 7) 
                            then Senior 
                            else Open 
                            

spinWords :: String -> String
spinWords str = unwords $ map someReverse (words str) 
  where someReverse s = if ((length s) >= 5) 
                        then reverse s 
                        else s
                        

triangular :: Integer -> Integer
triangular n = if n < 0 then 0 else n * (n + 1) `div` 2