module Main where

  
data Exp = Lit Integer
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Div Exp Exp
         

eval :: Exp -> Integer
eval (Lit n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2
eval (Div e1 e2) = eval e1 `div` eval e2

-- 没有考虑除数 = 0 的情况, eval (Div (Lit 10) (Lit 0)) 出现异常

safeEval :: Exp -> Maybe Integer
safeEval (Lit n) = Just n
safeEval (Add e1 e2) = 
  case safeEval e1 of
    Nothing -> Nothing
    Just n1 -> 
      case safeEval e2 of
        Nothing -> Nothing
        Just n2 -> Just (n1 + n2)
  
-- 等等, 但这样代码会冗长, 难以理解
-- 抽象出公共的部分
evalSeq :: Maybe Integer -> (Integer -> Maybe Integer) -> Maybe Integer
evalSeq Nothing _ = Nothing
evalSeq (Just n) f = f n

add :: Maybe Integer -> Integer -> Maybe Integer
add Nothing _ = Nothing
add (Just a) b = Just (a + b)

div1 :: Maybe Integer -> Integer -> Maybe Integer
div1 Nothing _ = Nothing
div1 (Just 0) _ = Nothing
div1 (Just a) b = Just (b `div` a)

-- 这样 safeEval 可以修改

safeEval1 :: Exp -> Maybe Integer
safeEval1 (Lit n) = Just n
safeEval1 (Add e1 e2) = evalSeq (safeEval1 e1) (add (safeEval1 e2))
safeEval1 (Div e1 e2) = evalSeq (safeEval1 e1) (div1 (safeEval1 e2))

-- Maybe Monad
safeEval2 :: Exp -> Maybe Integer
safeEval2 (Lit n) = Just n
safeEval2 (Add e1 e2) = (safeEval2 e1) >>= (add (safeEval2 e2))
safeEval2 (Div e1 e2) = (safeEval2 e1) >>= (div1 (safeEval2 e2))

  




 



