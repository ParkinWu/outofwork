module SimpleFinder where

import           RecursiveContents

simpleFinder :: (FilePath -> Bool) -> FilePath -> IO [FilePath]
simpleFinder p path = do
    names <- getRecursiveContents path
    return (filter p names)

