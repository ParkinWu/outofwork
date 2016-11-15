module GreetIfCool1 where

greetIfCool :: String -> IO ()
greetIfCool coolness = 
    if cool
        then putStrLn "what's sshakin"
    else
        putStrLn "adsfasdf"
    where cool = coolness == "aaaaa"

functionH :: [a] -> a
functionH (x:_) = x

functionC :: (Ord a) => a -> a -> Bool
functionC x y = if (x > y) then True else False

functionS :: (a, b) -> b
functionS (x, y) = y

myFunc :: (x -> y) 
       -> (y -> z) 
       -> c 
       -> (a, x)
       -> (a, z)
myFunc xToY yToZ _ (a, x) = (a, (yToZ (xToY x)))

i :: a -> a
i = id

c :: a -> b -> a
c x _ = x 



co :: (b -> c) -> (a -> b) -> a -> c
co f g x = f (g x)


