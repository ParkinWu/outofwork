data Trivial = Trivial

instance Eq Trivial where
    Trivial == Trivial = True

data DayOfWeek =
     Mon | Tue | Weds | Thu | Fri | Sat | Sun

instance Eq DayOfWeek where
    (==) Mon Mon    = True
    (==) Tue Tue    = True
    (==) Weds Weds  = True
    (==) Thu Thu    = True
    (==) Fri Fri    = True
    (==) Sat Sat    = True
    (==) _ _        = False

data Date = Date DayOfWeek Int

instance Eq Date where
    (==) (Date weekday dayOfWeek)
         (Date weekday' dayOfWeek') = 
        weekday == weekday' && dayOfWeek == dayOfWeek'


data Identity a = 
    Identity a

instance Eq a => Eq (Identity a) where
    (==) (Identity v) (Identity v') = v == v'


data TisAnInteger = 
    TisAn Integer

instance Eq TisAnInteger where
    (==) (TisAn i) (TisAn i') = i == i'


data TwoIntegers = 
    Two Integer Integer

instance Eq TwoIntegers where
    (==) (Two a b) (Two a' b') = a == a && b == b'

data StringOrInt = 
    TisAnInt Int |
    TisAString String

instance Eq StringOrInt where
    (==) (TisAnInt a) (TisAnInt a') = a == a'
    (==) (TisAString s) (TisAString s') = s == s'
    (==) _ _ = False


data Pair a =
    Pair a a

instance Eq a => Eq (Pair a) where
    (==) (Pair a b) (Pair a' b') = a == a' && b == b'

data Tuple a b = 
    Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a b) (Tuple a' b') = a == a' && b == b'

data Which a =
    ThisOne a |
    ThatOne a

instance (Eq a) => Eq (Which a) where
    (==) (ThisOne a) (ThisOne a') = a == a'
    (==) (ThatOne a) (ThatOne a') = a == a'
    (==) _ _ = False

data EitherOr a b =
    Hello a |
    Goodbye b


instance (Eq a, Eq b) => Eq (EitherOr a b) where
    (==) (Hello a) (Hello a') = a == a'
    (==) (Goodbye b) (Goodbye b') = b == b'
    (==) _ _ = False









