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

import std/[unittest, options]
import moepkg/[unicodeext, editorstatus, gapbuffer]

import moepkg/searchutils {.all.}

suite "search.nim: searchLine":
  test "searchLine":
    let
      line = ru"abc efg hijkl"
      isIgnorecase = true
      isSmartcase = true
      position = line.searchLine(ru"ijk", isIgnorecase, isSmartcase)

    check position.get == 9

  test "searchLine 2":
    let
      line = ru"abc efg hijkl"
      isIgnorecase = true
      isSmartcase = true
      position = line.searchLine(ru"xyz", isIgnorecase, isSmartcase)

    check position.isNone

  test "Enable ignorecase, disable smartcase":
    let
      line = ru"Editor editor"
      isIgnorecase = true
      isSmartcase = true
      position = line.searchLine(ru"editor", isIgnorecase, isSmartcase)

    check position.get == 0

  test "Enable ignorecase and smartcase":
    block:
      let
        line = ru"editor Editor"
        isIgnorecase = true
        isSmartcase = true
        position = line.searchLine(ru"Editor", isIgnorecase, isSmartcase)

      check position.get == 7

    block:
      let
        line = ru"editor Editor"
        isIgnorecase = true
        isSmartcase = true
        position = line.searchLine(ru"editor", isIgnorecase, isSmartcase)

      check position.get == 0

  test "Disable ignorecase":
    let
      line = ru"Editor"
      isIgnorecase = false
      isSmartcase = false
      position = line.searchLine(ru"editor", isIgnorecase, isSmartcase)

    check position.isNone

suite "search.nim: searchLineReversely":
  test "searchLineReversely":
    let
      line = ru"abc efg hijkl"
      isIgnorecase = true
      isSmartcase = true
      position = line.searchLineReversely(ru"ijk", isIgnorecase, isSmartcase)

    check position.get == 9

  test "searchLineReversely 2":
      let
        line = ru"abc efg hijkl"
        keyword = ru"xyz"
        isIgnorecase = true
        isSmartcase = true
        position = line.searchLineReversely(keyword, isIgnorecase, isSmartcase)

      check position.isNone

suite "search.nim: searchBuffer":
  test "searchBuffer":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi jkl"
      line3 = ru"mno pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"i j"
      isIgnorecase = true
      isSmartcase = true
      searchResult = currentBufStatus.searchBuffer(
        currentMainWindowNode, keyword, isIgnorecase, isSmartcase)

    check searchResult.get.line == 1
    check searchResult.get.column == 2

  test "searchBuffer 2":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi jkl"
      line3 = ru"mno pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"xyz"
      isIgnorecase = true
      isSmartcase = true
      searchResult = currentBufStatus.searchBuffer(
        currentMainWindowNode, keyword, isIgnorecase, isSmartcase)

    check searchResult.isNone

suite "search.nim: searchBufferReversely":
  test "searchBufferReversely":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi jkl"
      line3 = ru"mno pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"i j"
      isIgnorecase = true
      isSmartcase = true
      searchResult = currentBufStatus.searchBufferReversely(
        currentMainWindowNode,
        keyword,
        isIgnorecase,
        isSmartcase)

    check searchResult.get.line == 1
    check searchResult.get.column == 2

  test "searchBufferReversely 2":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi jkl"
      line3 = ru"mno pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"xyz"
      isIgnorecase = true
      isSmartcase = true
      searchResult = currentBufStatus.searchBufferReversely(
        currentMainWindowNode,
        keyword,
        isIgnorecase,
        isSmartcase)

    check searchResult.isNone

suite "search.nim: searchAllOccurrence":
  test "searchAllOccurrence":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi abc"
      line3 = ru"abc pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"abc"
      buffer = status.bufStatus[0].buffer
      isIgnorecase = true
      isSmartcase = true
      searchResult = buffer.searchAllOccurrence(
        keyword,
        isIgnorecase,
        isSmartcase)

    check searchResult.len == 3

    check searchResult[0].line == 0
    check searchResult[0].column == 0

    check searchResult[1].line == 1
    check searchResult[1].column == 4

    check searchResult[2].line == 2
    check searchResult[2].column == 0

  test "searchAllOccurrence 2":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin

    let
      line1 = ru"abc def"
      line2 = ru"ghi abc"
      line3 = ru"abc pqr"
    status.bufStatus[0].buffer = initGapBuffer(@[line1, line2, line3])

    let
      keyword = ru"xyz"
      buffer = status.bufStatus[0].buffer
      isIgnorecase = true
      isSmartcase = true
      searchResult = buffer.searchAllOccurrence(
        keyword,
        isIgnorecase,
        isSmartcase)

    check searchResult.len == 0
