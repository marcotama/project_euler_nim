from strutils import parseInt
from util import findAllFactorsUnsorted

proc computeHighlyDivisibleTriangularNumber(n: int): int =
  var
    factors: seq[int] = @[]
    triangularNumber = 0
    i = 1
  while factors.len <= n:
    triangularNumber += i
    factors = findAllFactorsUnsorted(triangularNumber)
    i += 1
  return triangularNumber


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeHighlyDivisibleTriangularNumber(n)))
