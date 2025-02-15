#[###################### GNU General Public License 3.0 ######################]#
#                                                                              #
#  Copyright (C) 2017─2023 Shuhei Nogawa                                       #
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

import std/[unittest, strutils]
import moepkg/[highlight, color]
import moepkg/syntax/highlite

const reservedWords = @[
  ReservedWord(word: "WIP", color: EditorColorPairIndex.reservedWord)
]

test "initHighlight: start with newline":
  let
    code = "\x0Aproc test =\x0A  echo \"Hello, world!\""
    buffer = split(code, '\n')
    highlight = initHighlight(code,
                              reservedWords,
                              SourceLanguage.langNim)

  # unite segments
  var unitedStr: string
  for i in 0 ..< highlight.len:
    let segment = highlight[i]
    if i > 0 and segment.firstRow != highlight[i-1].lastRow: unitedStr &= "\n"
    let
      firstRow = segment.firstRow
      firstColumn = segment.firstColumn
      lastColumn = segment.lastColumn
    unitedStr &= buffer[firstRow][firstColumn .. lastColumn]

  check(unitedStr == code)

test "indexOf: basic":
  let
    code = "proc test =\x0A  echo \"Hello, world!\""
    highlight = initHighlight(code,
                              reservedWords,
                              SourceLanguage.langNim)

  check(highlight.indexOf(0, 0) == 0)

test "indexOf: start with newline":
  let
    code = "\x0Aproc test =\x0A  echo \"Hello, world!\""
    highlight = initHighlight(code,
                              reservedWords,
                              SourceLanguage.langNim)

  check(highlight.indexOf(0, 0) == 0)

test "over write":
  let code = "　"
  var highlight = initHighlight(code,
                                reservedWords,
                                SourceLanguage.langNone)

  let colorSegment = ColorSegment(firstRow: 0,
                                firstColumn: 0,
                                lastRow: 0,
                                lastColumn: 0,
                                color: EditorColorPairIndex.highlightFullWidthSpace)

  highlight.overwrite(colorSegment)

  check(highlight.len == 1)
  check(highlight[0].firstRow == 0)
  check(highlight[0].firstColumn == 0)
  check(highlight[0].lastRow == 0)
  check(highlight[0].lastColumn == 0)
  check(highlight[0].color == EditorColorPairIndex.highlightFullWidthSpace)

# Fix #733
test """Highlight "echo \"""":
  const code = """echo "\""""
  discard initHighlight(code,
                        reservedWords,
                        SourceLanguage.langNim)

test "initHighlight shell script (Fix #1166)":
  const code = "echo hello"
  let r = initHighlight(code,
                        reservedWords,
                        SourceLanguage.langShell)

  check r.len > 0

test "Nim pragma":
  const code = """{.pragma.}""""
  let highlight = initHighlight(
    code,
    reservedWords,
    SourceLanguage.langNim)

  check highlight[2] == ColorSegment(firstRow: 0, firstColumn: 2, lastRow: 0, lastColumn: 7, color: EditorColorPairIndex.pragma)

test "Fix #1524":
  # https://github.com/fox0430/moe/issues/1524

  const code = "test: '0'"
  let highlight = initHighlight(
    code,
    reservedWords,
    SourceLanguage.langYaml)

  check highlight == Highlight(
    colorSegments: @[
      ColorSegment(firstRow: 0, firstColumn: 0, lastRow: 0, lastColumn: 3, color: EditorColorPairIndex.default),
      ColorSegment(firstRow: 0, firstColumn: 4, lastRow: 0, lastColumn: 4, color: EditorColorPairIndex.default),
      ColorSegment(firstRow: 0, firstColumn: 5, lastRow: 0, lastColumn: 5, color: EditorColorPairIndex.default),
      ColorSegment(firstRow: 0, firstColumn: 6, lastRow: 0, lastColumn: 8, color: EditorColorPairIndex.default)])

test "Only '/' in Clang":
  # https://github.com/fox0430/moe/issues/1568

  const
    code = "/"
    emptyReservedWords = @[]
  let highlight = initHighlight(
    code,
    emptyReservedWords,
    SourceLanguage.langC)

  check highlight == Highlight(
    colorSegments: @[
      ColorSegment(firstRow: 0, firstColumn: 0, lastRow: 0, lastColumn: 0, color: EditorColorPairIndex.default)])
