from strutils import parseInt
from math import sqrt

proc computeSummationOfPrimes(n: int): int =
  var
    primes = @[2]
    k = 1

  while k <= n - 2:
    k += 2
    var prime = true
    let limit = int(sqrt(float(k)))
    for d in primes:
      if d > limit:
        break
      if k mod d == 0:
        prime = false
        break
    if prime:
      primes.add(k)

  for p in primes:
    result += p



when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeSummationOfPrimes(n)))
