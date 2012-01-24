module Utils where

import System.Info (os)
import System.Process (readProcessWithExitCode)
import System.Exit
import Text.Printf
import Control.Monad (forM)
import System.Directory (doesDirectoryExist, getDirectoryContents)
import System.FilePath ((</>))
import qualified Data.List as L
import Data.List.Split
import qualified Data.Text as T
import qualified Data.Char as C
import Text.Regex
import System.Random
import qualified Data.Map as M

-- given an array, returns an array that is just indices for that first array
-- example: ["a", "b", "c"] -> [0, 1, 2]
indices l = [0..((L.genericLength l)-1)]


-- usage: shape 4 [0..15]
-- returns a 2d array like:
-- [[0, 1, 2, 3],
--  [4, 5, 6, 7],
--  [8, 9, 10, 11],
--  [12, 13, 14, 15]]

-- so...reshapes the 1d array to a 2d array. n is the width of the 2d array.

shape n [] = []
shape n xs = [take n xs] ++ (shape n (drop n xs))

-- choose a random element from a list
choice l gen = l !! (fst (randomR (0, (L.genericLength l)) gen :: (Int, StdGen)))

-- count the number of time x shows up in l
count l x = L.genericLength $ filter (==x) l

-- run count on every value in l
counts l = map (\x -> (x, count l x)) (L.nub l)

-- convenience functions to translate Maybes to bools
maybe_bool (Just _)= True
maybe_bool Nothing = False

-- convenience function to make Haskell regexes behave like Perl regexes
str =~ regex = maybe_bool $ matchRegex (mkRegex regex) str
str !~ regex = not $ str =~ regex

joinOn str l = foldl1 (\acc x -> acc ++ str ++ x) l

join = joinOn ""

-- given a file name, get the name of the directory that it's in
dirName f = ((joinOn "/").init.(splitOn "/")) f

-- a glob function. usage:
-- glob "/usr/local/bin/*.hs"
glob pat = do
    -- try to guess the directory name by ignoring everything after the first * and getting the dir name from the part before the *.
    let dir = dirName (fst (break (=='*') pat))
    contents <- getRecursiveContents dir
    -- get files that match that pattern and aren't invisible files or dirs
    return $ filter (\x -> (x =~ pat) && (x !~ "/\\..*")) contents

uppercase = map C.toUpper
lowercase = map C.toLower

-- | Attempt to open a web browser on the given url, all platforms.
openBrowser :: String -> IO ExitCode
openBrowser u = trybrowsers browsers u
    where
      trybrowsers (b:bs) u = do
        (e,_,_) <- readProcessWithExitCode b [u] ""
        case e of
          ExitSuccess -> return ExitSuccess
          ExitFailure _ -> trybrowsers bs u
      trybrowsers [] u = do
        putStrLn $ printf "Could not start a web browser (tried: %s)" $ L.intercalate ", " browsers
        putStrLn $ printf "Please open your browser and visit %s" u
        return $ ExitFailure 127
      browsers | os=="darwin"  = ["open"]
               | os=="mingw32" = ["c:/Program Files/Mozilla Firefox/firefox.exe"]
               | otherwise     = ["sensible-browser","gnome-www-browser","firefox"]


-- Given a directory, get all the contents in that dir, recursively.
getRecursiveContents :: FilePath -> IO [FilePath]
getRecursiveContents topdir = do
  names <- getDirectoryContents topdir
  let properNames = filter (`notElem` [".", ".."]) names
  paths <- forM properNames $ \name -> do
    let path = topdir </> name
    isDirectory <- doesDirectoryExist path
    if isDirectory
      then getRecursiveContents path
      else return [path]
  return (concat paths)


{-
main = do
    openBrowser "http://google.com"
    getRecursiveContents "."
-}

-- merge h2 into h1, combining values of duplicates keys using the function f
merge :: Ord k => M.Map k a -> M.Map k a -> (a -> a -> a) -> M.Map k a
merge h1 h2 f = foldl (\acc k -> M.insertWith f k (h2 M.! k) acc) h1 (M.keys h2)

