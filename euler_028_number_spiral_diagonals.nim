from strutils import parseInt

proc computeNumberSpiralDiagonals(w: int): int =
  let t = w div 2 - 1
  return 1 + 16*t*(t+1)*(2*t+1) div 6  +  36*t*(t+1) div 2  +  24*(t+1)


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeNumberSpiralDiagonals(n)))
