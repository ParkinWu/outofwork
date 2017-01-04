module Main where

import Lib
import Control.Monad
import System.IO

main :: IO ()
main = forever $ do
    putStr "> "
    hFlush stdout
    s <- getLine
    print (eval $ run expr s)









