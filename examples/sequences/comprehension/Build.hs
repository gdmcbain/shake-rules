#!/usr/bin/env stack
{-stack runhaskell
 --package shake
 -}

import Development.Shake
import Development.Shake.FilePath
import Development.Shake.Clean

main :: IO ()
main = shakeArgs shakeOptions $ do
  want [show n <.> "txt" | n <- [0..9]]

  cleanRules ["*.txt"]

  "*.txt" %> cmd "touch"
