module Development.Shake.LaTeX (latexRules) where

import Development.Shake
import Development.Shake.FilePath

rubber :: Rules ()
rubber = "*.pdf" %> \pdf -> do
  let [src, bbl] = map (pdf -<.>) ["tex", "bbl"]
  need [src, bbl]
  cmd "rubber" "-d" src

aux :: Rules ()
aux = "*.aux" %> \aux -> do
  let tex = aux -<.> "tex"
  need [tex]
  cmd "latex" tex

bibtex :: Rules ()
bibtex = "*.bbl" %> \bbl -> do
  let [aux, bib] = map (bbl -<.>) ["aux", "bib"]
  need [aux, bib]
  cmd "bibtex" aux

bibs :: Rules ()
bibs = "*.bib" %> \bib -> do
  let dir = "bibtex"
  bibs <- getDirectoryFiles dir ["*.bib"]
  Stdout out <- cmd "cat" $ map (dir </>) bibs
  writeFileChanged bib out

latexRules :: Rules ()
latexRules = do
  rubber
  aux
  bibtex
  bibs
