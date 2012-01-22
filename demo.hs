import Twss

result True = "That's What She Said!"
result False = "That's Not What She Said :("

main = do
    putStrLn "Please enter a line:"
    input <- getLine
    putStrLn $ result $ isTwss input
