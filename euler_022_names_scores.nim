from strutils import parseInt
import algorithm
import future

proc computeNamesScores(names: seq[string]): int =
  var names = sorted(names, system.cmp)
  for i in 0..<names.len:
    let name = names[i]
    var nameTot = 0
    for c in name:
      nameTot += ord(c) - ord('A') + 1 # let the compiler optimise this
    result += nameTot * (i + 1)


when isMainModule:
  let nLines = parseInt(stdin.readLine())
  let data = lc[ stdin.readLine() | (x <- 1..nLines), string]
  stdout.writeLine($(computeNamesScores(data)))
