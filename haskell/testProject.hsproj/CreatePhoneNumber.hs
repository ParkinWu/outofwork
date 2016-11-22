module CreatePhoneNumber where
 

getAreaNumber :: [Int] -> String
getAreaNumber xs = foldr ((++) . show) "" $ take 3 xs

addPair :: String -> String
addPair s = "(" ++ s ++ ")"


getHeader :: [Int] -> String
getHeader xs = foldr ((++) . show) "" $ take 3 $ drop 3 xs 
 
getFooter :: [Int] -> String
getFooter xs = foldr ((++) . show) "" $ drop 6 xs

createPhoneNumber :: [Int] -> String
createPhoneNumber xs = (addPair $ getAreaNumber xs) ++ " " ++ getHeader xs ++ "-" ++ getFooter xs
