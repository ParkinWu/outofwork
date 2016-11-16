module Main where

import Hello
import DogsRule
import System.IO


main :: IO String
main = do
  x1 <- getLine
  x2 <- getLine
  return (x1 ++ x2)


-- main :: IO ()
-- main = do
--   hSetBuffering stdout NoBuffering
--   putStr "Please input your name: "
--   name <- getLine
--   sayHello name
--   dogs
