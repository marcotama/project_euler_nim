from strutils import parseInt

proc computeSumSquareDifference(n: int): int =
  var sumOfSquares, squareOfSum: int
  for i in 1..n:
    sumOfSquares += i * i
    squareOfSum += i
  squareOfSum *= squareOfSum
  result = squareOfSum - sumOfSquares


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeSumSquareDifference(n)))
