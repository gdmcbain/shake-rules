module Development.Shake.Clean (cleanRules) where

import Development.Shake
import Development.Shake.FilePath
import Development.Shake.Compile

{- To use this, just import Development.Shake.Clean and put, e.g.,
 -
 -     cleanRules ["*.py"]
 -
 - under the "do" in the main in the Build.hs script.  cleanRules
 - needs a list of FilePatterns so if there's nothing else to be
 - cleaned just put an empty list; i.e. "clean []".
 -}  

clean :: [FilePattern] -> Rules ()
clean patterns = "clean" ~> do
  need ["hlint", "PEP-8"]   -- see cleanRules
  removeFilesAfter "." $ "*~" : patterns

hlint :: Rules ()
hlint = "hlint" ~> cmd "hlint" "."

pep8 :: Rules ()
pep8 = "PEP-8" ~> cmd "flake8" "."

cleanRules :: [FilePattern] -> Rules ()
cleanRules patterns = do
  clean patterns
  hlint
  pep8
  compile
