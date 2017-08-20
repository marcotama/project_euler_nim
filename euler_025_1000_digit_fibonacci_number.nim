from strutils import parseInt
import bigints

proc compute1000DigitFibonacciNumber(n: int): int =
  var
    f1 = initBigInt(0)
    f2 = initBigInt(1)
    i = 1
  while ($f2).len < n:
    let tmp = f1 + f2
    f1 = f2
    f2 = tmp
    i += 1
  return i



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(compute1000DigitFibonacciNumber(n)))
