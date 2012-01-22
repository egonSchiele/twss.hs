import Classify
import PositivePrompts
import NegativePrompts

-- constants
THRESHOLD = 0.5 
NUM_WORDS_IN_NGRAM = 1

posTrainingData = PositivePrompts.prompts
negTrainingData = NegativePrompts.prompts

probability prompt = Classify.getTwssProbability prompt posTrainingData negTrainingData THRESHOLD

isTwss prompt = Classify.isTwss prompt posTrainingData negTrainingData THRESHOLD
