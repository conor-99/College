-- Name: Conor McCauley,  Username: mccaulco
module Ex01 where
import Data.Char (toUpper)

{- Part 1

Write a function 'raise' that converts a string to uppercase

Function 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged

-}
raise :: String -> String
raise s = map toUpper s

{- Part 2

Write a function 'nth' that returns the nth element of a list

-}
nth :: Int -> [a] -> a
nth n l = l !! (n - 1)

{- Part 3

write a function commonLen that compares two sequences
and reports the length of the prefix they have in common.

-}
commonLen :: Eq a => [a] -> [a] -> Int
commonLen (a:as) (b:bs) | (a == b) = 1 + commonLen as bs
commonLen _ _ = 0
