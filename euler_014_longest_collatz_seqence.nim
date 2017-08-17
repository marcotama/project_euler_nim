from strutils import parseInt

proc collatzSequenceLength(n: int): int =
  var n = n
  while n != 1:
    if n mod 2 == 0:
      n = n div 2
    else:
      n = 3 * n + 1
    result += 1


proc computeLongestCollatzSequence(n: int): int =
  var
    maxN = 1
    maxNIndex = 1
  for i in 1..n:
    let seqLen = collatzSequenceLength(i)
    if seqLen >= maxN:
      maxN = seqLen
      maxNIndex = i
  return maxNIndex



when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeLongestCollatzSequence(n)))
