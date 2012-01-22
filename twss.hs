module Twss where
import qualified Classify
import qualified Data.PositivePrompts as Pos
import qualified Data.NegativePrompts as Neg

-- constants
threshold = 0.5 
num_words_in_ngram = 1

posTrainingData = Pos.prompts
negTrainingData = Neg.prompts

isTwssProbability prompt = Classify.getTwssProbability prompt posTrainingData negTrainingData threshold

isTwss prompt =  Classify.isTwss prompt posTrainingData negTrainingData threshold
