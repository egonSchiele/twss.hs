# twss.hs

## Usage

```haskell
import Twss

main = do
    pos <- readTrainingData "positive"
    neg <- readTrainingData "negative"
  input <- getLine
  print $ isTwss pos neg input
  print $ isTwssProbability pos neg input -- show the probability of this being a twss
```

## Executable

Installing this will give you a `twss` executable:

    twss <string>

## Credits
This is a port of DanielRapp's [twss.js](https://github.com/DanielRapp/twss.js) by Aditya Bhargava.
