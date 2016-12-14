{-# LANGUAGE InstanceSigs #-}
module MonadTrans where

newtype Identity a = Identity { runIdentity :: a}


instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

newtype Compose f g a = Compose {
  getCompose :: f (g a)
} deriving (Show, Eq)

instance (Functor f, Functor g) => Functor (Compose f g) where
  fmap f (Compose fga) = Compose $ (fmap . fmap) f fga


newtype One f a = One (f a) deriving (Show, Eq)

instance (Functor f) => Functor (One f) where
  fmap f (One fa) = One $ fmap f fa

newtype Three f g h a = Three (f (g (h a))) deriving (Show, Eq)

instance (Functor f, Functor g, Functor h) => Functor (Three f g h) where
  fmap f (Three fgha) = Three $ (fmap . fmap . fmap) f fgha
  

instance (Applicative f, Applicative g) => Applicative (Compose f g) where
  pure :: a -> Compose f g a
  pure = undefined
  (<*>) :: Compose f g (a -> b) -> Compose f g a -> Compose f g b
  (Compose f) <*> (Compose a) = undefined

instance (Monad f, Monad g) => Monad (Compose f g) where 
  return = pure
  (>>=) :: Compose f g a -> (a -> Compose f g b) -> Compose f g b
  (>>=) = undefined
  
-- Monad f => f a -> (a -> f b) -> f b
-- Monad g => g a -> (a -> g b) -> g b

-- (Monad f, Monad g) => f (g a) -> (a -> f (g b)) -> f (g b)

newtype IdentityT f a = IdentityT { runIdentityT :: f a} deriving (Show, Eq)

instance (Functor m) => Functor (IdentityT m) where
  fmap f (IdentityT fa) = IdentityT (fmap f fa)

instance (Applicative m) => Applicative (IdentityT m) where
  pure x = IdentityT (pure x)
  (IdentityT fab) <*> (IdentityT fa) = IdentityT (fab <*> fa)
  























