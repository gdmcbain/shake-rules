{-|
  Files without extensions are tricky.  A common example is binaries in systems
  derived from Unix.  Adding to the trickiness in this case is that the
  extension varies between system.
  
  ‘Conditionally using the .exe extension with the Shake build system’

  http://stackoverflow.com/questions/18712433/conditionally-using-the-exe-extension-with-the-shake-build-system
-}

module Development.Shake.Binary (namesBinary) where

import Development.Shake
import Development.Shake.FilePath

-- | True as the extension matches that for a binary on the system.
namesBinary :: FilePath -> Bool
namesBinary = (== exe) . drop 1 . takeExtension
