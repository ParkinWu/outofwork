module Main where

import RecursiveContents

main = getRecursiveContents "." >>= print
