module Lib
    (
      Parser
    , runParser
    , item
    , satisfy
    , oneOf
    , char
    , digit
    , eval
    , expr
    , run
    ) where

import Control.Applicative
import Control.Monad
import Data.Char (isDigit)

data Parser a = Parser {
  runParser :: String -> [(a, String)]
}


instance Functor Parser where
    fmap f p = Parser $ \s -> [(f a, s') | (a, s') <- runParser p s ]

instance Applicative Parser where
    pure a = Parser $ \s -> [(a, s)]
    mf <*> ma = Parser $ \s -> [(f a, s'') | (f, s') <- runParser mf s, (a, s'') <- runParser ma s']


instance Alternative Parser where
    p <|> m = Parser $ \s ->
        case runParser p s of
            [] -> runParser m s
            res -> res
    empty = Parser $ const []


instance Monad Parser where
    ma >>= f = Parser $ \s -> concatMap (\(a, s') -> runParser (f a) s') (runParser ma s)

item :: Parser Char
item = Parser $ \s ->
    case s of
        [] -> []
        (c:cs) -> [(c, cs)]

satisfy :: (Char -> Bool) -> Parser Char
satisfy f = item >>= \c ->
    if f c
        then return c
        else Parser $ const []

oneOf :: String -> Parser Char
oneOf s = satisfy (`elem` s)

char :: Char -> Parser Char
char c = satisfy (c ==)

digit :: Parser Char
digit = satisfy isDigit

spaces :: Parser String
spaces = many $ oneOf " \n\r"

natural :: Parser Integer
natural = read <$> some digit

number :: Parser Int
number = do
    spaces
    s <- string "-" <|> return []
    n <- some digit
    spaces
    return $ read (s ++ n)


string :: String -> Parser String
string [] = return []
string (c:cs) = do { char c; string cs; return (c:cs)}

data Expr = Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr
          | Lit Int deriving (Show)

parens :: Parser a -> Parser a
parens m = do
    spaces
    char '('
    spaces
    n <- m
    spaces
    char ')'
    spaces
    return n


chain :: Parser a -> Parser (a -> a -> a) -> Parser a
chain p op = do { a <- p; rest a}
    where rest m = (do
                       f <- op
                       b <- p
                       rest (f m b)) <|> return m


infixOp :: Char -> (a -> a -> a) -> Parser (a -> a -> a)
infixOp c f = char c >> return f

int :: Parser Expr
int = do
    spaces
    n <- number
    spaces
    return (Lit n)


addOp :: Parser (Expr -> Expr -> Expr)
addOp = infixOp '+' Add <|> infixOp '-' Sub

mulOp :: Parser (Expr -> Expr -> Expr)
mulOp = infixOp '*' Mul



-- (int <|> parens expr) chain mulOp chain addOp

factor :: Parser Expr
factor = int <|> parens expr

term :: Parser Expr
term = factor `chain` mulOp

expr :: Parser Expr
expr = term `chain` addOp

run :: Parser a -> String -> a
run p s =
    case runParser p s of
        [] -> error "error"
        [(res, _)] -> res


eval :: Expr -> Int
eval (Add a b) = eval a + eval b
eval (Sub a b) = eval a - eval b
eval (Mul a b) = eval a * eval b
eval (Lit n)   = n



