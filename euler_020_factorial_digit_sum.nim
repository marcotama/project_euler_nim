from strutils import parseInt
import bigints

proc computeFactorialDigitSum(n: int): int =
  var prod = initBigInt(1)
  for i in 2..n:
    prod *= initBigInt(i)
  for c in prod.toString():
    result += ord(c) - ord('0')



when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeFactorialDigitSum(n)))
