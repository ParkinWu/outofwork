module GroupCheck where
  
groupCheck :: String -> Bool
groupCheck s
  | odd $ length s      = False
  | length s == 0       = True
  | length rmPairs == 0 = True
  | otherwise           = isPair firstChar lastChar && groupCheck (firstLast rmPairs)
  where rmPairs   = (consumePairs s)
        firstChar = head rmPairs
        lastChar  = last rmPairs

firstLast::[a]->[a]
firstLast [] = []
firstLast [x] = []
firstLast xs = tail (init xs)

consumePairs :: String -> String
consumePairs [] = ""
consumePairs (l:[]) = [l]
consumePairs (l:r:xs) = 
  if isPair l r 
  then consumePairs xs 
  else l:r:xs 

isPair :: Char -> Char -> Bool
isPair '(' ')' = True
isPair '{' '}' = True
isPair '[' ']' = True
isPair _ _     = False