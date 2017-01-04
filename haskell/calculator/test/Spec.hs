import Test.QuickCheck
import Lib


main :: IO ()
main = do
    quickCheck prop_item
    quickCheck prop_char


prop_item :: String -> Bool
prop_item [] = null (runParser item [])
prop_item all@(x:xs) = runParser item all  == [(x, xs)]

prop_char :: Char -> String -> Bool
prop_char c [] = runParser (char c) [] == []
prop_char c all@(c':cs) = runParser (char c) all  == [(c', cs)] && c' == c