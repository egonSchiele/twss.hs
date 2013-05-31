module Utils where

import qualified Data.List as L
import qualified Data.Char as C

-- | @count x l@ returns the number of times @x@ shows up in @l@.
count :: (Eq b, Num i) => [b] -> b -> i
count l x = L.genericLength $ filter (==x) l

-- | Run 'count' on every value in a list.
counts :: (Eq b, Num t) => [b] -> [(b, t)]
counts l = map (\x -> (x, count l x)) (L.nub l)

lowercase :: String -> String
lowercase = map C.toLower

strip :: String -> String
strip = lstrip . rstrip

-- | Same as 'strip', but applies only to the left side of the string.
lstrip [] = []
lstrip (x:xs)
    | elem x " \t\r\n" = lstrip xs
    | otherwise = x:xs

-- | Same as 'strip', but applies only to the right side of the string.
rstrip :: String -> String
rstrip = reverse . lstrip . reverse
