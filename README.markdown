# twss.hs

## Usage

	import Twss

	main = do
	    pos <- readTrainingData "positive"
	    neg <- readTrainingData "negative"
		input <- getLine
		putStrLn $ show $ isTwss pos neg input
		putStrLn $ show $ isTwssProbability pos neg input -- show the probability of this being a twss

## Example

Use `Main.hs` to watch it in action:

	runhaskell Main.hs <string>

## Credits
This is a port of DanielRapp's [twss.js](https://github.com/DanielRapp/twss.js) by Aditya Bhargava.
