import sets
import sequtils
from util import findAllFactorsSorted

proc computeNonAbundantSums(): int =
  var abundant = initSet[int]()
  for n in 1..28123:
    let
      factors = findAllFactorsSorted(n)
      sum = foldl(factors, a + b) - n
    if sum > n:
      abundant.incl(n)

  for n in 1..28123:
    var can = false
    for a1 in abundant.items():
      if abundant.contains(n - a1):
        can = true
        break
    if not can:
      result += n


when isMainModule:
  stdout.writeLine($(computeNonAbundantSums()))
