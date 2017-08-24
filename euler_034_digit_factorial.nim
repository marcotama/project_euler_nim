from strutils import parseInt
import math

proc computeDigitFactorial(n: int): int =
  for k in 10..n:
    var sum = 0
    for c in $k:
      sum += fac(ord(c) - ord('0'))
    if sum == k:
      result += k



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeDigitFactorial(n)))
