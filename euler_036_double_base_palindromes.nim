from strutils import parseInt
import math
from util import isPalindrome, fromIntToBase


proc computeCircularPrime(n: int): int =
  for k in 1..n:
    if isPalindrome($k) and isPalindrome(fromIntToBase(k, 2)):
      result += k



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeCircularPrime(n)))
