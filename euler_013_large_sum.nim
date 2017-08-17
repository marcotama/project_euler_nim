from strutils import parseInt, split
from math import sqrt

const base = 10
const linesLength = 50
const nDigits = 10


proc addDigit(digitAcc: var int, reversedTotal: var seq[int]): int =
  let doc = """
  Helper function. When summing n-th least significant digit of many numbers, you may exceed
  the capacity of your base (usually 10). This function takes the result of that sum, breaks
  it in two parts: least-significant digit and carry. It then appends the least significant
  digit at the end of a given sequence and returns the carry.

  You can use this function to build a reversed sequence representing the total of the sum.
  """

  let digitAccNoCarry = digitAcc mod base
  reversedTotal.add(digitAccNoCarry)
  return (digitAcc - digitAccNoCarry) div base



proc computeLargeSum(data: seq[string]): string =
  var
    revTot: seq[int] = @[]
    carry: int
  for i in 0..linesLength-1:
    var digitTot = carry
    for line in data:
      let c = line[line.len-1-i]
      let v = ord(c) - ord('0')
      digitTot += v
    carry = addDigit(digitTot, revTot)

  while carry > 0:
    carry = addDigit(carry, revTot)

  result = newStringOfCap(nDigits)
  for d in 1..10:
    result.add(char(ord('0') + revTot[revTot.len-d]))



when isMainModule:

  var data: seq[string] = @[]
  let nLines = parseInt(readLine(stdin))

  for i in 1..nLines:
    data.add(readLine(stdin))
  stdout.writeLine($(computeLargeSum(data)))
