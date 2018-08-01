module Development.Shake.LaTeX (latexRules) where

import Development.Shake
import Development.Shake.FilePath

dvipdf :: Rules ()
dvipdf = "*.pdf" %> \pdf -> do
  let dvi = pdf -<.> "dvi"
  need [dvi]
  cmd "dvipdf" dvi

rubber :: Rules ()
rubber = "*.dvi" %> \dvi -> do
  let [src, bbl] = map (dvi -<.>) ["tex", "bbl"]
  need [src, bbl]
  cmd "rubber" src

aux :: [FilePath] -> Rules ()
aux figures = "*.aux" %> \aux -> do
  let tex = aux -<.> "tex"
  need $ tex : figures
  cmd "latex" tex

bibtex :: Rules ()
bibtex = "*.bbl" %> \bbl -> do
  let [aux, bib] = map (bbl -<.>) ["aux", "bib"]
  need [aux, bib]
  cmd "bibtex" aux

bibs :: Rules ()
bibs = "*.bib" %> \bib -> do
  let dir = "bibtex"
  bibs <- getDirectoryFiles "" [dir </> "*.bib"]
  Stdout out <- cmd (Stdin "") "cat" $ "-" : bibs
  writeFileChanged bib out

-- asymptote :: Rules ()
-- asymptote = "*.eps" %> \eps -> do
--   let asy = eps -<.> "asy"
--   need [asy]
--   cmd "asy" asy

latexRules :: [FilePath] -> Rules ()
latexRules figures = do
  dvipdf
  rubber
  aux figures
  bibtex
  bibs
  -- asymptote
