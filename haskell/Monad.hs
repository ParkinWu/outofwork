bind :: Monad m => (a -> m b) -> m a -> m b
bind = flip (>>=)