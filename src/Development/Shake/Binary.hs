module Development.Shake.Binary (namesBinary) where

import Development.Shake
import Development.Shake.FilePath

-- ‘Conditionally using the .exe extension with the Shake build system’

-- http://stackoverflow.com/questions/18712433/conditionally-using-the-exe-extension-with-the-shake-build-system

namesBinary :: FilePath -> Bool
namesBinary = (== exe) . drop 1 . takeExtension
