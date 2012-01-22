module Classify where
    import qualified Document as D
    import qualified Data.Map as M

getTwssProbability _prompt posTrainingData negTrainingData threshold = 1 / (1 + (exp n))
    where prompt = D.cleanDocument _prompt
          probabilities = D.getNgramBayesianProbabilities posTrainingData negTrainingData
          ngrams = filter (\ngram -> notMember ngram probabilities) $ D.getNgrams prompt
          n = foldl (\acc ngram -> acc + (log (1 - probabilities M.! ngram)) - (log $ probabilities M.! ngram) ) 0 ngrams

isTwss prompt posTrainingData negTrainingData threshold = (getTwssProbability prompt posTrainingData negTrainingData threshold) > threshold
