module Main where

import RecursiveContents

main :: IO ()
main = getRecursiveContents "." >>= print

name :: String -> String
name a  = "pzwu" ++ a

