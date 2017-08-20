from strutils import parseInt
from math import sqrt

proc computeLargestPrimeFactor(n: int): int =
  assert n > 0

  var
    n = n
    limit = n div 2
    d = 3
  result = n

  while n mod 2 == 0:
    result = 2
    n = n div 2

  while d <= limit:
    if n mod d == 0:
      n = n div d
      result = d
      limit = n
      continue
    d += 2


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeLargestPrimeFactor(n)))
