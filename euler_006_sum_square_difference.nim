from strutils import parseInt

proc computeSumSquareDifference(n: int): int =
  var sumOfSquares, squareOfSum: int
  for i in 1..n:
    sumOfSquares += i * i
    squareOfSum += i
  squareOfSum *= squareOfSum
  result = squareOfSum - sumOfSquares


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeSumSquareDifference(n)))
