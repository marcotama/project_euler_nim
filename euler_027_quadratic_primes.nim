from strutils import parseInt
from util import isPrime
import sets


proc countQuadraticPrimes(a, b: int, primes, notPrimes: var HashSet[int]): int =
  var n = 0
  while true:
    let tot = n * n + a * n + b
    if notPrimes.contains(tot):
      break
    elif primes.contains(tot):
      n += 1
    else:
      if isPrime(tot):
        primes.incl(tot)
        n += 1
      else:
        notPrimes.incl(tot)
        break
  return n


template testCombination(aa, bb: int) =
  n = countQuadraticPrimes(aa, bb, primes, nonPrimes)
  if maxN < n:
    maxN = n
    maxA = aa
    maxB = bb


proc computeQuadraticPrimes(limit: int): tuple[a: int, b: int] =
  var
    maxN = 0
    maxA = -1
    maxB = -1
    n = 0
    primes = initSet[int]()
    nonPrimes = initSet[int]()
  for a in 1..<limit:
    for b in 1..limit:
      testCombination(+a, +b)
      testCombination(+a, -b)
      testCombination(-a, +b)
      testCombination(-a, -b)
  return (maxA, maxB)



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    let result = computeQuadraticPrimes(n)
    stdout.writeLine($result.a & " " & $result.b)
