module Analyze where

-- the array used in the foldl has the type [tp, fp, fn, tn]
getClassificationStats isClass trainingData validationData = foldl () [] validationData
    where ic = isClass --something
