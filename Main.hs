module Main (main) where

import Twss
import System.Environment
import System.Exit

main :: IO ()
main = do args <- getArgs
          case args of
            [posf, negf, s] -> do
                      pos <- readTrainingData posf
                      neg <- readTrainingData negf
                      exitWith (if isTwss pos neg s then ExitSuccess else ExitFailure 1)
            _ -> do error "usage: <positives-file> <negatives-file> string"
