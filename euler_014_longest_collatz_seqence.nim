from strutils import parseInt

proc collatzSequenceLength(n: int, memory: seq[int]): int =
  var m = n
  while m != 1:
    if m mod 2 == 0:
      m = m div 2
    else:
      m = 3 * m + 1
    result += 1
    if m < n:
      result += memory[int(m)] - 1
      return


proc computeLongestCollatzSequence(n: int): int =
  var
    memory: seq[int] = newSeq[int](n+1)
    maxN = 1
    maxNIndex = 1
  for i in 1..n:
    let seqLen = collatzSequenceLength(i, memory)
    memory[i] = seqLen
    memory[i] = seqLen
    if seqLen >= maxN:
      maxN = seqLen
      maxNIndex = i
  return maxNIndex



when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeLongestCollatzSequence(n)))
