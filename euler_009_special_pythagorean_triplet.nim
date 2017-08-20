from strutils import parseInt
from math import sqrt

proc computeSpecialPythagoreanTriplet(n: int): int =
  result = -1
  for a in 1..n:
    for b in a+1..n:
      let c = n - a - b
      if a * a + b * b == c * c:
        result = a * b * c
        return


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeSpecialPythagoreanTriplet(n)))
