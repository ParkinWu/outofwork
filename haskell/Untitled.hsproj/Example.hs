module Example where
  
import Data.Time.Calendar.WeekDate
  
--main = do
--  if 7 `mod` 2 == 0
--    then putStrLn "7 is even"
--    else putStrLn "7 is odd"


main = do
  let i = 2
  putStr $ "write" ++ show i ++ "as"
  case i of
    1 -> putStrLn "one"
    2 -> putStrLn "two"
    3 -> putStrLn "three"
  now <- getCurrentData
  let (_, _, week) = toWeek
  
    
