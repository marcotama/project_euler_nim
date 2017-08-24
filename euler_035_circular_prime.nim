from strutils import parseInt
import math
from factorization import isPrime


proc computeCircularPrime(n: int): int =
  for k in 1..n:
    let ks = $k
    block testing:
      for i in 1..(ks).len:
        if not isPrime(parseInt(ks[i..<ks.len] & ks[0..<i])):
          break testing
      result += 1



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeCircularPrime(n)))
