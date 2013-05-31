module Document where

import qualified Utils as U
import Text.Regex
import qualified Data.Map as M

stripPunctuation :: String -> String
stripPunctuation str = subRegex punctuationRegex str ""
    where punctuationRegex = mkRegex "=|@|#|\\||\\+|\\-|\\,|\\.|\\!|\\?|\"|'|\\:|\\;|\\(|\\)|\\[|\\]|\\{|\\}|\\/|\\\\"

cleanSpaces :: String -> String
cleanSpaces str = subRegex (mkRegex "s{2,}") str " "

cleanDocument :: String -> String
cleanDocument doc = cleanSpaces . U.strip . U.lowercase . stripPunctuation $ doc

getNgrams :: String -> [String]
-- his implementation only makes them into 1-grams, so just doing this for now
getNgrams doc = words doc

getNgramFrequency :: Num t => String -> [(String, t)]
-- assuming ngramSize = 1 and countNgramOnce = undefined = false
-- [(word, freq)]
getNgramFrequency doc = U.counts . getNgrams . cleanDocument $ doc

getNgramFrequencies :: Num t => [String] -> (M.Map String t, t)
-- returns (ngram frequencies, total ngrams)
getNgramFrequencies docs = (frequencies_hash, sum $ M.elems frequencies_hash)
  where frequencies = map getNgramFrequency docs
        frequencies_hash = foldl (\acc doc_freq -> M.unionWith (+) acc (M.fromList doc_freq)) M.empty frequencies

getNgramBayesianProbabilities :: Fractional a => [String] -> [String] -> M.Map String a
getNgramBayesianProbabilities pos_docs neg_docs = M.mapWithKey prop usable_ngrams
  where prop ngram _ = ((posFreq M.! ngram) / ((posFreq M.! ngram) + (negFreq M.! ngram)))
        posFreq = fst $ getNgramFrequencies pos_docs
        negFreq = fst $ getNgramFrequencies neg_docs
        usable_ngrams = M.intersection posFreq negFreq

getNgramProbabilities :: Fractional b => [String] -> M.Map String b
getNgramProbabilities docs = M.map (/ total_ngrams) freq
    where (freq, total_ngrams) = getNgramFrequencies docs
