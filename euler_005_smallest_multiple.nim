from strutils import parseInt

proc gcd(a, b: int): int =
  var
    a = a
    b = b
  while b != 0:
    let t = b
    b = a mod b
    a = t
  result = a

proc lcm(a, b: int): int =
  result = a div gcd(a, b) * b

proc computeSmallestMultiple(n: int): int =
  result = 1

  for k in 2..n:
    result = lcm(result, k)



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeSmallestMultiple(n)))
