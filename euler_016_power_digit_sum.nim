from strutils import parseInt, split
from math import sqrt

const base = 10

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


proc doubleString(s: string): string =
  var
    revTot: seq[int] = @[]
    carry: int
  for i in 0..<s.len:
    var digitTot = carry
    let c = s[s.len-1-i]
    let v = ord(c) - ord('0')
    digitTot += 2 * v
    carry = addDigit(digitTot, revTot)

  while carry > 0:
    carry = addDigit(carry, revTot)

  result = newStringOfCap(revTot.len)
  for i in countdown(revTot.len-1, 0):
    result.add(char(ord('0') + revTot[i]))


proc computePowerDigitSum(n: int): int =
  var tmp = "1"
  for i in 1..n:
    tmp = doubleString(tmp)
  for c in tmp:
    result += ord(c) - ord('0')

when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computePowerDigitSum(n)))
