module Development.Shake.LaTeX (latexRules) where

import Development.Shake
import Development.Shake.FilePath

dvipdf :: [FilePath] -> Rules ()
dvipdf figures = "*.pdf" %> \pdf -> do
  let dvi = pdf -<.> "dvi"
  need $ dvi : figures
  cmd "dvipdf" dvi

rubber :: [FilePath] -> Rules ()
rubber figures = "*.dvi" %> \dvi -> do
  let [src, bbl] = map (dvi -<.>) ["tex", "bbl"]
  need $ src : bbl : figures
  cmd "rubber" src

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

latexRules :: [FilePath] -> Rules ()
latexRules figures = do
  dvipdf figures
  rubber figures
  aux
  bibtex
  bibs
