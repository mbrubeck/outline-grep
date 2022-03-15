#!/usr/bin/env runhaskell

This is a short program that acts like "grep," but treats its input as a
outline based on indentation, and preserves this structure in its output.

> import Control.Monad ((<=<), liftM)
> import Data.Char (isSpace)
> import Data.Foldable (Foldable, foldMap, toList)
> import Data.Monoid (mappend, mempty)
> import System.IO (Handle, hGetContents, openFile, IOMode(ReadMode), stdin)
> import System.Environment (getArgs)
> import Text.Regex.Posix ((=~))

An outline has three parts: The first node, its children (another outline),
and the remaining nodes (also an outline).  The outline with zero nodes is
called Empty.  An outline is basically a list of trees.

> data Outline a = Empty | Outline a (Outline a) (Outline a)

We define a fold method for outlines, so we can iterate over their elements.

> instance Foldable Outline where
>     foldMap f Empty = mempty
>     foldMap f (Outline a b c) = f a `mappend` foldMap f b `mappend` foldMap f c

This helper function tells if an outline is empty.

> empty Empty = True
> empty _     = False

We group input lines into nodes by the amount of leading whitespace.  A tab
counts the same as a space, so you may not want to mix tabs and spaces.

> indentLevel :: String -> Int
> indentLevel = length . takeWhile isSpace

readNodes reads a series of nodes starting at a specified column.  It returns
the nodes as an outline, along with any remaining lines.

> readNodes :: Int -> [String] -> (Outline String, [String])
> readNodes col []     = (Empty, [])
> readNodes col (x:xs) =
>     let n = indentLevel x in
>     if n < col then (Empty, x:xs)
>                else let (children, xs')  = readNodes (n+1) xs
>                         (rest,     xs'') = readNodes col   xs'
>                     in ((Outline x children rest), xs'')

To read an outline from a file, we read all the top-level nodes.

> readOutline :: String -> Outline String
> readOutline = fst . readNodes 0 . lines

To print an outline, we just turn it into a list and print each line.
(Indentation is preserved by the readOutline function.)

> prettyPrint :: Outline String -> String
> prettyPrint = unlines . toList

To prune an outline, we remove any subtree that contains no matching nodes.
This leaves the matching nodes and all their ancestors.

> prune :: (a -> Bool) -> Outline a -> Outline a
> prune p Empty = Empty
> prune p (Outline root children rest) =
>     let rest'     = prune p rest
>         children' = prune p children in
>     if p root || not (empty children')
>         then (Outline root children' rest')
>         else rest'

Our main program takes a regex as its first argument, and reads an outline
from the file named by the second argument (default stdin).  It prunes the
outline using the regex, and prints the result.

> main = do
>     (pattern:fileNames) <- getArgs
>     s <- input fileNames
>     putStr $ prettyPrint $ prune (=~ pattern) $ readOutline s

We concatenate all the named files, or read from stdin if there are none.

> input :: [String] -> IO String
> input []   = hGetContents stdin
> input args = concat `liftM` mapM (hGetContents <=< openFile `flip` ReadMode) args
