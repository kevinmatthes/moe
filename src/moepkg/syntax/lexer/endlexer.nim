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

from ../highlite import
  GeneralTokenizer,
  TokenClass,
  eolChars,
  lwsChars



#
# Procedures.
#

## Proceed until the end of the current line.
##
## In case of line comments, the whole rest of the line belongs to the comment.
## Thus, until the end of line is reached, every character belongs to the
## line comment token.

proc endLine*(lexer: GeneralTokenizer, position: int): int =
  result = position

  while lexer.buf[result] notin eolChars:
    inc result



## Skip line whitespace characters, these are spaces and tabs.
##
## In most languages, the line whitespaces characters are unimportant for lexing
## the source code.  Thus, these characters can be savely skipped.

proc endLWS*(lexer: GeneralTokenizer, position: int): int =
  result = position

  while lexer.buf[result] in lwsChars:
    inc result

#[############################################################################]#
