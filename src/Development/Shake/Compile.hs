module Development.Shake.Compile (compile) where

import Development.Shake
import Development.Shake.FilePath

compile :: Rules ()
compile = "compile" ~> do
    let script = "Build.hs"
        rtsopts = "-IO -qg -qb"
        outputdir = ".shake"
    need [script]
    () <- cmd "stack ghc -- --make -threaded -rtsopts"
              "-with-rtsopts" [rtsopts] [script]
              ("-outputdir=" ++ outputdir) "-o" (outputdir </> "build")
    removeFilesAfter "." $ map (script -<.>) ["hi", "o"]
