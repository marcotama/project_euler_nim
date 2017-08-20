from strutils import parseInt
import tables

proc findPeriodLen(dividend, divisor: int): int =
  var
    dividend = dividend
    # remember at which iteration we saw each dividiend
    pastDividends = newTable[int, int]()
    i = 0
  while not pastDividends.hasKey(dividend) and dividend != 0:
    pastDividends[dividend] = i
    dividend = dividend mod divisor * 10
    i += 1
  if dividend == 0:
    return 0
  else:
    return i - pastDividends[dividend]



proc computeRecyprocalCycles(n: int): int =
  var
    maxN = 0
    maxD = -1
  for d in 1..<n:
    let rcl = findPeriodLen(1, d)
    if rcl > maxN:
      maxN = rcl
      maxD = d
  return maxD



when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeRecyprocalCycles(n)))
