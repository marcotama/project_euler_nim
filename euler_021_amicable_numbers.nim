from strutils import parseInt
import sequtils
import sets
from util import findAllFactorsSorted

proc computeAmicableNumbers(n: int): int =
  var amicable = initSet[int]()
  for p1 in 1..n:
    let
      p1f = findAllFactorsSorted(p1)
      p2 = foldl(p1f, a + b) - p1f[p1f.len-1]
      p2f = findAllFactorsSorted(p2)
      p3 = foldl(p2f, a + b) - p2f[p2f.len-1]
    if p3 == p1 and p1 != p2:
      amicable.incl(p1)
      amicable.incl(p2)
  for i in amicable.items():
    result += i



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeAmicableNumbers(n)))
