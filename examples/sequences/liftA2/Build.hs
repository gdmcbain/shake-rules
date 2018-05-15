#!/usr/bin/env stack
{-stack runhaskell
 --package shake
 -}

import Development.Shake
import Development.Shake.FilePath
import Development.Shake.Clean

import Control.Applicative (liftA2)

main :: IO ()
main = shakeArgs shakeOptions $ do
  want $ map (<.> "txt") $ liftA2 (++) ["a", "b"] (map show [0 .. 3])

  cleanRules ["*.txt"]

  "*.txt" %> cmd "touch"
