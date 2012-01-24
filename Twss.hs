{-# LANGUAGE FlexibleContexts #-}
module Twss where
import qualified Classify
import qualified Data.PositivePrompts as Pos
import qualified Data.NegativePrompts as Neg

-- constants
threshold :: Double
threshold = 0.5

posTrainingData :: [[Char]]
posTrainingData = Pos.prompts

negTrainingData :: [[Char]]
negTrainingData = Neg.prompts

isTwssProbability :: Floating (Double -> t) => String -> t
isTwssProbability prompt = Classify.getTwssProbability prompt posTrainingData negTrainingData threshold

isTwss :: String -> Bool
isTwss prompt = Classify.isTwss prompt posTrainingData negTrainingData threshold
