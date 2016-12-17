module Baseio where

main = do
    putStrLn "greeting ! what's your name?"
    name <- getLine
    putStrLn $ "welcome" ++ name
