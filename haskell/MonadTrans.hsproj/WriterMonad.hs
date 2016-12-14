module WriterMonad where
  
import Data.Monoid
import Control.Monad.Writer

merge [] xs = xs
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys
  
indent :: Int -> ShowS
indent n = showString (take (4 * n) (repeat ' '))

n1 :: ShowS
n1 = showChar '\n'

mergeSort :: Int -> [Int] -> Writer String [Int]
mergeSort l [] = return []
mergeSort l s@[x] = return [x]
mergeSort l s@xs = do
  tell $ (indent l . showString "mergesort: " . shows s .n1) ""
  let (a1, a2) = splitAt (length s `div` 2) xs
  tell $ (indent (l + 1) . showString "merge" . shows a1 . shows a2 . n1) ""
  liftM2 merge (mergeSort (l + 2) a1) (mergeSort (l + 2) a2)
  




--newtype Writer w a = Writer { runWriter:: (a, w) } deriving (Show)
--
--instance (Monoid w) => Functor (Writer w) where
--  fmap f (Writer (a, v)) = Writer (f a, v)
--   
--
--instance (Monoid w) => Applicative (Writer w) where
--  pure a = Writer $ (a, mempty)
--  Writer (f, v) <*> Writer (x, v1) = Writer (f x, v `mappend` v1)
--  
--
--instance (Monoid w) => Monad (Writer w) where
--  return = pure
--  (Writer (x, v)) >>= f = 
--    let (Writer (y, v')) = f x
--    in Writer (y, v `mappend` v)
--    
--
--left, right :: Int -> Writer String Int
--left x = Writer (x - 1, "move left\n")
--right x = Writer (x + 1, "move right\n")
--
--move i = do
--  x <- left i
--  y <- left x
--  return y
  




