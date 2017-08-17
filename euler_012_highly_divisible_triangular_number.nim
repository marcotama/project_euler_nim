from strutils import parseInt
from util import findFactorsDecomposition
import tables

proc computeHighlyDivisibleTriangularNumber(n: int): int =
  var
    nFactors = 0
    triangularNumber = 0
    i = 1
  while nFactors <= n:
    triangularNumber += i
    let factorsDecomposition = findFactorsDecomposition(triangularNumber)
    nFactors = 1
    for b, e in factorsDecomposition.pairs:
      nFactors *= e + 1
    i += 1
  return triangularNumber


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeHighlyDivisibleTriangularNumber(n)))
