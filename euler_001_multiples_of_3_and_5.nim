from strutils import parseInt

proc computeMultiplesOf3And5(n: int): int =
  for x in 3..<n:
    if x mod 3 == 0 or x mod 5 == 0:
      result += x


when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeMultiplesOf3And5(n)))
