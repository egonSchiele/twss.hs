{-# LANGUAGE FlexibleContexts #-}
module Twss( TrainingData
           , readTrainingData
           , isTwss
           , isTwssProbability )
  where
import qualified Classify
import Control.Monad

threshold :: Floating t => t
threshold = 0.5

type TrainingData = [String]

readTrainingData :: FilePath -> IO TrainingData
readTrainingData = liftM lines . readFile

isTwssProbability :: Floating t => TrainingData -> TrainingData -> String -> t
isTwssProbability pos neg prompt = Classify.getTwssProbability pos neg prompt

isTwss :: TrainingData -> TrainingData -> String -> Bool
isTwss pos neg prompt = Classify.isTwss pos neg prompt (threshold :: Double)
