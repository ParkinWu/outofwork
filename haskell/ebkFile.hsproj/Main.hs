module Main where


import Data.List.Split
import GHC.Word
 

main = do
  content <- getContent
  mapM (\x -> putStrLn x) (zipWith com (getCol (getArr content) 0) (getCol (getArr content) 6))
  

getContent :: IO String
getContent = readFile "ebkfile.csv"

getCol :: [[String]] -> Int -> [String]
getCol arr col = map  (!! col ) arr

getArr :: String -> [[String]]
getArr content = map (splitOn ",") $ lines content


getIDCol content = getCol content 1
getZHCol content = getCol content 2
getEnCol content = getCol content 3
getJPCol content = getCol content 4
getKorCol content = getCol content 5
getThaiCol content = getCol content 6
getVietCol content = getCol content 7


com :: String -> String -> String
com x y = "\"" ++ x ++ "\"" ++ " = " ++ "\"" ++ y ++ "\"" ++ ";" 