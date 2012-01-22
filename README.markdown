# twss.hs

## Usage

	import Twss

	main = do
		input <- getLine
		putStrLn $ show $ isTwss input
		putStrLn $ show $ isTwssProbability input

## Demo

Use `demo.hs` to watch it in action:

	runhaskell demo.hs


## Important Note!
Thinking of using the `-XNoMonomorphismRestriction` flag with this code? *BAD IDEA*, it will grind to a halt. Please don't do it. [See here if you don't know what the flag does.](http://stackoverflow.com/questions/4575040/what-is-xnomonomorphismrestriction).


## Credits
This is a port of DanielRapp's [twss.js](https://github.com/DanielRapp/twss.js) by Aditya Bhargava.
