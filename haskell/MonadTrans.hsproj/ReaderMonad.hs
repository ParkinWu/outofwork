module ReaderMonad where

newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f a = Reader $ \r -> (f (runReader a r))

instance Applicative (Reader r) where
  pure a = Reader $ \_ -> a
  f <*> k = Reader $ \r -> runReader f r $ runReader k r
  
instance Monad (Reader r) where
  return = pure
  k >>= f = Reader $ \r -> runReader (f (runReader k r)) r