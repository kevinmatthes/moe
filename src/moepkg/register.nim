import options, strutils
import unicodeext, independentutils, ui

type Register* = object
  buffer*: seq[seq[Rune]]
  isLine*: bool
  name*: string

type Registers* = object
  noNameRegister*: Register
  smallDeleteRegister: Register
  numberRegister*: array[10, Register]
  namedRegister*: seq[Register]

# Add/Overwrite the number register
proc addRegister(registers: var Registers,
                 r: Register,
                 isDelete: bool) =

  if isDelete:
    # If the buffer is deleted line, write to the register 1.
    # Previous registers are stored 2 ~ 9.
    if r.isLine:
      for i in countdown(8, 1):
        registers.numberRegister[i + 1] = registers.numberRegister[i]
      registers.numberRegister[1] = r
    else:
      registers.smallDeleteRegister = r
  else:
    # If the buffer is yanked line, overwrite the register 0.
    registers.numberRegister[0] = r

  registers.noNameRegister = r

proc addRegister*(registers: var Registers, buffer: seq[Rune]) =
  let r = Register(buffer: @[buffer], isLine: false)
  const isDelete = false
  registers.addRegister(r, isDelete)

proc addRegister*(registers: var Registers,
                  buffer: seq[Rune],
                  isLine: bool) =

  let r = Register(buffer: @[buffer], isLine: isLine)
  const isDelete = false
  registers.addRegister(r, isDelete)

proc addRegister*(registers: var Registers, buffer: seq[seq[Rune]]) =
  let r = Register(buffer: buffer, isLine: true)
  const isDelete = false
  registers.addRegister(r, isDelete)

proc addRegister*(registers: var Registers,
                  buffer: seq[seq[Rune]],
                  isLine: bool) =

  let r = Register(buffer: buffer, isLine: isLine)
  const isDelete = false
  registers.addRegister(r, isDelete)

proc addRegister*(registers: var Registers,
                  buffer: seq[Rune],
                  isLine, isDelete: bool) =

  let r = Register(buffer: @[buffer], isLine: isLine)
  registers.addRegister(r, isDelete)

proc addRegister*(registers: var Registers,
                  buffer: seq[seq[Rune]],
                  isLine, isDelete: bool) =

  let r = Register(buffer: buffer, isLine: isLine)
  registers.addRegister(r, isDelete)

proc addRegister(registers: var Registers, register: Register) =
  let name = register.name

  if name != "_":
    # Add/Overwrite the named register
    var isOverwrite = false

    # Overwrite the register if exist the same name.
    for i, r in registers.namedRegister:
      if r.name == name:
        registers.namedRegister[i] = register
      isOverwrite = true

    if not isOverwrite:
      registers.namedRegister.add register

    registers.noNameRegister = register

# Add/Overwrite the named register
proc addRegister*(registers: var Registers,
                  buffer: seq[Rune],
                  name: string) =

  if name.len > 0:
    let register = Register(buffer: @[buffer], isLine: false, name: name)
    registers.addRegister(register)

proc addRegister*(registers: var Registers,
                  buffer: seq[Rune],
                  isLine: bool,
                  name: string) =

  if name.len > 0:
    let register = Register(buffer: @[buffer], isLine: isLine, name: name)
    registers.addRegister(register)

proc addRegister*(registers: var Registers,
                  buffer: seq[seq[Rune]],
                  name: string) =

  if name.len > 0:
    let register = Register(buffer: buffer, isLine: true, name: name)
    registers.addRegister(register)

proc addRegister*(registers: var Registers,
                  buffer: seq[seq[Rune]],
                  isLine: bool,
                  name: string) =

  if name.len > 0:
    let register = Register(buffer: buffer, isLine: isLine, name: name)
    registers.addRegister(register)

# Search a register by the string
proc searchByName*(registers: Registers, name: string): Option[Register] =
  if name == "-":
    let r = registers.smallDeleteRegister
    if r.buffer.len > 0:
      return some(r)
  elif isInt(name):
    # Search a register in the number register
    let
      number = name.parseInt
      r = registers.numberRegister[number]
    if r.buffer.len > 0:
      return some(r)
  else:
    # Search a register in the named register
    for r in registers.namedRegister:
      if r.name == name:
        return some(r)
