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
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeEvenFibonacciNumbers(n)))
