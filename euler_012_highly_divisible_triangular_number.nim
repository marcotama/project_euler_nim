from strutils import parseInt
from math import sqrt

proc countFactors(n: int): int =
  if n == 1:
    return 1
  for i in 1..int(sqrt(float(n))):
    if n mod i == 0:
      result += 2


proc computeHighlyDivisibleTriangularNumber(n: int): int =
  var
    nFactors = 0
    triangularNumber = 1
    i = 2
  while countFactors(triangularNumber) <= n:
    triangularNumber += i
    i += 1
  return triangularNumber


when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeHighlyDivisibleTriangularNumber(n)))
