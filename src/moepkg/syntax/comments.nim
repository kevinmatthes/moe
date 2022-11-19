#[###################### GNU General Public License 3.0 ######################]#
#                                                                              #
#  Copyright (C) 2017─2022 fox0430                                             #
#                                                                              #
#  This program is free software: you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation, either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.      #
#                                                                              #
#[############################################################################]#

#
# Resources.
#

from highlite import
  GeneralTokenizer,
  TokenClass,
  TokenizerFlag,
  TokenizerFlags,
  eolChars,



#
# Procedures.
#

## Proceed until the end of the current line.

proc endLine(tokeniser: GeneralTokenizer, initialPosition: int): int =
  var position = initialPosition

  while tokeniser.buf[position] notin eolChars:
    inc(position)

  result = position



## Parse a line introduced by two hash characters.
##
## This comment type is opened by ``##`` and automatically ended by the end of
## the respective line.
##
## Languages like Nim use this comment type for documentation comments.

proc parseDoubleHashLine(tokeniser: var GeneralTokenizer, initialPosition: int): int =
  var position = initialPosition

  if tokeniser.buf[position] == '#':
    tokeniser.kind = gtStringLit
    position = endLine(tokeniser, position)

  result = position



## Parse a shebang line.
##
## The shebang is special line on UNIX systems which is used to choose the
## appropriate interpreter for the given script.  By convention, it is always
## the first line of a script.  It is only relevant for just-in-time (JIT)
## compiled languages.
##
## A shebang always starts with ``#!`` and is ended automatically by the end of
## the line.  Due to the first character being the line comment trigger, the
## shebang will be ignored on platforms which do not support shebangs.

proc parseShebangLine(tokeniser: var GeneralTokenizer,
    initialPosition: int): int =
  var position = initialPosition

  if tokeniser.buf[position] == '!':
      tokeniser.kind = gtPreprocessor
      position = endLine(tokeniser, position)

  result = position



## Parse a line comment, opened by a single hash character.
##
## This comment type starts with a ``#`` and lasts until the end of the line.
##
## Every language with line comments introduced by ``#`` should enter the
## comment parsing by this procedure as a redirection will take place in case
## that the current line is actually another comment type.

proc parseHashLineComment*(tokeniser: var GeneralTokenizer,
    initialPosition: int, flags: TokenizerFlags): int =
  var position = initialPosition

  if tokeniser.buf[position] == '#':
    tokeniser.kind = gtComment
    inc(position)

    case tokeniser.buf[position]
    of '#':
      if hasDoubleHashComments in flags:
        position = parseDoubleHashLine(tokeniser, position)
      else:
        position = endLine(tokeniser, position)

    of '!':
      if hasShebang in flags:
        position = parseShebangLine(tokeniser, position)
      else:
        position = endLine(tokeniser, position)

    else:
      position = endLine(tokeniser, position)

  result = position

#[############################################################################]#
