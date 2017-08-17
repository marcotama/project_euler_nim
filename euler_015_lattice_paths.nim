from strutils import parseInt, split
import math
from util import findFactorsDecomposition
import tables


proc computeLatticePaths(n, r: int): int =
  # ideally
  # import math
  # return fac(n) div fac(r) div fac(n-r)
  # but values grow too large
  #
  # even this overflows
  # result = 1
  # for k in n-r+1..n:
  #  result *= k
  #
  # so we use keep factors and their powers separated
  var factors = initOrderedTable[int, int](nextPowerOfTwo(int(sqrt(float(n)))))

  # numerator
  for k in n-r+1..n:
    let kFactors = findFactorsDecomposition(k)
    for b, e in kFactors.pairs:
      if not factors.hasKey(b):
        factors[b] = 0
      factors[b] += e

  # denominator
  for k in 2..r:
    let kFactors = findFactorsDecomposition(k)
    for b, e in kFactors.pairs:
      factors[b] -= e

  # result
  result = 1
  for b, e in factors.pairs:
    for i in 1..e:
      result *= b


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let
      tmp = split(readLine(stdin), " ")
      n = parseInt(tmp[0])
      r = parseInt(tmp[1])
    stdout.writeLine($(computeLatticePaths(n + r, r)))
