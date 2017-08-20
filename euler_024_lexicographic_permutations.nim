from strutils import parseInt
from math import fac

proc computeLexicographicPermutations(n: int): string =
  var
    digits = @[0,1,2,3,4,5,6,7,8,9]
    n = n - 1
    s = ""
  for i in countdown(len(digits)-1,0):
    let
      r = fac(i)
      d = n div r
    s &= $digits[d]
    digits.delete(d)
    n -= d * r
  return s


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine(computeLexicographicPermutations(n))
