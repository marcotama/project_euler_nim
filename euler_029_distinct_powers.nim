from util import findFactorsDecomposition
from strutils import parseInt
import sets
import tables

proc computeDistinctPowers(n: int): int =
  var d = initSet[string]()
  for a in 2..n:
    let factors = findFactorsDecomposition(a)
    for b in 2..n:
      var powerFactors = ""
      for f, e in factors:
        powerFactors &= $f & "," & $(b * e) & "|"
      if not d.contains(powerFactors):
        d.incl(powerFactors)
  return d.len


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeDistinctPowers(n)))
