from strutils import parseInt
import bigints

proc computeFactorialDigitSum(n: int): int =
  var prod = initBigInt(1)
  for i in 2..n:
    prod *= initBigInt(i)
  for c in prod.toString():
    result += ord(c) - ord('0')



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeFactorialDigitSum(n)))
