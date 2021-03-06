module Paths_learn (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/parkinwu/Library/Haskell/bin"
libdir     = "/Users/parkinwu/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/lib/ghc/learn-0.1.0.0"
datadir    = "/Users/parkinwu/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/share/learn-0.1.0.0"
libexecdir = "/Users/parkinwu/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/libexec"
sysconfdir = "/Users/parkinwu/Library/Containers/com.haskellformac.Haskell.basic/Data/Library/Application Support/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "learn_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "learn_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "learn_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "learn_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "learn_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
