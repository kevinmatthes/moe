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

import std/[unittest, options, os, importutils]
import pkg/results
import moepkg/[editor, gapbuffer, bufferstatus, editorview, unicodeext, ui,
               highlight, windownode, movement, build, backgroundprocess]

import moepkg/editorstatus {.all.}

proc resize(status: var EditorStatus, h, w: int) =
  updateTerminalSize(h, w)
  status.resize

suite "Open new buffers in the current window":
  test "Open 2 buffers":
    var status = initEditorStatus()
    status.settings.view.sidebar = false

    status.addNewBufferInCurrentWin
    status.resize(100, 100)
    status.update

    block:
      check status.bufStatus.len == 1

      check mainWindowNode.getAllWindowNode.len == 1
      check currentMainWindowNode.view.sidebar.isNone

    status.addNewBufferInCurrentWin
    status.resize(100, 100)
    status.update

    block:
      check status.bufStatus.len == 2

      check mainWindowNode.getAllWindowNode.len == 1
      check currentMainWindowNode.view.sidebar.isNone

  test "Add 2 buffers with Sidebar":
    var status = initEditorStatus()
    status.settings.view.sidebar = true

    status.addNewBufferInCurrentWin
    status.resize(100, 100)
    status.update

    block:
      check status.bufStatus.len == 1

      check mainWindowNode.getAllWindowNode.len == 1
      check currentMainWindowNode.view.sidebar.isSome

    status.addNewBufferInCurrentWin
    status.resize(100, 100)
    status.update

    block:
      check status.bufStatus.len == 2

      check mainWindowNode.getAllWindowNode.len == 1
      check currentMainWindowNode.view.sidebar.isSome

  test "Add new buffer (Dir)":
    var status = initEditorStatus()

    status.addNewBufferInCurrentWin("./")

    status.resize(100, 100)
    status.update

test "Add new buffer and update editor view when disabling current line highlighting (Fix #1189)":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.settings.view.highlightCurrentLine = false

  status.resize(100, 100)
  status.update

test "Vertical split window":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.resize(100, 100)
  status.verticalSplitWindow

test "Horizontal split window":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.resize(100, 100)
  status.horizontalSplitWindow

test "resize 1":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.resize(100, 100)
  currentBufStatus.buffer = initGapBuffer(@[ru"a"])

  currentMainWindowNode.highlight =
    initHighlight($currentBufStatus.buffer,
    status.settings.highlight.reservedWords,
    currentBufStatus.language)

  currentMainWindowNode.view =
    initEditorView(currentBufStatus.buffer, 1, 1)

  status.resize(0, 0)

test "resize 2":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.resize(100, 100)
  currentBufStatus.buffer = initGapBuffer(@[ru"a"])

  currentMainWindowNode.highlight =
    initHighlight($currentBufStatus.buffer,
    status.settings.highlight.reservedWords,
    currentBufStatus.language)

  currentMainWindowNode.view =
    initEditorView(currentBufStatus.buffer, 20, 4)

  status.resize(20, 4)

  currentMainWindowNode.currentColumn = 1
  status.changeMode(Mode.insert)

  for i in 0 ..< 10:
    currentBufStatus.keyEnter(
      currentMainWindowNode,
      status.settings.autoCloseParen,
      status.settings.tabStop)
    status.update

test "Auto delete paren 1":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"()"])
    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"()"])
    currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"")

test "Auto delete paren 2":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(())"])

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(())"])
    currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(())"])

    for i in 0 ..< 2:
     currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(())"])
    for i in 0 ..< 3:
      currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

test "Auto delete paren 3":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin

    currentBufStatus.buffer = initGapBuffer(@[ru"(()"])

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(()"])
    currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"(")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(()"])
    for i in 0 ..< 2:
      currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"(")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"())"])

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru")")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"())"])
    currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru")")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"())"])

    for i in 0 ..< 3:
      currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"()")

test "Auto delete paren 4":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(", ru")"])

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"")
    check(currentBufStatus.buffer[1] == ru"")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(", ru")"])
    currentBufStatus.keyDown(currentMainWindowNode)

    currentBufStatus.deleteCharacter(
      currentMainWindowNode.currentLine,
      currentMainWindowNode.currentColumn,
      status.settings.autoDeleteParen)

    check(currentBufStatus.buffer[0] == ru"")
    check(currentBufStatus.buffer[1] == ru"")

test "Auto delete paren 5":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"()"])
    status.changeMode(Mode.insert)
    currentBufStatus.keyRight(currentMainWindowNode)
    currentBufStatus.keyBackspace(currentMainWindowNode,
                                  status.settings.autoDeleteParen,
                                  status.settings.tabStop)

    check(currentBufStatus.buffer[0] == ru"")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"()"])
    status.changeMode(Mode.insert)
    for i in 0 ..< 2:
      currentBufStatus.keyRight(currentMainWindowNode)
    currentBufStatus.keyBackspace(currentMainWindowNode,
                                  status.settings.autoDeleteParen,
                                  status.settings.tabStop)

    check(currentBufStatus.buffer[0] == ru"")

test "Auto delete paren 6":
  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(a(a))"])

    status.changeMode(Mode.insert)

    for i in 0 ..< 5:
      currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.keyBackspace(currentMainWindowNode,
                                  status.settings.autoDeleteParen,
                                  status.settings.tabStop)

    check(currentBufStatus.buffer[0] == ru"(aa)")

  block:
    var status = initEditorStatus()
    status.settings.autoDeleteParen = true

    status.addNewBufferInCurrentWin
    currentBufStatus.buffer = initGapBuffer(@[ru"(a(a))"])

    status.changeMode(Mode.insert)

    for i in 0 ..< 6:
      currentBufStatus.keyRight(currentMainWindowNode)

    currentBufStatus.keyBackspace(currentMainWindowNode,
                                  status.settings.autoDeleteParen,
                                  status.settings.tabStop)

    check(currentBufStatus.buffer[0] == ru"a(a)")

test "Write tab line":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin("test.txt")

  status.resize(100, 100)

  check(status.tabWindow.width == 100)

test "Close window":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin
  status.resize(100, 100)
  status.verticalSplitWindow
  status.closeWindow(currentMainWindowNode)

test "Close window 2":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin

  status.resize(100, 100)
  status.update

  status.horizontalSplitWindow
  status.resize(100, 100)
  status.update

  status.closeWindow(currentMainWindowNode)
  status.resize(100, 100)
  status.update

  let windowNodeList = mainWindowNode.getAllWindowNode

  check(windowNodeList.len == 1)

  check(currentMainWindowNode.h == 98)
  check(currentMainWindowNode.w == 100)

test "Close window 3":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin

  status.resize(100, 100)
  status.update

  status.verticalSplitWindow
  status.resize(100, 100)
  status.update

  status.horizontalSplitWindow
  status.resize(100, 100)
  status.update

  status.closeWindow(currentMainWindowNode)
  status.resize(100, 100)
  status.update

  let windowNodeList = mainWindowNode.getAllWindowNode

  check(windowNodeList.len == 2)

  for n in windowNodeList:
    check(n.w == 50)
    check(n.h == 98)

test "Close window 4":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin

  status.resize(100, 100)
  status.update

  status.horizontalSplitWindow
  status.resize(100, 100)
  status.update

  status.verticalSplitWindow
  status.resize(100, 100)
  status.update

  status.closeWindow(currentMainWindowNode)
  status.resize(100, 100)
  status.update

  let windowNodeList = mainWindowNode.getAllWindowNode

  check(windowNodeList.len == 2)

  check(windowNodeList[0].w == 100)
  check(windowNodeList[0].h == 49)

  check(windowNodeList[1].w == 100)
  check(windowNodeList[1].h == 49)

test "Close window 5":
  var status = initEditorStatus()
  status.addNewBufferInCurrentWin("test.nim")

  status.resize(100, 100)
  status.update

  status.verticalSplitWindow
  status.resize(100, 100)
  status.update

  status.moveCurrentMainWindow(1)
  status.addNewBufferInCurrentWin("test2.nim")
  status.changeCurrentBuffer(1)
  status.resize(100, 100)
  status.update

  status.closeWindow(currentMainWindowNode)
  status.resize(100, 100)
  status.update

  check(currentMainWindowNode.bufferIndex == 0)

# Fix #611
test "Change current buffer":
  var status = initEditorStatus()

  status.addNewBufferInCurrentWin
  currentBufStatus.path = ru"test"
  currentBufStatus.buffer = initGapBuffer(@[ru"", ru"abc"])

  status.resize(100, 100)
  status.update

  let
    currentLine = currentBufStatus.buffer.high
    currentColumn = currentBufStatus.buffer[currentLine].high
  currentMainWindowNode.currentLine = currentLine
  currentMainWindowNode.currentColumn = currentColumn

  status.addNewBufferInCurrentWin
  currentBufStatus.path = ru"test2"
  currentBufStatus.buffer =  initGapBuffer(@[ru""])

  status.changeCurrentBuffer(1)

  status.resize(100, 100)
  status.update

suite "editorstatus: Updates/Restore the last cursor postion":
  test "Update the last cursor position (3 lines)":
    var status = initEditorStatus()

    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[ru "a", ru "bcd", ru "e"])
    currentMainWindowNode.currentLine = 1
    currentMainWindowNode.currentColumn = 1

    status.updateLastCursorPostion

    privateAccess(status.lastPosition[0].type)

    check status.lastPosition[0].path == absolutePath("test.nim").ru
    check status.lastPosition[0].line == 1
    check status.lastPosition[0].column == 1

  test "Update and restore the last cursor position (3 lines and edit the buffer after save)":
    var status = initEditorStatus()

    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[ru "a", ru "bcd", ru "e"])
    currentMainWindowNode.currentLine = 1
    currentMainWindowNode.currentColumn = 1

    status.resize(100, 100)
    status.update

    status.updateLastCursorPostion

    # Edit buffer after update the last cursor position
    currentBufStatus.buffer[1] = ru ""

    currentMainWindowNode.restoreCursorPostion(currentBufStatus,
                                               status.lastPosition)
    status.update

    currentMainWindowNode.currentLine = 1
    currentMainWindowNode.currentColumn = 0

  test "Update and restore the last cursor position (3 lines and last line is empty)":
    var status = initEditorStatus()

    status.addNewBufferInCurrentWin("test.nim")

    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[ru "a", ru "bcd", ru ""])

    status.resize(100, 100)
    status.update

    currentMainWindowNode.currentLine = currentBufStatus.buffer.high
    status.update

    status.updateLastCursorPostion

    currentMainWindowNode.restoreCursorPostion(currentBufStatus,
                                               status.lastPosition)

    status.update

    currentMainWindowNode.currentLine = 2
    currentMainWindowNode.currentColumn = 0

suite "Fix #1361":
  test "Insert a character after split window":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[ru ""])

    status.resize(100, 100)
    status.update

    status.verticalSplitWindow

    const key = ru 'a'
    currentBufStatus.insertCharacter(
      currentMainWindowNode,
      status.settings.autoCloseParen,
      key)

    status.update

    let nodes = mainWindowNode.getAllWindowNode
    check nodes[0].highlight == nodes[1].highlight

suite "BackgroundTasks":
  const
    TestDir = "./backgroundTasksTest"
    TestFilePath = TestDir / "test.nim"
    Buffer = "echo 1"

  setup:
    createDir(TestDir)
    writeFile(TestFilePath, Buffer)

  teardown:
    removeDir(TestDir)

  test "checkBackgroundBuild 1":
    var status = initEditorStatus()
    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[Buffer.toRunes])

    status.backgroundTasks.build.add startBackgroundBuild(
      TestFilePath.toRunes,
      currentBufStatus.language).get

    for i in 0 .. 10:
      sleep 1000

      status.checkBackgroundBuild
      if status.backgroundTasks.build.len == 0:
        break

    if status.backgroundTasks.build.len > 0:
      status.backgroundTasks.build[0].process.kill
      check false

  test "checkBackgroundBuild 2":
    ## Exec background builds twice.

    var status = initEditorStatus()
    status.addNewBufferInCurrentWin("test.nim")
    currentBufStatus.buffer = initGapBuffer(@[Buffer.toRunes])

    for i in 0 .. 1:
      status.backgroundTasks.build.add startBackgroundBuild(
        TestFilePath.toRunes,
        currentBufStatus.language).get

    for i in 0 .. 10:
      sleep 1000

      status.checkBackgroundBuild
      if status.backgroundTasks.build.len == 0:
        break

    if status.backgroundTasks.build.len > 0:
      for i in 0 ..< status.backgroundTasks.build.len:
        status.backgroundTasks.build[i].process.kill

      check false
