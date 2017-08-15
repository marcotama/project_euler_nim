from strutils import parseInt

proc computeEvenFibonacciNumbers(n: int): int =
  var
    x1 = 0
    x2 = 1
  while x1 + x2 <= n:
    let x3 = x1 + x2
    if x3 mod 2 == 0:
      result += x3
    x1 = x2
    x2 = x3


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeEvenFibonacciNumbers(n)))
