module Classify ( getTwssProbability
                , isTwss)
  where
import qualified Document as D
import qualified Data.Map as M

getTwssProbability :: Floating a => [String] -> [String] -> String -> a
getTwssProbability posTrainingData negTrainingData _prompt = 1 / (1 + (exp n))
    where prompt = D.cleanDocument _prompt
          probabilities = D.getNgramBayesianProbabilities posTrainingData negTrainingData
          ngrams = filter (\ngram -> M.member ngram probabilities) $ D.getNgrams prompt
          n = foldl (\acc ngram -> acc + (log (1 - probabilities M.! ngram)) - (log $ probabilities M.! ngram) ) 0 ngrams

isTwss :: (Floating a, Ord a) => [String] -> [String] -> String -> a -> Bool
isTwss posTrainingData negTrainingData prompt threshold =
  getTwssProbability posTrainingData negTrainingData prompt > threshold
