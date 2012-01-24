module Document where

import qualified Utils as U
import Text.Regex
import qualified Data.String.Utils as DU
import qualified Data.List as L 
import qualified Data.Map as M

stripPunctuation str = subRegex punctuationRegex str ""
    where punctuationRegex = mkRegex "=|@|#|\\||\\+|\\-|\\,|\\.|\\!|\\?|\"|'|\\:|\\;|\\(|\\)|\\[|\\]|\\{|\\}|\\/|\\\\"

cleanSpaces str = subRegex (mkRegex "s{2,}") str " "

cleanDocument doc = (cleanSpaces . DU.strip . U.lowercase . stripPunctuation) doc

-- his implementation only makes them into 1-grams, so just doing this for now
getNgrams doc = words doc

-- assuming ngramSize = 1 and countNgramOnce = undefined = false
-- [(word, freq)]
getNgramFrequency doc = U.counts $ getNgrams $ cleanDocument doc

-- returns (ngram frequencies, total ngrams)
getNgramFrequencies docs = (frequencies_hash, sum $ M.elems frequencies_hash)
    where
    frequencies = map getNgramFrequency docs
    frequencies_hash = foldl (\acc doc_freq -> U.merge acc (M.fromList doc_freq) (+)) M.empty frequencies
    
getNgramBayesianProbabilities pos_docs neg_docs = M.mapWithKey (\ngram _ -> ((posFreq M.! ngram) / ((posFreq M.! ngram) + (negFreq M.! ngram)))) usable_ngrams
    where
    posFreq = fst $ getNgramFrequencies pos_docs
    negFreq = fst $ getNgramFrequencies neg_docs
    usable_ngrams = M.intersection posFreq negFreq

getNgramProbabilities docs = M.map ( / total_ngrams) freq
    where (freq, total_ngrams) = getNgramFrequencies docs
