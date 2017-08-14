proc computeSum(n: int): int =
  for x in 3..<n:
    if x mod 3 == 0 or x mod 5 == 0:
      result += x


when isMainModule:
  from strutils import parseInt
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeSum(n)))
