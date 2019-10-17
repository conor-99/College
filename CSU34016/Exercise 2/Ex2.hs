{- mccaulco Conor McCauley -}
module Ex02 where
import Data.List ((\\))

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Eq k => Dict k d -> k -> Maybe d
find []             _                 =  Nothing
find ( (s,v) : ds ) name | name == s  =  Just v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- Part 1 : Evaluating Expressions -- (60 test marks, worth 15 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return Nothing if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.

eval :: EDict -> Expr -> Maybe Double
eval d (Val v) = Just v
eval d (Add e1 e2) = case (eval d e1, eval d e2) of
                          (Just v1, Just v2) -> Just (v1 + v2)
                          _                  -> Nothing
eval d (Mul e1 e2) = case (eval d e1, eval d e2) of
                          (Just v1, Just v2) -> Just (v1 * v2)
                          _                  -> Nothing
eval d (Sub e1 e2) = case (eval d e1, eval d e2) of
                          (Just v1, Just v2) -> Just (v1 - v2)
                          _                  -> Nothing
eval d (Dvd e1 e2) = case (eval d e1, eval d e2) of
                          (Just v1, Just v2) -> if v2 == 0 then Nothing else Just (v1 / v2)
                          _                  -> Nothing
eval d (Var s) = find d s
eval d (Def s e1 e2) = case (eval d e1) of
                            (Just v) -> eval (define d s v) e2
                            _        -> Nothing


-- Part 1 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + z         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}


law1 :: Expr -> Maybe Expr
law1 (Add e1 e2) = Just (Add e2 e1)
law1 _ = Nothing

law2 :: Expr -> Maybe Expr
law2 (Add e1 (Add e2 e3)) = Just (Add (Add e1 e2) e3)
law2 _ = Nothing

law3 :: Expr -> Maybe Expr
law3 (Sub e1 (Add e2 e3)) = Just (Sub (Sub e1 e2) e3)
law3 _ = Nothing

law4 :: Expr -> Maybe Expr
law4 (Mul (Add w x) (Sub y z)) = if (w == y) && (x == z) then Just (Sub (Mul w w) (Mul x x)) else Nothing
law4 _ = Nothing
