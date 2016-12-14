module MonadTransLearn where
  
import Control.Monad.State

newtype Identity a = Identity { runIdentity :: a }
newtype IdentityT m a = IdentityT { runIdentityT :: m a } deriving (Show)

instance Functor Identity where
  fmap f a = Identity $ f (runIdentity a)
  
instance Applicative Identity where
  pure a = Identity a
  f <*> a = Identity $ runIdentity f $ runIdentity a
  
instance Monad Identity where
  return = pure
  m >>= f = f $ runIdentity m

instance (Functor a) => Functor (IdentityT a) where
  fmap f a = IdentityT $ fmap f (runIdentityT a)

instance (Applicative m) => Applicative (IdentityT m) where
  pure a = IdentityT $ pure a
  f <*> a = IdentityT $ runIdentityT f <*> runIdentityT a

instance (Monad m) => Monad (IdentityT m) where
  return a = IdentityT $ return a
  m >>= k = IdentityT $ do
     a <- runIdentityT m
     runIdentityT (k a)
    
data MaybeT m a = MaybeT { runMaybeT :: m a}

instance (Functor m) => Functor (MaybeT m) where
  fmap f a = MaybeT $ fmap f (runMaybeT a)
  
instance (Applicative m) => Applicative (MaybeT m) where
  pure a = MaybeT $ pure a
  f <*> a = MaybeT $ runMaybeT f <*> runMaybeT a
  
instance (Monad m) => Monad (MaybeT m) where
  return = pure
  m >>= f = MaybeT $ do
    a <- runMaybeT m
    runMaybeT (f a)
    

safeHead :: [a] -> MaybeT Identity (Maybe a)
safeHead [] = MaybeT $ Identity Nothing
safeHead (x:xs) = MaybeT $ Identity $ Just x

push :: Int -> State [Int] ()
push x = state $ \xs -> ((), x:xs)


pop :: State [Int] (Maybe Int)
pop = state $ \xs -> case xs of
  [] -> (Nothing, [])
  (x:xs) -> (Just x, xs)
  

stack :: State [Int] ()
stack = do
  push 1
  push 2
  pop
  push 5
  






























