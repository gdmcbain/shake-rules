{-|
  To use this, just import Development.Shake.Gmsh and put, e.g.,
 
      gmshRules TwoD
 
  under the "do" in the main in the Build.hs script.  gmshRules needs the
  Dimension.
 -}

module Development.Shake.Gmsh (gmshRules, Dimension(..)) where
import Development.Shake
import Development.Shake.FilePath

data Dimension = ZeroD | OneD | TwoD | ThreeD deriving Enum

instance Show Dimension where
  show = ('-' :) . show . fromEnum

msh :: Dimension -> Rules ()
msh d = "*.msh" %> \msh -> do
  let geo = msh -<.> "geo"
  need [geo]
  gmshFlags <- getEnv "GMSHFLAGS"
  cmd "gmsh" (show d) gmshFlags [geo]

medit :: Dimension -> Rules ()
medit d = "*.medit" %> \medit -> do
  let geo = medit -<.> "geo"
  need [geo]
  gmshFlags <- getEnv "GMSHFLAGS"
  cmd "gmsh" (show d) gmshFlags
    "-format" "mesh" "-string" "Mesh.SaveElementTagType=2;"
    "-o" [medit] [geo] :: Action ()
  removeFilesAfter "." [medit]

mesh :: Dimension -> Rules ()

mesh ThreeD = "*.mesh" %> \mesh -> do
  let medit = mesh -<.> "medit"
  need [medit]
  copyFileChanged medit mesh

mesh TwoD = "*.mesh" %> \mesh -> do
  let medit = mesh -<.> "medit"
      script = "3to2.awk"   -- must be on AWKPATH
  need [medit]
  Stdout stdout <- cmd "gawk" "-f" script [medit]
  writeFileChanged mesh stdout

gmshRules :: Dimension -> Rules()
gmshRules d = do
  msh d
  medit d
  mesh d
