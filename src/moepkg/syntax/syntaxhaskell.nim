import highlite, syntaxc

const
  haskellKeywords* = [ "_"
                     , "case"
                     , "class"
                     , "data"
                     , "default"
                     , "deriving"
                     , "do"
                     , "else"
                     , "if"
                     , "import"
                     , "infix"
                     , "infixl"
                     , "infixr"
                     , "instance"
                     , "let"
                     , "module"
                     , "newtype"
                     , "of"
                     , "then"
                     , "type"
                     , "where"
                     ]

proc haskellNextToken*(g: var GeneralTokenizer) =
  clikeNextToken(g, haskellKeywords, {})
