module Main (main) where

import Twss
import System.Environment

main :: IO ()
main = do args <- getArgs
          case args of
            [input] -> do
                      pos <- readTrainingData "positive"
                      neg <- readTrainingData "negative"
                      putStrLn $ show $ isTwss pos neg input
            _ -> do error "usage: runhaskell Main.hs <string>"
