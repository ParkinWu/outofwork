module Prettify where
  
import Data.Monoid
import Numeric (showHex)
import Data.Char (ord)
import Data.Bits (shiftR, (.&.))



data Doc = Empty
         | Char Char
         | Text String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
           deriving (Show,Eq)

instance Monoid Doc where
  mempty = Empty
  mappend Empty y = y
  mappend x Empty = x
  mappend x y = Concat x y
   

empty :: Doc
empty = Empty

string :: String -> Doc
string = enclose '"' '"' . mconcat . map oneChar

text :: String -> Doc
text str = Text str

double :: Double -> Doc
double num = Text $ show num

char :: Char -> Doc
char c = Char c

line :: Doc
line = Line

oneChar :: Char -> Doc
oneChar c = 
  case lookup c simpleEscapes of
    Just r   -> text r
    Nothing  | mustEscape c -> hexEscape c
             | otherwise    -> char c
  where mustEscape c = c < ' ' || c == '\x7f' || c > '\xff'


smallHex :: Int -> Doc
smallHex x  = text "\\u"
           <> text (replicate (4 - length h) '0')
           <> text h
    where h = showHex x ""
-- smallHex 只能转换四位的 Unicode 字符,最多到0xffff
-- 但 Unicode 的合法范围应该是0x10ffff, 
-- 为了能表示0xffff 以上的字符, 将一个 Unicode 拆成两个,
-- a 取前10bit, b取后10bit
-- .&. 按位与
astral :: Int -> Doc
astral n = smallHex (a + 0xd800) <> smallHex (b + 0xdc00)
    where a = (n `shiftR` 10) .&. 0x3ff
          b = n .&. 0x3ff

hexEscape :: Char -> Doc
hexEscape c | d < 0x10000 = smallHex d
            | otherwise   = astral (d - 0x10000)
  where d = ord c

enclose :: Char -> Char -> Doc -> Doc
enclose left right s = char left <> s <> char right

simpleEscapes :: [(Char, String)]
simpleEscapes = zipWith ch "\b\n\f\r\t\\\"/" "bnfrt\\\"/"
  where ch a b = (a, ['\\', b])



series :: Char -> Char -> (a -> Doc) -> [a] -> Doc
series open close item = enclose open close
                       . fsep . punctuate (char ',') . map item


fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty

fsep :: [Doc] -> Doc
fsep = fold (</>)

(</>) :: Doc -> Doc -> Doc
x </> y = x <> softline <> y

softline :: Doc
softline = group line

group :: Doc -> Doc
group x = flatten x `Union` x

flatten :: Doc -> Doc
flatten (x `Concat` y) = flatten x `Concat` flatten y
flatten Line           = Char ' '
flatten (x `Union` _)  = flatten x
flatten other          = other

punctuate :: Doc -> [Doc] -> [Doc]
punctuate p []     = []
punctuate p [d]    = [d]
punctuate p (d:ds) = (d <> p) : punctuate p ds


fits :: Int -> String -> Bool
w `fits` _ | w < 0 = False
w `fits` ""        = True
w `fits` ('\n':_)  = True
w `fits` (c:cs)    = (w - 1) `fits` cs

compact :: Doc -> String
compact x = transform [x]
    where transform [] = ""
          transform (d:ds) =
              case d of
                Empty        -> transform ds
                Char c       -> c : transform ds
                Text s       -> s ++ transform ds
                Line         -> '\n' : transform ds
                a `Concat` b -> transform (a:b:ds)
                _ `Union` b  -> transform (b:ds)

pretty :: Int -> Doc -> String
pretty width x = best 0 [x]
    where best col (d:ds) =
              case d of
                Empty        -> best col ds
                Char c       -> c :  best (col + 1) ds
                Text s       -> s ++ best (col + length s) ds
                Line         -> '\n' : best 0 ds
                a `Concat` b -> best col (a:b:ds)
                a `Union` b  -> nicest col (best col (a:ds))
                                           (best col (b:ds))
          best _ _ = ""

          nicest col a b | (width - least) `fits` a = a
                         | otherwise                = b
                         where least = min width col
