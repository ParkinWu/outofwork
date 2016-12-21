module Lib where

import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad.ST
import System.Environment


symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

