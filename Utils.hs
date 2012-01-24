module Utils (
               lowercase
             , counts
             ) where

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
