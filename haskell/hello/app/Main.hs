module Main where
-- import           Data.Char
-- import           Data.List
-- import           Lib
-- import           System.Directory
-- import           System.Environment
import           Data.List
import           System.IO

main :: IO ()
main = do
  input <- getLine
  let n = read input :: Int
  content <- getContents
  let rows = map words (lines content)
  print rows

maxTree tab row col =
    let left = leftNode tab row col
        right = rightNode tab row col
        maxV = max left right
    in case maxV of
       Just a -> 


leftNode :: [[a]] -> Int -> Int -> Maybe a
leftNode tab row col
    | length tab > row + 1 = Just ((tab !! (row + 1)) !! col)
    | otherwise = Nothing

rightNode :: [[a]] -> Int -> Int -> Maybe a
rightNode tab row col
    | length tab > row + 1 = Just ((tab !! (row + 1)) !! (col + 1))
    | otherwise = Nothing

-- 给出一个整数K和一个无序数组A，A的元素为N个互不相同的整数，找出数组A中所有和等于K的数对。例如K = 8，数组A：{-1,6,5,3,4,2,9,0,8}，所有和等于8的数对包括(-1,9)，(0,8)，(2,6)，(3,5)。
-- Input
-- 第1行：用空格隔开的2个数，K N，N为A数组的长度。(2 <= N <= 50000，-10^9 <= K <= 10^9)
-- 第2 - N + 1行：A数组的N个元素。（-10^9 <= A[i] <= 10^9)
-- Output
-- 第1 - M行：每行2个数，要求较小的数在前面，并且这M个数对按照较小的数升序排列。
-- 如果不存在任何一组解则输出：No Solution。

-- newtype Pair = Pair (Int, Int)
--
-- instance Show Pair where
--   show (Pair (x, y)) = show x ++ " " ++ show y
--
-- main :: IO ()
-- main = do
--     input <- getLine
--     let k:(n:_) = map read (words input) :: [Int]
--     content <- getContents
--     let nums = sort (map read (lines content) :: [Int])
--         pairs = findPair nums k
--         str = foldl (\s p -> s ++ show p ++ "\n") "" pairs
--     if null str
--       then putStr "No Solution"
--       else putStr str
--
-- findPair [] k = []
-- findPair xs k
--       | n < k =  findPair (tail xs) k
--       | n > k = findPair (take (len - 1) xs) k
--       | otherwise = [(head xs, last xs)]
--     where
--       n = head xs + last xs
--       len = length xs



-- n的阶乘后面有多少个0？
-- 6的阶乘 = 1*2*3*4*5*6 = 720，720后面有1个0。
-- Input
-- 一个数N(1 <= N <= 10^9)
-- Output
-- 输出0的数量

-- main :: IO ()
-- main = do
--   input <- getLine
--   let num = read input :: Int
--   putStr $ show (getSumPow num)
--
--
-- getSumPow 0 = 0
-- getSumPow n = getSumPow (n `div` 5) + (n `div` 5)




-- 给出一个整数N，输出N^N（N的N次方）的十进制表示的末位数字。
-- Input
-- 一个数N（1 <= N <= 10^9）
-- Output
-- 输出N^N的末位数字
-- main :: IO ()
-- main = do
--   input <- getLine
--   let n = read input :: Int
--   putStr $ show (powLastBit n)
--
-- powLastBit :: Int -> Int
-- powLastBit 1 = 1
-- powLastBit n = lastBitMap !! mod (n - 1) lastBitLength
--   where
--     lastBitMap = circleMap !! takeLastBit n
--     lastBitLength = length lastBitMap
--
-- circleMap :: [[Int]]
-- circleMap = [[0],[1],[2, 4, 8, 6],[3, 9, 7, 1],[4, 6],[5],[6],[7, 9, 3, 1],[8, 4, 2, 6],[9, 1]]
--
-- takeLastBit :: Int -> Int
-- takeLastBit n = mod n 10

-- main :: IO ()
-- main = do
--   input <- getLine
--   if isDouble input
--     then putStr "YES"
--     else putStr "NO"
--
-- isDouble :: String -> Bool
-- isDouble s =  mod len 2 == 0 && take half s == drop half s
--   where
--     len = length s
--     half = div len 2


-- main :: IO ()
-- main = do
--   input <- getLine
--   let s = sum $ map read (words input)
--   putStr $ show s


-- main :: IO ()
-- main = do
--     (command:args) <- getArgs
--     let (Just action) = lookup command dispatch
--     action args
--
-- add :: [String] -> IO ()
-- add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")
--
-- view :: [String]-> IO ()
-- view [fileName] = do
--     contents <- readFile fileName
--     let todoTasks = lines contents
--         todoList = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
--     putStrLn $ unlines todoList
--
-- remove :: [String]-> IO ()
-- remove [fileName, numberString] = do
--     (tempFileName, writeHandle) <- openTempFile "." "temp"
--     readHandle <- openFile fileName ReadMode
--     contents <- hGetContents readHandle
--     let todoTasks = lines contents
--         index = read numberString
--         newTaskTasks = delete (todoTasks !! index) todoTasks
--     hPutStr writeHandle $ unlines newTaskTasks
--     hClose readHandle
--     hClose writeHandle
--     removeFile fileName
--     renameFile tempFileName fileName
--
--
--
-- dispatch :: [(String, [String]-> IO ())]
-- dispatch = [ ("add", add)
--             ,("view", view)
--             ,("remove", remove)
--             ]

-- main :: IO ()
-- main = do
--     args <- getArgs
--     progName <- getProgName
--     putStrLn "the arguments are:"
--     mapM putStrLn args
--     putStrLn "the programe name:"
--     putStrLn progName


-- main :: IO ()
-- main = do
--     handle <- openFile "todoList.txt" ReadMode
--     (tempName, tempHandle) <- openTempFile "." "temp"
--     contents <- hGetContents handle
--     let todoTasks = lines contents
--         numberedTasks = zipWith (\n line -> show n ++ "-" ++ line) [0..] todoTasks
--     putStrLn "this is your TO-DO items: "
--     putStr $ unlines numberedTasks
--     putStrLn "which one do you want to delete?"
--     numberString <- getLine
--     let number = read numberString
--         newToDoItems = delete (todoTasks !! number) todoTasks
--     hPutStr tempHandle $ unlines newToDoItems
--     hClose handle
--     hClose tempHandle
--     removeFile "todoList.txt"
--     renameFile tempName "todoList.txt"



-- main :: IO ()
-- main = do
--     todoItem <- getLine
--     appendFile "todoList.txt" (todoItem ++ "\n")


-- wirte
-- main = do
--     contents <- readFile "girlfriends.txt"
--     writeFile "girlfriendsCap.txt" (map toUpper contents)


-- main :: IO ()
-- main = do
--     contents <- readFile "girlfriends.txt"
--     putStrLn contents

-- main :: IO ()
-- main = do
--     withFile "girlfriends.txt" ReadMode (\handle -> do
--         contents <- hGetContents handle
--         putStr contents)


-- main :: IO ()
-- main = do
--   handle <- openFile "girlfriends.txt" ReadMode
--   contents <- hGetContents handle
--   putStr contents
--   hClose handle




-- main :: IO ()
-- main = do
--   line <- getLine
--   if null line
--       then return ()
--       else do
--           putStrLn $ reverseWord line
--           main
--
-- reverseWord :: String -> String
-- reverseWord = unwords . map reverse . words
