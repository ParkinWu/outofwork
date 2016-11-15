module FunctionWithWhere where

printInc n = print plusTwo
    where plusTwo = n + 2

printInc2 n = let plusTwo = n + 2
              in print plusTwo

mult1       = x * y
    where x = 5
          y = 6


-- x = 3; y = 1000 in x * 3 + y

-- y = 10; x = 10 * 5 + y in x * 5

-- x = 7; y = nagate x; z = y * 10 in z / x + y

m1          = x * 3 + y
    where x = 3
          y = 1000


m2          = x * 5
    where y = 10
          x = 10 * 5 + y


m3          = z / x + y
    where x = 7
          y = negate x
          z = y * 10


triple x = x * 3


z = 7
x = y ^ 2
waxOn = x * 5
y = z + 8

waxOn1      = x * 5
    where x = y ^ 2
          y = z + 8
          z = 7